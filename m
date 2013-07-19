From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git Clone Parameter
Date: Fri, 19 Jul 2013 21:17:07 +0530
Message-ID: <CALkWK0nRDxV-m4Bwr2Q7kbzQr8K++0nTDqzeh=tfA=a7ahAs7A@mail.gmail.com>
References: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com> <7v4nbqzj7u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Allan Acheampong <allanadjei@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 17:47:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0CuO-0007nv-2R
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 17:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760619Ab3GSPrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 11:47:48 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:38259 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab3GSPrr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 11:47:47 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so1486689iea.31
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZSTFDU5cZOSlYm9fVW1x+OuwX4fru/znWbgXRfbiYGk=;
        b=1BnWEV7vCO4F85GCPH1yu5RC2lPyasxpOBZ3MlVnCHDCX0oFoyRVFq2mvNPKijsQs6
         tsk2vMFV7U3Y9SvfBPsHrG4CtjMyilm5egV5fAa9avQFtKllODxinrNdULA1jgk/mKza
         YQZxv/KxvyygDk+fXb44nl92rbMp8OE41uw23RJli7K3CsaV/4pQtK8OS5zXQhGQvDQF
         dXX0+Z5AIx9UM5k6RNIjTEVAjL31abIjypKpVFj4tlLk6e9rD7Yc9SRgFGQyYel1X1a/
         GE4tx4Sim3F6lJSwLAwDPhu/MRiMpqhR4GocxoVkcxH3Td+2dm9bBGAaNcAfoS6Hfh1I
         sCHw==
X-Received: by 10.43.88.3 with SMTP id ay3mr10852617icc.61.1374248867359; Fri,
 19 Jul 2013 08:47:47 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 19 Jul 2013 08:47:07 -0700 (PDT)
In-Reply-To: <7v4nbqzj7u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230819>

Junio C Hamano wrote:
>               git branch -t "$branchname" "origin/$branchname"

A couple of notes here:

1. I use git branch -u personally.  Why the -t variant?
2. Don't we auto-track? (or is that only on checkout)
