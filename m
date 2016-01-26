From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 12/15] ref-filter: align: introduce long-form syntax
Date: Tue, 26 Jan 2016 06:16:24 +0100
Message-ID: <CAP8UFD0NUoZtJxo_+M2U20AZcHEZiwPms6TBAU_xqBU0+zSk4Q@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-13-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 06:16:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNvzc-00056E-UO
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 06:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbcAZFQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 00:16:27 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35697 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbcAZFQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 00:16:26 -0500
Received: by mail-lb0-f173.google.com with SMTP id bc4so85682145lbc.2
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 21:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=77x5JAXyIhJMDKg7XS9M8FSp7kryjg5z00fbbcwZjHE=;
        b=dQHP59+b6akyWn2llsuQxH0Kuxntx6kyehq+BF28WOAZIeYjZWlJaNYWzfpSpZRt5q
         lhhLH9iKam5fwjNpCWpn/b5Dpwk1TNtrviDSPyZ7XDioPkrxOH8Ln/w9rwML1R6/XpT6
         ZODKbHQXJOXaTKQI+GzUaRejdJw+/2LResGIHUyx2bFNnVWa6DWFJ/e2oPMulCYF7yw3
         bGlOL/x9DTMJejqVSMMNDrJFgEvEOa2ja8kM7RA1CgHgbxmhaeD7WKM3VRM3s/2yFWe5
         WbGIl73bwzui5ivwhrlhowdLs1qa7gjDRRnz4EgmGqoTzHAG1ZMrLFcEpQjAvPQxVFW3
         qB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=77x5JAXyIhJMDKg7XS9M8FSp7kryjg5z00fbbcwZjHE=;
        b=M6RuPaojlinXZPtkgvXDfHVIw8SfbI4YJUbJQMhonC06sVaidpFWLga2YlYYu2fEKi
         6MiNe0QALhnkWgycJ/skWg+GJJ/D+zuittMonBnwFQT43ENytEHl0TLEygUUYnpXfB8z
         tUa5DIUvBFnYcsdnj8lWj8Dm+37O9dkl0r56HTngQYg73kH5FXRfcY6mdJ6qqJw5ridC
         eX6lCzZTDjl4u+f6xDGpHPQmENjpvNP6cLkT6i3mEo1hRo7p/mWC/8zJ1vImh0uwCz05
         ZhZ32JBUu43AzpfyiXdYDsp2cwzQ6c1RQQ8V6OcZV2R4+DoAnv5Tlo8EBdPjHK+tMKiv
         QFqA==
X-Gm-Message-State: AG10YOSdLG7i1LrlodJLbCyx7YetkomgLzUKE2OYXHTZ84dxNQQp3dpLuliFyFlqFE8xpyHq7AHu4wSSJLdBig==
X-Received: by 10.112.168.5 with SMTP id zs5mr8227773lbb.56.1453785384297;
 Mon, 25 Jan 2016 21:16:24 -0800 (PST)
Received: by 10.25.216.143 with HTTP; Mon, 25 Jan 2016 21:16:24 -0800 (PST)
In-Reply-To: <1451980994-26865-13-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284777>

On Tue, Jan 5, 2016 at 9:03 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce optional prefixes "width=" and "position=" for the align atom
> so that the atom can be used as "%(align:width=<width>,position=<position>)".
>
> Add Documetation and tests for the same.

s/Documetation/Documentation/

Thanks!
