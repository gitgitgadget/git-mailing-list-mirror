From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] git-diff.txt: group the [--] and [<path>...] templates
Date: Thu, 25 Apr 2013 00:23:38 +0530
Message-ID: <CALkWK0nN+9XOTCqiY+yB9moQSvFFpSO=OZjJtLphBd2eQ24uDw@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-4-git-send-email-artagnon@gmail.com> <7vtxmvdc4d.fsf@alter.siamese.dyndns.org>
 <CALkWK0nU-iTSF2DnmJAB=kj6w+VFv3rQrixEnHz0vyXf2d2=Mw@mail.gmail.com> <7vbo93db25.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4pk-0002iY-1k
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756390Ab3DXSyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:54:19 -0400
Received: from mail-ia0-f175.google.com ([209.85.210.175]:58407 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab3DXSyT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:54:19 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so1964470iae.34
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mxdj1Cr8NysqcL1LrGdsd1YkGJ5wynDkSoCh3OwziBU=;
        b=IfmkoG4WhKbqQDHGGeJwZEHYRMwnNlR9sQAaSMmGaSErpY/e7pmmlfYWt+QojExQii
         XCSlf9V+8GDhwCnP2w+2PZR/htIuyogB5wM9RCchPLuAn82u689yptyGQt6ihLB2kp/2
         9FavTdfzsIIRbZFqxq+voKAQeUXmOLkTK/NK2vceDU1itFkJJkEkpiM5p6ofo6OnLp8Y
         cr1QNWIO2W8GpwXBwPy/P05M/wosWYlwfbypkwhyeybK7fWzutZtRig1btVx4vujfi6+
         FoPBaV37FUFq2SP5evrzWXdfnzWbAYGJvH9crgeJypr3F3x4iX9DBP5QZk7Ff1s4nYwI
         uy1w==
X-Received: by 10.42.123.66 with SMTP id q2mr14070561icr.12.1366829658818;
 Wed, 24 Apr 2013 11:54:18 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 11:53:38 -0700 (PDT)
In-Reply-To: <7vbo93db25.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222293>

Junio C Hamano wrote:
> The same logic would apply to this semi-nonsense rewrite, no?
>
>         git diff [[options] [--]] [<path>...]
>
> Everything else comes before "--" (if exists) that separates it from
> the list of pathspecs.

Yeah, except it's sometimes

    [[options] [revision range] [--]] [<path>...]

and other times

    [[options] [<commit>...] [--]] [<path>...]

and yet other times

    [[options] [--]] [<path>...]

Whereas mine is always

    ... [[--] [<path>]]

(everywhere in git)
