From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Stack overflow at write_one()
Date: Sat, 19 Nov 2011 15:30:35 -0800
Message-ID: <CAJo=hJv2aGEFcMjTPxJsyLerqUn3w3hc3hWnc1ScaDrSGihzyQ@mail.gmail.com>
References: <4EC81131.2010704@cesarb.net> <7vty5zizwn.fsf@alter.siamese.dyndns.org>
 <4EC823A0.3010603@cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Cesar Eduardo Barros <cesarb@cesarb.net>
X-From: git-owner@vger.kernel.org Sun Nov 20 00:31:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRuNC-0004pc-EW
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 00:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab1KSXa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 18:30:57 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39053 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab1KSXa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 18:30:56 -0500
Received: by yenq3 with SMTP id q3so3641960yen.19
        for <git@vger.kernel.org>; Sat, 19 Nov 2011 15:30:56 -0800 (PST)
Received: by 10.236.161.103 with SMTP id v67mr12466131yhk.87.1321745456109;
 Sat, 19 Nov 2011 15:30:56 -0800 (PST)
Received: by 10.147.167.10 with HTTP; Sat, 19 Nov 2011 15:30:35 -0800 (PST)
In-Reply-To: <4EC823A0.3010603@cesarb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185712>

On Sat, Nov 19, 2011 at 13:46, Cesar Eduardo Barros <cesarb@cesarb.net> wrote:
> Em 19-11-2011 19:08, Junio C Hamano escreveu:
>>
>> Already found the real cause (jGit bug) and workaround posted, I think.
>
> I presume the cause then is what was fixed by
> http://egit.eclipse.org/w/?p=jgit.git;a=commit;h=2fbf296fda205446eac11a13abd4fcdb182f28d9
> ?

Yes. The AOSP servers were all updated with the above JGit patch, so
the servers are no longer sending duplicate objects. But yes, for a
period of time there were duplicates in the kernel repositories,
particularly kernal/omap.
