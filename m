From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git clone 2.9.0
Date: Wed, 15 Jun 2016 20:47:20 +0700
Message-ID: <CACsJy8C7zQaAAS5+-hvan3vdJ0_gvYVaD1S5jPTNX743s+Wzaw@mail.gmail.com>
References: <0698E1D6-F967-465B-A30E-07889C28D38B@webankieta.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Wojciech_Rybi=C5=84ski?= <w.rybinski@webankieta.pl>
X-From: git-owner@vger.kernel.org Wed Jun 15 15:47:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDBAh-0004BS-51
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 15:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbcFONrv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2016 09:47:51 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:37787 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbcFONru convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 09:47:50 -0400
Received: by mail-it0-f41.google.com with SMTP id e5so21114721ith.0
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yyQHBO7WB7b+Kxh+5Jae+XdzpwbbZl4JGB68CrFgtFk=;
        b=h0FRFp2UUKr61cLNqEHzs9k6hEvdf0m3xxF3b/QGlzb/Eme3MJqgMvoFGS3H4cm7yD
         ULLxl7m9Zmqa2+v/tH7CxynhVhnRWtzfeRF2sNyKlHlU3jBaBH1u4fu0j1FbycctDJ9/
         lhYw6bmb0dzCb3CalR0kEFUcSmpr0MNAMVM7uvRQWKE0KbSakoJ8YzKUYL50PnjOjuJz
         eP3IZ9uLWmmBoCWUV8ZhYZUqAd28Uf9CcxVUxbfH5m6jKyFlVoBbvBog3xzNO7iPxBG1
         K7XZom9q0uts0Nt+LHZXFw1srG8Z1D+P0bne6AnvDOEu2lm6FM2IuGDbJyeLwjmrauP9
         fHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yyQHBO7WB7b+Kxh+5Jae+XdzpwbbZl4JGB68CrFgtFk=;
        b=STqTJ51K54j1vcEYhQx38EPzr1fQnqI6A4JGxBuCzgfCF+UP7gy39NTeucYrPrtE9A
         eH2aOlYX3HRBlgLTqiJuAiDkT+/yc1Xx8KMYtWb/JEATB3eV+DRyIlofkpAJqEOJrIEI
         KE6VN3XhN32IG9gqcd+Pw3RIFp9tiecjnHUBbsbJrXTXf5lg9CEHFC9R54fecT+zUxP+
         T7mDWuG3q84JQ4v2eYHgn/QKMtVEMjNEyIsmVVgxyGW0dI9RY3c+XP/NpVbncsEjDs8r
         637o9LRTylHuuK262RcO3TDyr0swC4ckIRu6CUtzu++7k4EJF9bV7BfaRjC8X1CI2Bbc
         Athg==
X-Gm-Message-State: ALyK8tLLOTeZWjLorCPJLHG9TImIpNKq2apajfURHURNmdeekvmD7ZvJZLt18/jgDGJBCo2AC5MOnirHCQN7LQ==
X-Received: by 10.107.8.220 with SMTP id h89mr40760990ioi.95.1465998469741;
 Wed, 15 Jun 2016 06:47:49 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Wed, 15 Jun 2016 06:47:20 -0700 (PDT)
In-Reply-To: <0698E1D6-F967-465B-A30E-07889C28D38B@webankieta.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297371>

On Wed, Jun 15, 2016 at 8:08 PM, Wojciech Rybi=C5=84ski
<w.rybinski@webankieta.pl> wrote:
> Hi,
>
> I have installed version 2.9.0 and when I=E2=80=99m trying to clone r=
epo with specific tag I get error: unknown option `single-branch=E2=80=99=
 and next warning: Remote branch a3.0.26 not found in upstream origin, =
using HEAD instead. My command looks like that: git clone --single-bran=
ch -b a3.0.26 git@=E2=80=A6 and it=E2=80=99s working with git version 2=
=2E7.4 on another machine. What should I do to clone repo with this tag=
 using version 2.9.0? I found info that this option is enable in this v=
ersion.

I can't reproduce. What does this command show to you?

GIT_TRACE=3D1 git clone -h
--=20
Duy
