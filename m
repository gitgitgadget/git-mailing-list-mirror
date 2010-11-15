From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Multiple clients accessing git over NFS
Date: Mon, 15 Nov 2010 06:56:32 +0530
Message-ID: <AANLkTi=4D+yoeN9=aKNw4y_Um_F9WhUCPDaU5FZkY4QF@mail.gmail.com>
References: <AANLkTimyFkVFAw4s2fiWKZFPvnx15K6U6GbxmRgznx7Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Khawaja Shams <kshams@usc.edu>
X-From: git-owner@vger.kernel.org Mon Nov 15 02:26:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHnqQ-0006Vk-AI
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 02:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343Ab0KOB0f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 20:26:35 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52040 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757223Ab0KOB0e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 20:26:34 -0500
Received: by ewy8 with SMTP id 8so490109ewy.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 17:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lZ/LpdwHQ7wq60u2UK0JuYVfYFPYZhXRFsWbwmqGaC4=;
        b=UMFnG4bo6rSBLycy7zgKfwxVUVHQpFdCsymTGe8oNYIcIs8ttoHIzWVlFyV69lLGes
         zG8YYHrVBVRoa67yOBjI9RVIb1Hjaryb9XaJnams3m2kti+k6XREksxorzr/8XtNOL5m
         GRnM9z8RtWZbPfdyUmNKzDsK1fymr1i/wPB0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eeFUUE+WO84CG29VpIIq2o6rj8mHSi7krq0fq3TrQqKqbJdipRtv4SYc9iL4PvTaYB
         8ynniM3+ivxEOF4bZCotU9qnz6e5Yjx8N1rftyY2tHke2VUA46b6tbrBCSBsR4x1wSL9
         N08u9agWBMbJYCHX5H3/f0WvPJ5OQS+SWPa2g=
Received: by 10.213.30.20 with SMTP id s20mr4277241ebc.16.1289784392255; Sun,
 14 Nov 2010 17:26:32 -0800 (PST)
Received: by 10.213.35.68 with HTTP; Sun, 14 Nov 2010 17:26:32 -0800 (PST)
In-Reply-To: <AANLkTimyFkVFAw4s2fiWKZFPvnx15K6U6GbxmRgznx7Z@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161469>

On Mon, Nov 15, 2010 at 2:54 AM, Khawaja Shams <kshams@usc.edu> wrote:
> =C2=A0=C2=A0Is it a recommended practice to share a repository over N=
=46S, where
> multiple clients can be pushing changes simultaneously?=C2=A0 In our

http://permalink.gmane.org/gmane.comp.version-control.git/122670

may be useful...

> production environment, we have a Git repository setup behind
> git-http-backend. We would like to place multiple Apache servers
> behind a load balancer to maximize availability and performance.
> Before we proceed, we wanted to check to see if this practice has a
> potential to cause repository corruption. If there are other ways
> others have solved this problem, we would be very interested in
> learning about those as well. Thank you.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Sitaram
