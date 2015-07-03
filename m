From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: Re: [PATCH v2 1/4] list-object: add get_commit_count function
Date: Fri, 3 Jul 2015 01:09:39 -0700
Message-ID: <CAKDoJU6DdSc2ux5vEJu2risW9a-cgJ7e5xBxysTFdYGMd+77Kw@mail.gmail.com>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
	<1435881011-13879-2-git-send-email-lawrencesiebert@gmail.com>
	<vpqlhex66v6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 03 10:09:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAw2d-0004qt-6S
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 10:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbbGCIJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 04:09:42 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34227 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbbGCIJk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 04:09:40 -0400
Received: by obbkm3 with SMTP id km3so65061039obb.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 01:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6o044okbdqWJaPsrl5CPN4Hj8bkN3bGf6wmZYOG4e/E=;
        b=ZQpBxGqpGTXGl9SpIX9gNx+Pdn12SXBaA1XEpVqDIrVFSajlyWSWAq0niseVLqSwPx
         FTEL9hmgE2Rq6CkQc110J5DlIwBU8Aw+YhaRWYcYLhhzshrdCBwALwaE1jddp54/2eZ6
         H6VFbrPgnc2tkmVwOAP9speGiMIUuWRDHOOLFVOS7FKjfpZYGNmizhoJXQq7Ut+szK8P
         hGWxC9oQRskVnQpNP56PxuaxTtkGcPYNPaJfRpFDdlJ6BC9KkhQNQoFxfyelfCf0TYfg
         SkeSSy+9RRMJYq12w14KgbamQMoZterxgP5ULGXfkCT+S5oVBTmZzNCykwb7sDBDzBzD
         gGzw==
X-Received: by 10.60.34.164 with SMTP id a4mr1861207oej.56.1435910979565; Fri,
 03 Jul 2015 01:09:39 -0700 (PDT)
Received: by 10.76.153.101 with HTTP; Fri, 3 Jul 2015 01:09:39 -0700 (PDT)
In-Reply-To: <vpqlhex66v6.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273285>

Mattieu,

Understood. I don't suppose there is any commonly code formatting tool
to automate formatting in the git style, is there?

Thanks,
Lawrence

On Fri, Jul 3, 2015 at 12:24 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Lawrence Siebert <lawrencesiebert@gmail.com> writes:
>
>> +void get_commit_count(struct rev_info * revs) {
>
> Please, write "struct rev_info *revs" (stick * to revs).
>
>> +void get_commit_count(struct rev_info * revs);
>
> Likewise.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/



-- 
About Me: http://about.me/lawrencesiebert
Constantly Coding: http://constantcoding.blogspot.com
