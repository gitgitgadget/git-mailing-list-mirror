From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Sat, 7 Apr 2012 00:30:04 +0300
Message-ID: <CAMP44s3rBSsMQfa4QPsGyfOi2uf6neY4aADFRCuJXhnFJV=2tQ@mail.gmail.com>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
	<87d37kr6a9.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Pierre Habouzit <madcoder@debian.org>,
	Michael Witten <mfwitten@mit.edu>,
	Pascal Obry <pascal@obry.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Brown <git@davidb.org>, Adam Roben <aroben@apple.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Matthew Wilcox <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Apr 06 23:30:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGGjV-0002MY-Bs
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 23:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757099Ab2DFVaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 17:30:07 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41193 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab2DFVaG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 17:30:06 -0400
Received: by wgbdr13 with SMTP id dr13so2479583wgb.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 14:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zWoMVHKX+LO8lVuzMd7IsYfNSw124Gbr7TfIW4jiPUM=;
        b=LcPY/X9b9T3VMS0KBH2LDZheKOw7dSGavf5YAEtXhCUwGwoKckV5HyzHGsIWhdn8k/
         3V/hI5gb2UTkbjas6NVh+/uFAbPpDSW7+Id+7bCa0WVSKkrO2Ty86Q7a3L8qHEz0kmDX
         TAyYujnY6HsHa7LJ3+5G5F5wiAVD8xAC6mcL70dfu6mijrpmpqdjEN1gjb2Wy+FTETDu
         As61MVuCysQckUBWgh7lySk0DMO4V2KF3oTT5ps+FjhI+GVF8Vy3/E7Z1bseuF02lT57
         NhhucA195LYhS4YwBqtvfDsn8H6ahSe4hB7j/112+dg3kr6BV2Exui6qZYoW1IcorLKk
         oFpQ==
Received: by 10.216.138.17 with SMTP id z17mr4692610wei.18.1333747804896; Fri,
 06 Apr 2012 14:30:04 -0700 (PDT)
Received: by 10.216.70.4 with HTTP; Fri, 6 Apr 2012 14:30:04 -0700 (PDT)
In-Reply-To: <87d37kr6a9.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194910>

On Fri, Apr 6, 2012 at 10:47 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Some mail servers (Microsoft Exchange) mangle the 'From' header, so
>> while applying the patches, the author has to be fixed manually.
>>
>> This option allows to always specify the author of the commit in the
>> body of the message, even if the committer is the author.
>
> I imagine a user forced to send her email over such a broken server
> would have this problem all the time. =C2=A0Wouldn't a config option =
be in
> order?

There is a config option, but I guess I forgot to add the documentation=
=2E

Cheers.

--=20
=46elipe Contreras
