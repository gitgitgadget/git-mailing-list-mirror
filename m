From: kap4lin <kap4lin@gmail.com>
Subject: Re: make install error
Date: Thu, 28 Jan 2010 11:25:18 -0500
Message-ID: <daef5be81001280825y7d2fefd7x9c41c4f202294fd5@mail.gmail.com>
References: <daef5be81001271658y4188445bofea2e3d576df91e5@mail.gmail.com>
	 <7v8wbjndn6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 17:25:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaXBV-00026l-9o
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 17:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947Ab0A1QZW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 11:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755782Ab0A1QZV
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 11:25:21 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:36768 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab0A1QZU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 11:25:20 -0500
Received: by fxm20 with SMTP id 20so852729fxm.21
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=RY/9mwrX12qT8a6u0GcodDlESvxQeVfAJSkeWc1x+u8=;
        b=kP0CMdagNW31orEiW5Kh/6HgHe2Wd5NLTIbYIidW190h6EM6FGTC92FPUozkoWafDP
         UGOPANMTiBxCca7ku57r/P5WSsaS0TvPp0IFfFWoYuyF7uCTbd0QoSN2YyYp8zrq3xpF
         UGsHp+3+zEUGxTIn2IB6qHFZmpDWgCUkUqxs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=E5HrbuNxuK0kOcDrslEX+w6gTVvWdr7G3Zlpqm2MVNOPV9PnGgV6KOEXM+1oV64ISP
         qupqOQxrBlAp6V5pOrE0un880tCpS2l8C/YNRy4ixoGJTRynqYbOZIDybFZ/R8mOD37l
         DHJpQr1AR3Diml8MIhfiVRXVvMucTO4rjwnh0=
Received: by 10.216.89.139 with SMTP id c11mr1412800wef.198.1264695918700; 
	Thu, 28 Jan 2010 08:25:18 -0800 (PST)
In-Reply-To: <7v8wbjndn6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138256>

Hi,

(Kindly Cc me, thanks.)

On Wed, Jan 27, 2010 at 9:53 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> kap4lin <kap4lin@gmail.com> writes:
>
>> (cd blt && gtar cf - .) | \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 (cd '/scratch/kap4lin/usr/share/git-core=
/templates' && umask
>> 022 && gtar xof -)
>> gtar: This does not look like a tar archive
>> gtar: Skipping to next header
>> gtar: Archive contains obsolescent base-64 headers
>> gtar: Error exit delayed from previous errors
>> make[1]: *** [install] Error 2
>> make[1]: Leaving directory `/scratch/kap4lin/softwares/git-1.6.6.1/t=
emplates'
>> make: *** [install] Error 2
>>
>> Any help?
>
> Perhaps "unset CDPATH".

Thanks. This solved the issue. I'll make a note of this in future.

--=20
Regards
Kap4Lin
--------------------------------------
http://counter.li.org  #402424
