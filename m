From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 35/42] rev-parse: prints --git-dir relative to user's cwd
Date: Fri, 29 Oct 2010 10:06:27 -0700
Message-ID: <AANLkTikO5N3JWYCJ0c8AQXra274NfAx9X0aUQTwsOGiw@mail.gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com> <1288334934-17216-36-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 19:06:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBsPm-0001jQ-Dn
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 19:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933901Ab0J2RGu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 13:06:50 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37902 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458Ab0J2RGs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Oct 2010 13:06:48 -0400
Received: by ywk9 with SMTP id 9so2126764ywk.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=aDeqj4aRY+D6vKflXtv2oLwgKnBdK0X/zMvmRPz0mDU=;
        b=kZFKobHTmLNH95PNWYVPXPCkYOqkH+aCP/mvCEAREId85Q3dYLMbPCsfpqiAiXAMsz
         i1jdAjwRbmzDVqFvLTq71JuBNMcDfBnoY0b/OtpaAp/+JZH8T5iXi1RNH2gS2b8YW/LP
         iOzirKFvGlAsy2jhjfJD6vDTII/ezvbcfw66c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ubzQJZI3OKR2fhIuKC253AUvKPc3ZC/xZdiGEWUID8tWsAhOpx0BBdWq9LHZd9DxG4
         EpoaRE+Ue7b0HsQK8cwOoxF+97cq0VbKMC3SR6PvW0mtkzlYrzFRLCHidSM0U85HHeWE
         OquSOVK3//mzuI4xSWruMdpIkTkq4B2Fcbbx0=
Received: by 10.150.196.2 with SMTP id t2mr4385112ybf.205.1288372008012; Fri,
 29 Oct 2010 10:06:48 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Fri, 29 Oct 2010 10:06:27 -0700 (PDT)
In-Reply-To: <1288334934-17216-36-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160342>

Heya,

2010/10/28 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
> git-rev-parse.txt does not say much about this. But I'm sure
> git-sh-setup.sh wants "git rev-parse --git-dir" be relative to user's
> cwd.

We don't usually use "I" in commit messages, was this meant for after
the triple dash, or does this commit message just need work?

--=20
Cheers,

Sverre Rabbelier
