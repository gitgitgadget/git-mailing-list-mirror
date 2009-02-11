From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Re: [RFC PATCH] git-sh-setup: Use "cd" option, not /bin/pwd, for
 symlinked work tree
Date: Wed, 11 Feb 2009 06:44:41 -0800
Message-ID: <4992E459.1060401@oak.homeunix.org>
References: <7viqq1hghw.fsf@gitster.siamese.dyndns.org> <1233977068-24861-1-git-send-email-marcel@oak.homeunix.org> <alpine.DEB.1.00.0902071324230.10279@pacific.mpi-cbg.de> <498F2049.9030608@oak.homeunix.org> <alpine.DEB.1.00.0902082154450.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	ae@op5.se, j.sixt@viscovery.net, git-dev@marzelpan.de,
	win@wincent.com, benji@silverinsanity.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 11 15:46:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXGM2-00057O-IB
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 15:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706AbZBKOoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 09:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755346AbZBKOoy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 09:44:54 -0500
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:34308 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754193AbZBKOoy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 09:44:54 -0500
Received: (qmail 55089 invoked from network); 11 Feb 2009 14:44:53 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.103.6 with plain)
  by smtp119.sbc.mail.sp1.yahoo.com with SMTP; 11 Feb 2009 14:44:52 -0000
X-YMail-OSG: Y87VWAsVM1nXUOpVrLGCGK_J06CbJ5jrJby1v24k8aYdweIwEoJd34mvtlmn0UdASWUU.uJEPw3E83xJZq3y3sBI98ZQcr9VXbkTp7SoW0EDD1TJAha0UTdtdIN89IU_LIOxGghAroWicZ.UHjlgrBIS
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LXGKZ-0001cD-2T; Wed, 11 Feb 2009 06:44:51 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <alpine.DEB.1.00.0902082154450.10279@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109421>

Johannes Schindelin wrote:
> On Sun, 8 Feb 2009, Marcel M. Cary wrote:
>> Johannes Schindelin wrote:
>>> On Fri, 6 Feb 2009, Marcel M. Cary wrote:
>>>> While the "-P" option may be slightly less commonly supported than
>>>> /bin/pwd,
>>> Does this not suggest that your patch should at least fall back to
>>> using /bin/pwd when it was detected that "cd -P" does not work?
>> Having the "cd -P" strategy fall back to /bin/pwd negates most of the
>> value I saw in using the simpler strategy.
>>
>> I haven't found cases where "cd -P" is more correct.
> 
> Actually, it was not clear for me how much you researched the portability 
> of "cd -P".

I have not.  I've seen only that it's POSIX, is on BSD and Linux, and
was suggested by Junio.

> As long as it is not proven that your patch keeps working setups working, 
> I think you'll have to put in a bit more effort, research it, and then put 
> the discussion into the commit message.

Actually, since I haven't heard any continued interest in following up
with the suggestion to use "cd -P", I don't see much benefit myself, and
there is concern about it not being compatible enough, I'm content to
just table this.

I agree that keeping working setups working is important, and it seems
like a major project to research portability of "cd -P" on a list of
platforms that I'm guessing I'd have to collect myself.

Marcel
