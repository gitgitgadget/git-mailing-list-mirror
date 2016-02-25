From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv18 00/11] Expose
Date: Thu, 25 Feb 2016 15:11:12 -0800
Message-ID: <CAGZ79kb+znOJNpzJ=jLCxN+PpJ16vbMXZivxsN9bJypRLx2X+Q@mail.gmail.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
	<1456441708-13512-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:11:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ541-00018V-7v
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbcBYXLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:11:14 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33740 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbcBYXLN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:11:13 -0500
Received: by mail-ig0-f181.google.com with SMTP id y8so25989725igp.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=TVYIVvv4+W/Vw9Xk6bCei3/LaNjYoXvq2M6k4FFHxQI=;
        b=b48BOkunVASfplo+UaBa8VnwHQnJYxPlpUey0O9vrtZQah86+EcbnWHCH9VnA1ytNk
         e7WRnrYymigM35Hh3GSMcgmvlSyDge/ZLBG8wVk4MmjzkpkKtOSIB6J9Y1BK28qAQLh/
         eeusBF1UdgeFW/IULLYlWYB5DoxKBbHvovzjxu0srcP0jhhsG9rNg21JWKpidaWlTeIt
         7J0Reme1wufT24NShhBO0yy4Z64vK/5tcS6vABqUdQXIqhJHbu7nY3HbPZKI2gKSfJiP
         ZHE8r+eYnjC1fsldCb/R8Rp+WwY9Qzdlon0xOiWJ1LUjav8byY0+2PtELsROzpvhdiKo
         qLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=TVYIVvv4+W/Vw9Xk6bCei3/LaNjYoXvq2M6k4FFHxQI=;
        b=jl5CO5MRYddVo3ryS1J5HeeDyaXzO1xDqGEof25lgulykSjKmmRkwNnFH9Auw9NhmU
         pXRqhXAaFqPDQYfOEshh4hSt8PtJV3KxabEko0Gl5xYIEgyUISPYyU746fBx3CpHQGb8
         B0CCilcQZ2o6DZHA5v3mYzqux9uWidzfWcugRTEbHJ/DYhjaKEGuhJUzQusiOZhiQIpA
         YGCZis8alJhLXAiSfhU4ub9pgVLieFqi+7Oc/Tmf+WNZlw1r+VKX9ItGGX2NkpA17oNK
         xzTkvWIaXw5XzP9EulZFquqG6Mpju/bP+4Q7do1K9xF6RuIks9UByVBYRZOW8Uwkc/zj
         VT6w==
X-Gm-Message-State: AG10YOSX7bY28SnwBuwW5BdWiQpUZo9/S2oNb43B19CrNt8+lKthDJfPejaQhE6OfkG33YcAM5NFYCyt5U1kiHx7
X-Received: by 10.50.92.68 with SMTP id ck4mr1218743igb.93.1456441872267; Thu,
 25 Feb 2016 15:11:12 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Thu, 25 Feb 2016 15:11:12 -0800 (PST)
In-Reply-To: <1456441708-13512-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287485>

On Thu, Feb 25, 2016 at 3:08 PM, Stefan Beller <sbeller@google.com> wrote:
Subject: Expose

...  submodule parallelism to the user


Does git-send-email cache information after invoking it? i.e. Am I not supposed
to edit the patch files after invoking git send-mail, before
confirming to send them
out actually?

Thanks,
Stefan
