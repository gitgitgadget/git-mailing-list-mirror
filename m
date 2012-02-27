From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v6 00/11] Column display
Date: Mon, 27 Feb 2012 15:14:06 +0700
Message-ID: <CACsJy8BbryVXCXbPRmOv0mPcwMNOjgEe2W1bW-Aisn3YiK5=Aw@mail.gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <7vaa45dwq7.fsf@alter.siamese.dyndns.org> <CACsJy8AyZcNSPEY8S0WczVu0ychGKr61BoBm0iy39ZsVM=zHpA@mail.gmail.com>
 <7v8vjpcaz3.fsf@alter.siamese.dyndns.org> <7vipisbtw0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 09:14:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vjG-0006Vv-BY
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 09:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab2B0IOh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 03:14:37 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54334 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2B0IOh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 03:14:37 -0500
Received: by wgbdr13 with SMTP id dr13so1436091wgb.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 00:14:36 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.92.227 as permitted sender) client-ip=10.180.92.227;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.92.227 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.92.227])
        by 10.180.92.227 with SMTP id cp3mr25655420wib.13.1330330476261 (num_hops = 1);
        Mon, 27 Feb 2012 00:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=r1lXeRqiRwIXdiIhrrlfpMm3b6Qf4SYCYPNgwEpsaSU=;
        b=EQy0Am9LFVSw0WBGYiavGrknGjbuz9GthP//FgxskT9DDWEEPyaDV+C5jBParoD9D9
         fSa8QyTZRbxQM7tozEy98HmVOnQq2OV7Q++skJerULYaHe3wC8fHhrr7dsOV/RzJfFVS
         DpR/vAtOJ/Lz4sWc3HOdgGbHXpCrPw3AlaX+I=
Received: by 10.180.92.227 with SMTP id cp3mr20360593wib.13.1330330476221;
 Mon, 27 Feb 2012 00:14:36 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Mon, 27 Feb 2012 00:14:06 -0800 (PST)
In-Reply-To: <7vipisbtw0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191617>

On Mon, Feb 27, 2012 at 2:46 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Come to think of it, that is really the same distaste I had against b=
oth
> "diff --no-index" and "grep --no-index". =C2=A0We know adding our enh=
ancements
> over non-git versions of these programs is a better gift to the outsi=
de
> world, but we instead added the --no-index mode to Git to only keep t=
he
> benefit to ourselves, because it is far easier for us to do so.

Exactly. Some people like me also benefit from the popularity of Git.
If it's (likely) installed, I get many extra features for free. There
are machines that I'm not allowed to install new stuff on. If it comes
with BSD "column", not too bad. If not arghhh.
--=20
Duy
