From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Tue, 1 Mar 2011 18:22:24 +0700
Message-ID: <AANLkTimRuUdGsgkt63PspvNXXjusZeOJWMhSXQ5nS81t@mail.gmail.com>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 <7vei6t4uwa.fsf@alter.siamese.dyndns.org> <AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
 <7vy6512rnb.fsf@alter.siamese.dyndns.org> <AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
 <7vk4gkk5pd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 12:23:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuNfR-0001WT-NF
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 12:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158Ab1CALW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 06:22:56 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57874 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794Ab1CALWz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 06:22:55 -0500
Received: by wyg36 with SMTP id 36so4545888wyg.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 03:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Jrfj07plmByumka3/x2Ga1eFM0kEwzXtv2IA0v3OhFU=;
        b=TNj3ZB6MRhfcVnRsVTkDX5BuQs/c/6CriEnhG9nSD4zFUhLL0J+2UoZG8vr7aDT91R
         /CDwD01UHm2z4Hf7ctZHTIDKoaGKBSJgjcdp7YwbaCvqkZiAccSSM3N5888M2qrlxaZ+
         MVTcMUQYSRbZsxMhSfLtydl1F5pzzvpNHksZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VjLvPUh+4caa7Bq7/fAl0jgZzP+hlu50faZaidiYarlLNP/PZ2HvFqdrPyf0zrWVhy
         rvYLjXTSh6Iow8D+KEZDlaSAoqUiv+dZu3vl1+dOdXGRsmaimOXLIL7tFc+lbj0Ogu8Z
         BctFW0LpA5hZE7VVi3HW8z4WYBgUxAfeXXBvc=
Received: by 10.216.186.144 with SMTP id w16mr5902107wem.13.1298978574221;
 Tue, 01 Mar 2011 03:22:54 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Tue, 1 Mar 2011 03:22:24 -0800 (PST)
In-Reply-To: <7vk4gkk5pd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168211>

On Mon, Feb 28, 2011 at 1:56 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Perhaps the migration plan is not helpful enough? =C2=A0If that is th=
e case we
> would need to rethink it to be even less impactful.

But how many people may be impacted this way? If it's few, probably
not worth the headaches. I want to believe the number is few, but I
think anybody who ssh to some machine may have the same problem
because they may not control what's in that machine.

I can only think of another way, ugly though: add a new command name,
say "nad", that goes with new behavior, "add" remains old school. This
way if I mistakenly type 'nad' on unsupported git, it refuses and I'm
safe. Whether the new name is temporary (until the behavior flip in
"add") or permanent is another ugly matter to think about.

Or accept that evolution is painful and go with current plan, which I'm=
 OK too.
--=20
Duy
