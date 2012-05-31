From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] merge-recursive: remove i18n legos in conflict
 messages
Date: Thu, 31 May 2012 08:52:22 -0500
Message-ID: <20120531135222.GB10523@burratino>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com>
 <1338469482-30936-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 15:53:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa5nr-0004IG-Cu
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758072Ab2EaNwf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 09:52:35 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35097 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757409Ab2EaNwe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 09:52:34 -0400
Received: by yenm10 with SMTP id m10so796866yen.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QPOpeFmmrBzqKw3i38NOLLbxhlxJOruaqj3Sgu+Uds8=;
        b=E2U7dfxWEkfxCuEtkfEms9pJ4f0s1Xx64mqLmNt1fkQ00UoPLdyqBEpKlTEgzcdTfa
         bzQWCwO+A4L62ApipVmYUbPBa5lLBTF9RL3glxOJF+6fgWMBl2oWzWbaCn8N+KHVA2HA
         GQRRiuCPQ/ssvwAhk6jyr95noyx9NKFqIl3DNr+aA2Euk4S4w50B3+WhLXRBJM/UTUBY
         eupMMfSCLYQbV0JBp6pOs/zM6t0HDmaXcz4sLexB5XEu4ArpEsr283NEL+IQtfrKApAU
         MNgFSbRBPmzNRdx2IaadknpU1UfJoskZktYseXGNvtIhtwL+eAiLnR9ozDAUNiZ+ZC4f
         inJw==
Received: by 10.50.202.100 with SMTP id kh4mr1771522igc.43.1338472353520;
        Thu, 31 May 2012 06:52:33 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id nh1sm1514182igc.11.2012.05.31.06.52.30
        (version=SSLv3 cipher=OTHER);
        Thu, 31 May 2012 06:52:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1338469482-30936-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198900>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> +	const char *msg[] =3D {
> +		"CONFLICT (rename/delete): %s deleted in %s and renamed in %s. Ver=
sion %s of %s left in tree.",
> +		"CONFLICT (modify/delete): %s deleted in %s and modified in %s. Ve=
rsion %s of %s left in tree.",
> +	};
> +	const char *renamed_msg[] =3D {
> +		"CONFLICT (rename/delete): %s deleted in %s and renamed in %s. Ver=
sion %s of %s left in tree at %s.",
> +		"CONFLICT (modify/delete): %s deleted in %s and modified in %s. Ve=
rsion %s of %s left in tree at %s.",
> +	};

Is lego by sentence ok?  i.e., having 4 translated messages:

	CONFLICT (rename/delete): %s deleted in %s and renamed in %s.
	CONFLICT (modify/delete): %s deleted in %s and modified in %s.
	Version %s of %s left in tree.
	Version %s of %s left in tree at %s.
