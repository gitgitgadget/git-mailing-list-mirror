From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v4 0/3] git-p4: fix Git LFS pointer parsing
Date: Thu, 28 Apr 2016 08:34:09 +0200
Message-ID: <CAHGBnuN93Pz_CDxajugnFbaPhrQNpH6b_8D5rahEO2DOREZJuw@mail.gmail.com>
References: <1461824793-43235-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, ben.woosley@gmail.com,
	sunshine@sunshineco.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 28 08:34:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avfWi-0008J1-5a
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 08:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbcD1GeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 02:34:12 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36067 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbcD1GeL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 02:34:11 -0400
Received: by mail-vk0-f68.google.com with SMTP id u23so2873048vkb.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 23:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=VSHqn1CsXZSoRoic3IGDCVBxuTjXsDQllV/80F/L/oA=;
        b=VFVlXKePlLo0WorrDDAmzmL4P36ukarPPlTVRFM0vLU8w+ogzp+3ZcpqyWOjrfTXLG
         iytgC9r+ZMFhyfUCJCjlnPlA2MvbAAlEOnmEsaHR0+BuRYdB9bybNp3Sw2OkI2C/we+M
         mjcWkqVnuhDvwxW3SwjL9ijWRHd3c4i5pxl0fhTqqmyu4SH6ll1A68VK8ubju79WHiBk
         iX29FqcundrBbJSumZpmD6Kw8NTqp7Dc24C1+c8Z86Esyl/8zi8FmEn+Dj4qRGUmruFb
         U178NyAotgJBrpsSVQwTQZIHtDCI9jGJyhGY7F3I3GwRb31uQZyvW6KtVzVHoe6xX6H5
         cxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=VSHqn1CsXZSoRoic3IGDCVBxuTjXsDQllV/80F/L/oA=;
        b=Alr7Nq8sbkchAbV3oDP2VixKrFlZODD8p9SWdS04RKwSpvkAMfDYQrKQLPojFF3KHO
         I7VgJh0NXCNrE1B2tgSxC7QNXCwbPJk27oOZzaaUF1cWB6S9L6lWV5GaxrNp32YsBVns
         fr4R2jd4qlbOtkYDNrfjQRfVGiU+NhDSN4MaBEh8SoabeU+N+asRgOMVhrTMwQpcCirQ
         iCoPF/zVIcj9BTtWgS5vPPkIldRMN42ZnkORr4C/NEUtzSxDvh8Xf6qGoF/WtesWabDb
         SuOy3OgQoYvdhwI9/fiJUgaR2kUNsXynYkRSTBAF5DQbi7EAmhkDqlQURvNk+HR/rHfi
         DSsw==
X-Gm-Message-State: AOPr4FWv+kPDDH+VY6jH2UcWZQh3ROFr78TR+IMa/mTNz6caZBbZmKx6hW2p3HZKxJUsU49McNGsYOUPW9MHMQ==
X-Received: by 10.176.1.197 with SMTP id 63mr6772090ual.77.1461825249514; Wed,
 27 Apr 2016 23:34:09 -0700 (PDT)
Received: by 10.176.4.132 with HTTP; Wed, 27 Apr 2016 23:34:09 -0700 (PDT)
In-Reply-To: <1461824793-43235-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292851>

On Thu, Apr 28, 2016 at 8:26 AM,  <larsxschneider@gmail.com> wrote:

> diff to v3:
> * fix missing assignment of pointerFile variable
>   ($gmane/292454, thanks Sebastian for making me aware)
> * fix s/brake/break/ in commit message
>   ($gmane/292451, thanks Eric)

The series looks good to me now.

Regards,
Sebastian
