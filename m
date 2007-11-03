From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-format-patch: Number patches when there are more
	than one
Date: Sat, 3 Nov 2007 17:03:23 +0100
Organization: glandium.org
Message-ID: <20071103160323.GA13284@glandium.org>
References: <Pine.LNX.4.64.0710221044080.25221@racer.site> <1194104694-12530-1-git-send-email-mh@glandium.org> <472C9AFC.3000509@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	spearce@spearce.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 03 17:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoLVP-0000er-0q
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 17:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195AbXKCQFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 12:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756186AbXKCQFA
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 12:05:00 -0400
Received: from vawad.err.no ([85.19.200.177]:57137 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754919AbXKCQE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 12:04:58 -0400
Received: from aputeaux-153-1-38-67.w82-124.abo.wanadoo.fr ([82.124.130.67] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoLUU-0006wd-Qg; Sat, 03 Nov 2007 17:04:57 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoLT1-0003Sl-Kp; Sat, 03 Nov 2007 17:03:23 +0100
Content-Disposition: inline
In-Reply-To: <472C9AFC.3000509@op5.se>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63287>

On Sat, Nov 03, 2007 at 04:59:56PM +0100, Andreas Ericsson wrote:
> Mike Hommey wrote:
>> Automagically enable numbering if we output more than one patch.
>> Signed-off-by: Mike Hommey <mh@glandium.org>
>> ---
>> On Mon, Oct 22, 2007 at 10:44:12AM +0100, Johannes Schindelin wrote:
>>> Hi,
>>>
>>> On Sun, 21 Oct 2007, Andreas Ericsson wrote:
>>>
>>>> [PATCH 1/1] looks a bit silly, and automagically handling this in 
>>>> git-format-patch makes some scripting around it a lot more pleasant.
>>> I think you should not use "-n" if you do not want to have the numbers.  
>>> In circumstances as yours, where you can have patch series larger than 
>>> one, I imagine that the "[PATCH 1/1]" bears an important information, 
>>> which is not present in "[PATCH]": this patch series contains only one 
>>> patch.
>>>
>>> IOW I do not like your patch: too much DWIDNS (Do What I Did NOT Say) for 
>>> me.
>> How about the contrary ?
>
> Works for me. How does one turn it off?

Does it make sense to turn it off ?

Mike
