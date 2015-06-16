From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/describe: improve one-line summary
Date: Tue, 16 Jun 2015 13:21:16 -0700
Message-ID: <xmqqk2v35rr7.fsf@gitster.dls.corp.google.com>
References: <CAKEGsXTY_rstoK4Gcga6XqkqKCeOkXdL-TjAWUu0Cqi6mWW7bA@mail.gmail.com>
	<1434460598-23201-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: albertnetymk@gmail.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 16 22:21:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4xML-0003gh-2v
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 22:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062AbbFPUVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 16:21:21 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37849 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbbFPUVU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 16:21:20 -0400
Received: by igbsb11 with SMTP id sb11so22704632igb.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9VuBeIkvQoftUlJ5fZfZi4DfHGRbXyk+vZXd+vaMYA8=;
        b=kaFwgv6pwz2ltQxSyLeNTkxTq2tVqZhZUUOdQkvr3/SQfyZzvoey+74KZdZFheOUMZ
         LFq1kFwQ/sxS7QTAiFdT98WmvjRND/PlnBsRNqX9nlYBA2FZOKzo0Y6+98R6cqHdO/zu
         MXyqc9umX2qzF8UDtVEKQETqr4cvZw9/5s3Pioh1W7KuOTTMUQa0b2tiupBNIHY9arnq
         xXgiC1GDuAmzQcI2bkx12WySqYruuxjJjcjkRmYOIanlQTOCaGrsGsNzNtRcljuy6a37
         WclQ4cpMsiXjTjn9u6q51U2S+/0d50S6ihafYPa8OlmKNI2oHlK00xeXsxM7uq841Y4h
         4g1Q==
X-Received: by 10.50.43.194 with SMTP id y2mr29877211igl.35.1434486079719;
        Tue, 16 Jun 2015 13:21:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6c2b:219c:23d9:cf91])
        by mx.google.com with ESMTPSA id h10sm1179285iod.44.2015.06.16.13.21.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jun 2015 13:21:17 -0700 (PDT)
In-Reply-To: <1434460598-23201-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Tue, 16 Jun 2015 15:16:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271795>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index d20ca40..e045fc7 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -3,7 +3,7 @@ git-describe(1)
>  
>  NAME
>  ----
> -git-describe - Show the most recent tag that is reachable from a commit
> +git-describe - Describe a commit using the most recent tag reachable from it

While it feels a bit funny to describe a "describe" command as "that
which describes", this definitely is an improvement.

Thanks, will queue.
