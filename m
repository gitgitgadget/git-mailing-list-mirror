From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 01/11] ref-filter: add "%(objectname:size=X)" option
Date: Tue, 28 Jul 2015 21:24:09 +0530
Message-ID: <CAOLa=ZSWb6CKp2M6QRkSmdyf6XNJ_9kYTOuPHiw2_cU6JU3MHQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <vpqio941xn5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 17:54:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK7DI-00074j-VZ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 17:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbbG1Pyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 11:54:40 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36103 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbbG1Pyk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 11:54:40 -0400
Received: by obnw1 with SMTP id w1so87259383obn.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=U9g7vxF1x65LWA4JOVtrTPBNzCHCm0MOdfMDqKOccas=;
        b=P1l9jnpUDNs4txm1OxX0DeUfSvUm1cRR4DPlkrU85tZ4YH2YIQtAnXQ/xvfmbdxelE
         0wCARh9BkKTgto8jB8AF5+py1SfIqH7MHMgqY6gMTCejmB7tWupNOnTyxpN+d8IzhECt
         pS3A7ARj/nHorC9zrfarRD5pE2fpnqOCRZvecxnNA/cvqRtR8XWIlE9BUDJcafXvTu/o
         Ahw0Xl6ldE+oSbMvt3JrEnPtOZmryNSPbPHyhzxSZItgIfNgE30HTQ47oawWpxD57edd
         N7A06TDnDcfhiVWkGY9TjS5aZSSwaAhZBkeOGNiPKGN5LhczzOXi5eziRTvZp2gulu2N
         yjtA==
X-Received: by 10.60.41.138 with SMTP id f10mr34475344oel.84.1438098879213;
 Tue, 28 Jul 2015 08:54:39 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 08:54:09 -0700 (PDT)
In-Reply-To: <vpqio941xn5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274779>

On Tue, Jul 28, 2015 at 2:12 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +     if (skip_prefix(name, "objectname:size=", &p)) {
>> +             unsigned int size = atoi(p);
>
> You have the same problem as for tag.c: don't use atoi, and make
> accurate error checking (absence of value, negative value, non-integer
> value).
>
> If you have other higher-priorities task, leave a temporary comment
> /* FIXME: ... */ or /* TODO: ... */ and make sure you have no such
> comment when you drop the "RFC" in the subject of your emails.
>

It's a small change, will fix it with the drop in RFC :)

-- 
Regards,
Karthik Nayak
