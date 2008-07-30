From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] format-patch: Produce better output with --inline or --attach
Date: Wed, 30 Jul 2008 11:30:32 -0700
Message-ID: <B805BDA1-6C22-4488-B5F5-6DA8CC729C06@sb.org>
References: <20080730052401.GC4034@sigill.intra.peff.net> <1217396973-82246-1-git-send-email-kevin@sb.org> <alpine.LSU.1.00.0807301624410.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 20:31:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOGSU-0007IY-A4
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 20:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbYG3Sag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 14:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbYG3Saf
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 14:30:35 -0400
Received: from mail.rapleaf.com ([208.96.16.213]:34783 "EHLO mail.rapleaf.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbYG3Sae (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 14:30:34 -0400
Received: from mail.rapleaf.com (localhost.localdomain [127.0.0.1])
	by mail.rapleaf.com (Postfix) with ESMTP id D98EB1250313;
	Wed, 30 Jul 2008 11:30:33 -0700 (PDT)
Received: from [10.100.18.156] (unknown [10.100.18.156])
	by mail.rapleaf.com (Postfix) with ESMTP id 2E11012500B6;
	Wed, 30 Jul 2008 11:30:33 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0807301624410.3486@wbgn129.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90827>

On Jul 30, 2008, at 7:29 AM, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 29 Jul 2008, Kevin Ballard wrote:
>
>> MIME defines the encapsulation boundary as including the preceding  
>> CRLF (or in
>
> This line will still be too long in git log's output, as well as in  
> git
> shortlog's output.  I thought we had a suggestion to use at most 76
> characters per line in SubmittingPatches, but apparently we don't.

Good point. I'll send another re-wrapped patch.

>> The second change is to always write the line termination character
>> (default: newline) even when using --inline or --attach. This is  
>> simply
>> to improve the aesthetics of the resulting message. When using -- 
>> inline
>> an email client should render the resulting message identically to  
>> the
>> non-inline version. And when using --attach this adds a blank line
>> preceding the attachment in the email, which is visually attractive.
>
> It appears that your patch has one uncontroversial and one  
> controversial
> part, then.

Is this controversial? Nobody's objected so far. My goal with this  
change is to make the --inline output render exactly the same as the  
default output in a mail client. I can't think of any downside.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
