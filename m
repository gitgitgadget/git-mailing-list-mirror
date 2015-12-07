From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Dec 2015, #02; Fri, 4)
Date: Sun, 6 Dec 2015 23:01:19 -0500
Message-ID: <CAPig+cSuzptBpRvZheKwHhYyyKmTwL=WuOEY=1LeTpR3wg_GFQ@mail.gmail.com>
References: <xmqqa8pprej5.fsf@gitster.mtv.corp.google.com>
	<CAOc6etZBnB6EKiD3xD-zp-QJz20ueQzdtdJMSZz6wOH_HFZXxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 05:01:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5mzs-0004AY-1U
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 05:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbbLGEBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 23:01:21 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33189 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbbLGEBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 23:01:20 -0500
Received: by vkca188 with SMTP id a188so96219795vkc.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 20:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wnTjWzXcxjrJL52CGTdW3fqe4Kx3bp6hYjtXRs1sHh0=;
        b=Ow7YRTVKoym+wYmele7bLhIUf6eL1JtHXzqXqS0vCjK2fELm9TlSRAj4LgF1woKz3x
         jDh5idHxqaWM5okPodC8tyIq9X7v4iYsZgbKIImO24h2Oj/iAiHkfSvy4iJxKbOmBCRC
         7H6CQfWm67jLIIBpuOZqbezIgYKEt9QIVekKb7t3C5VTRc1SxOtr7HNLBr7Ie2ebEd13
         KLLI8Sv6+SVkH0o0YHwEciXc2kHPkNRz0t732HMI4IRuOpD5MDtEsDPZyCUfEPKH0Mir
         ml9RWOO1WZd/7EbqLS8NPVlzM90E83vS+QVZ3USOf8ZpSPrXw21waw2wpb1gDMRmMaEW
         C6EQ==
X-Received: by 10.31.56.18 with SMTP id f18mr16981968vka.19.1449460879607;
 Sun, 06 Dec 2015 20:01:19 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 6 Dec 2015 20:01:19 -0800 (PST)
In-Reply-To: <CAOc6etZBnB6EKiD3xD-zp-QJz20ueQzdtdJMSZz6wOH_HFZXxw@mail.gmail.com>
X-Google-Sender-Auth: SG4SlF9wHqBp5i7YPihD8ivgvYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282075>

On Sun, Dec 6, 2015 at 11:12 AM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> And, another thing, I had sent the fifth version of my patch about
> progress for blame where I took care of all the comments hat Junio
> stated before and I got no comments since. I hoped that patch would be
> listed sometime but I didn't see it in this what's cooking or the
> previous one. Maybe it's bellow your radar? Is there something else I
> can to do about it? ($gmane/281677)

v5 of that patch is still in my review queue (which keeps getting
longer rather than shorter). I did a quick read through of it when you
sent it and saw a few things deserving of comment, but haven't found
time to do a formal review.
