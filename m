From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: Cherry-pick with symlinks fails horribly
Date: Thu, 11 Mar 2010 15:16:09 +0300
Message-ID: <c6c947f61003110416l40a85b6fg7ede2403a8f6961b@mail.gmail.com>
References: <c6c947f61003081728u48292de4x6f2c26e1ea9c1756@mail.gmail.com>
	 <201003110557.11268.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 11 13:16:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NphJI-0005w8-09
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 13:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757758Ab0CKMQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 07:16:11 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:39200 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757754Ab0CKMQK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Mar 2010 07:16:10 -0500
Received: by pzk32 with SMTP id 32so598563pzk.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 04:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Obx8wbGQnMjaIUY5PdLVG2TPdIjT+Xyy08tXZ2axcd8=;
        b=OhV7RUsrNYs/eB0nS+ENlg2BMo2/P80SHp13HdrOGUzPm1F9DCZ3p8TB3gtWFT80Qy
         Jeb22fPTKV9f5klITA93qZcMv6k/BTlnus+r/Rcdy498ZUZkplUzkHz97fgHOKp8cVB9
         WxRXPSX8yizeeov5FJDAbpG7KFTBdnniJFpwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sKnilsor4rTszKYpSvsfmwzb73iYKB+12His03Fay1KI0ADcN/sRkusxIhili5GWIu
         KCsqcFb06wvIoEokSBOZmN23nsN90ZXmVw+OoCaDPiYjuTOROUki4n3Fez2cBfmSJAUQ
         kV0i/EBdpGTAcPZbjvLTMLVg/not/vfJlmtAQ=
Received: by 10.141.14.21 with SMTP id r21mr1744352rvi.70.1268309769572; Thu, 
	11 Mar 2010 04:16:09 -0800 (PST)
In-Reply-To: <201003110557.11268.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141957>

On Thu, Mar 11, 2010 at 07:57, Christian Couder <chriscool@tuxfamily.or=
g> wrote:
> On Tuesday 09 March 2010 02:28:30 Alexander Gladysh wrote:
>> I'm complaining about Git symlink handling again. This time it is
>> =A0cherry-pick.

> I can reproduce the bug here on Linux. And Git v1.6.0 has the same bu=
g.
> So I suspect an old bug in unpack_trees.c. I will try to have another=
 look at
> it this evening, but I am not familiar with that code.

I have found my old bug-report. There is even some patch in that thread=
=2E

http://thread.gmane.org/gmane.comp.version-control.git/120741/

Not sure if it is the same issue or if the patch was even merged in tho=
ugh...

HTH,
Alexander.
