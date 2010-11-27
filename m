From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Create a shared config file
Date: Sat, 27 Nov 2010 23:04:09 +0700
Message-ID: <AANLkTi=6Q_MB-5kjZLCha30h0A4qdjhLhWUY0mLuCuoc@mail.gmail.com>
References: <cover.1290870041.git.nathan.panike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 17:04:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMNGa-0003Gg-Nj
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 17:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab0K0QEo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 11:04:44 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59300 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab0K0QEn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Nov 2010 11:04:43 -0500
Received: by wwa36 with SMTP id 36so3129471wwa.1
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 08:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MQAQ6Up/MrONmcK/Zp+4E9LpzBqSrFndaqRT6dkYMlQ=;
        b=p01alzpMBvgb/YOj34b+5kQdGxnD0Z0LjmZErpsLxy6ofpglWkgLrNa4ESkU4VaTBt
         xwyehD+H0YlsCKiyMWNTkui3dtTXGUXn1oGCDhSDWuH14Nl1dEErI+hDKp2YC3aIBpCq
         H/67uKe6as84sZK16Xni3IaeSF7hd5df66+AI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=m8PWrVagska4rffp0V0OzH2CdZ/crMcvtUN//vNaR2Mk92cEbxdyhiVV4jkKKIxvSn
         CIQtonWTlVnCMm2gJ8LtEyqml4oB4Javzk0lt1uitoJM42qiOcSgkMZRmV64tDSxOmVg
         vfGfmQ8af4Z+6IGV9GW4MrO5bIRyz5nAFAAXk=
Received: by 10.216.91.82 with SMTP id g60mr3160559wef.49.1290873881081; Sat,
 27 Nov 2010 08:04:41 -0800 (PST)
Received: by 10.216.21.14 with HTTP; Sat, 27 Nov 2010 08:04:09 -0800 (PST)
In-Reply-To: <cover.1290870041.git.nathan.panike@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162313>

On Sat, Nov 27, 2010 at 10:00 PM, Nathan W. Panike
<nathan.panike@gmail.com> wrote:
> Configuration should normally be on a per-repository or per-user basi=
s. =C2=A0There
> are cases where it would be helpful to have a project share configura=
tion
> across repositories and between developers. =C2=A0Normally this happe=
ns only via
> e-mail or IRC or by word-of-mouth. =C2=A0The solution implemented by =
these patches
> is to have a .gitconfig file in the toplevel of the repository.

Or save the shared config in the repository and add an instruction in
$GIT_DIR/config to include such config blob. We can worry less about
malicious config that way. If you are extremely nervous about it, you
can always point to a specific blob that you have checked.
--=20
Duy
