From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Thu, 18 Feb 2016 09:41:00 +0100
Message-ID: <1CE3F5E2-DDCC-4F1B-93CF-1A4A194650BF@gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank> <448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com> <vpqh9h7f9kz.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 18 09:41:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWK9F-0004bR-0X
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 09:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425491AbcBRIlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 03:41:07 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35083 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425167AbcBRIlE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 03:41:04 -0500
Received: by mail-wm0-f48.google.com with SMTP id c200so14981136wme.0
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 00:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xE1DiTGT8VE8HOgrymzsxGa6UbYb0hkMrLpw1CRDZu0=;
        b=VCd/mMO9iQ0iXWz2ppz6UPFhH9duw0W+HhbHTMCKYUnt+Xr2xPhWnimRfhgu3bvyBm
         IpjqsArczMdO0sePSw1WyI4q05SSf7kdQ7lZaroKBRKvFhTNQYNjfQ3Kw0OfyItRfjro
         xry9fmMbODjxX8+H0pzJYqaCeAY1LnrWKGrVq2KMBIe7FQkiF8WYmtxVhzAONDjHL1Wu
         Lw1Z//OUTZ/KslsxZWif7uQVuFz6DnivmqDxUKxI/1T2oGnERUE8E6WZrr6FAgD3VKah
         O5THrnBR5r4RQGZDN9An/X+4C+V+fSKPFXOm/8JXD8cotxb5Fc6B/6+z+OHDUcG6F6sV
         7+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xE1DiTGT8VE8HOgrymzsxGa6UbYb0hkMrLpw1CRDZu0=;
        b=d87JHkPHw6WqVlqsTz5+lB3yZNJSGvWFvYXPiCvrs07m/VH3sx+jQRUXdPZcMbNxso
         xa8ivRBv1feO8fgtbed4hx/9D6KHyh5CrYBOQBpFvckGRNX7VKVYHqNgM91ZFhEHewGn
         wXeyrbKaFEQLs7l3ZwH1MGjSIA22TmYkbE3rGM+ey9qLV66b8Tgoj1Psvv1aQlQ7LUy8
         2n2mgpe8MU5nGno1fYMJrpmGUf+H2sgQq8dueqTSdQUWNfUUxQRVJonoU0LGqpIEFNR1
         YSgItJjDTWw1cwEgY5aAAWG0wyGieb4c2bSlA67BOCyXLYv/xbID/kGEGDnAAZ1TlWu+
         y8Ng==
X-Gm-Message-State: AG10YORzPjsmbHnrPo12XQ5XXAHOb5EhvcHjbAg3Medf8AWWTFRG0Yc+8y7rIJc4otLdQw==
X-Received: by 10.28.57.68 with SMTP id g65mr2153237wma.56.1455784863740;
        Thu, 18 Feb 2016 00:41:03 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4227.dip0.t-ipconnect.de. [93.219.66.39])
        by smtp.gmail.com with ESMTPSA id z127sm1835684wme.5.2016.02.18.00.41.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 00:41:02 -0800 (PST)
In-Reply-To: <vpqh9h7f9kz.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286600>


On 17 Feb 2016, at 19:58, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> Coincidentally I started working on similar thing already (1) and I have
>> lots of ideas around it.
> 
> I guess it's time to start sharing these ideas then ;-).
> 
> I think there's a lot to do. If we want to push this idea as a GSoC
> project, we need:
> 
> * A rough plan. We can't expect students to read a vague text like
>  "let's make Git safer" and write a real proposal out of it.
> 
> * A way to start this rough plan incrementally (i.e. first step should
>  be easy and mergeable without waiting for next steps).
> 
> Feel free to start writting an idea for
> http://git.github.io/SoC-2016-Ideas/. It'd be nice to have a few more
> ideas before Friday. We can polish them later if needed.

I published my ideas here:
https://github.com/git/git.github.io/pull/125/files

Do you think that works as start or do we need more detailed, hands-on
instructions?

Thanks,
Lars
