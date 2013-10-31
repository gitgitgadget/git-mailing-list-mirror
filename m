From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Help creating git alias
Date: Thu, 31 Oct 2013 15:31:08 -0400
Message-ID: <CAPZPVFYWf3_xtxKkdw4_gzqKagVsbNvj73cb=RvX1Zm0C1h8pQ@mail.gmail.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
	<CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
	<CAPZPVFZ9WujUCQ1O9VfV83XUu_6g7Vp_MmYRCCO+GptOoSyvcg@mail.gmail.com>
	<xmqq61sebhh3.fsf@gitster.dls.corp.google.com>
	<CAPZPVFarK_jKpM2f62mErAmL+mck6EN1QPfHDHqqfJbJ2AfzXg@mail.gmail.com>
	<xmqqk3gu9jst.fsf@gitster.dls.corp.google.com>
	<CAPZPVFYFSBRHThO08LmuN_0fc55gYX-A+Y3=yA_MESko1t6fXQ@mail.gmail.com>
	<20131031174008.GA39079@gmail.com>
	<xmqqd2ml8gbs.fsf@gitster.dls.corp.google.com>
	<20131031181509.GB39079@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	git <git@vger.kernel.org>,
	Andrew Ardill <andrew.ardill@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:31:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbxxb-0005bT-Dt
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249Ab3JaTbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:31:11 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58521 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab3JaTbK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 15:31:10 -0400
Received: by mail-wg0-f44.google.com with SMTP id n12so3207146wgh.35
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q3yTKpY8FpjHj+Rf/cX4u+t/3VGuaRfhpuntUvSy/lE=;
        b=n6yyidDdq8X+hzc56aiZ0v2alI1ALA5L+Lf4vQmRFKpZXGZ45zcgRS59R63VoGczHw
         V491HxmBAyN6UugUbijtMIDeJc3nPep9w5Bzrd9TASfxMCwq5f5x7URnhwDp8X6H6Woj
         yQImu9nQXvw7awzNA55C0JxV0pJrTdBJsvp8A3bir02YxlVgzZAEW99lZubDnZC//GYJ
         ssjXguz90jnhsgOubcqo4WDGvwdcUE8v+XfETGthvhaq1kayxQ6lWyuUHe1Nii7liq5V
         LfRRQ2fliTIg+Lp6mYgvOBmRPNKtPLx6BS/rOfNK77HIW69HIEAiucmDJvOSqAOEMDTV
         wkdA==
X-Received: by 10.194.8.137 with SMTP id r9mr3338394wja.78.1383247868783; Thu,
 31 Oct 2013 12:31:08 -0700 (PDT)
Received: by 10.216.123.145 with HTTP; Thu, 31 Oct 2013 12:31:08 -0700 (PDT)
In-Reply-To: <20131031181509.GB39079@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237164>

On Thu, Oct 31, 2013 at 2:15 PM, David Aguilar <davvid@gmail.com> wrote:
> On Thu, Oct 31, 2013 at 11:07:19AM -0700, Junio C Hamano wrote:
>> David Aguilar <davvid@gmail.com> writes:
>>
>> > A-ha.. I think adding the chdir to alias is possible using a function.
>>
>> You do not have to use a function to do so, no?
>
> Right, of course.
>
> So something like:
>
> [alias]
>         example = "!cd ${GIT_PREFIX:-.} && git log \"$@\""
>
> should do the trick.
> --
> David


Awesome! It does work!
One note: i tried the ${GIT_PREFIX:-.}  and ${GIT_PREFIX} and it seems
to give the same results. What is the expected difference here?

Thank you!
