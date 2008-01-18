From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Fri, 18 Jan 2008 20:01:18 +0100
Message-ID: <D54C77E4-D7FB-4CFC-81A6-AA4A0E66BA5D@lrde.epita.fr>
References: <4790BCED.4050207@gnu.org> <alpine.LSU.1.00.0801181545530.5731@racer.site> <4790CAF7.5010908@gnu.org> <alpine.LSU.1.00.0801181605020.5731@racer.site> <4790D5CF.8000602@gnu.org> <alpine.LSU.1.00.0801181804410.5731@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:02:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFwTW-0008RH-Sc
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 20:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764718AbYARTBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 14:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758982AbYARTBb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 14:01:31 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:58457 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758254AbYARTBa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 14:01:30 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1JFwT2-0005MW-Rj; Fri, 18 Jan 2008 20:01:28 +0100
In-Reply-To: <alpine.LSU.1.00.0801181804410.5731@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71050>

On Jan 18, 2008, at 7:06 PM, Johannes Schindelin wrote:

> On Fri, 18 Jan 2008, Paolo Bonzini wrote:
>
>>
>>> In the message hook, just grep if the template was already  
>>> added.  If it
>>> was, just return.  If it was not, add it.
>>
>> Ah, so you want me to always type ":q!" to exit and unnecessarily
>> complicate the commit-msg hook.  Cunning, but no, thanks.
>
> No, my intention was to avoid complications.  Like introducing yet  
> another
> commit hook.  I like clean, elegant semantics.  I don't like  
> overbloated
> semantics.  That's why I speak up whenever I fear it is entering git.


FWIW I'd love such a hook and I've been writing wrappers around Git  
commit for over a year now to simulate this.  I know many people with  
whom I work that would also love such a feature.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
