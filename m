From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sun, 19 May 2013 10:45:58 -0500
Message-ID: <CAMP44s2v5Z=7cJ4-3WeqVHAqxk1sWVT-VkOufK5CeCVcS8Xh8g@mail.gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
	<1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0ke-Ns0JCt6LAzWqympWZ=2x3rRHOjnzB9QN7gc2=ckgw@mail.gmail.com>
	<CAMP44s1xguzX=iavUJxYXBEPOpGvJtJ_7FDHNCWMrF6qxOsuOQ@mail.gmail.com>
	<CALkWK0mA9zWjco1fYRu4O2QmMRJE7vd2Z3CyJj=a1VxCyymMvQ@mail.gmail.com>
	<CALkWK0kuj00uUW5C5zKyaCBM72HBzxAk9G2UT1P3bKx9Lc8tkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 17:46:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue5oD-0001bD-Jb
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 17:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080Ab3ESPqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 11:46:00 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:48492 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab3ESPp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 11:45:59 -0400
Received: by mail-lb0-f172.google.com with SMTP id p10so998690lbi.17
        for <git@vger.kernel.org>; Sun, 19 May 2013 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=v4ohFLE/CDE2Z581Gv2wo6iAuMDuPrWn/UXnE5iOI5s=;
        b=dX5z2mFaR8nuKONW1x2Q8BZcn2QpO9YIjDNkM5H7EK7Y5lcWZVUAWoQwcj0WJjnQkw
         e0iUsBG6zJjrSMWed9XHiHnXDs7mNTc6rjK5Ad+8p+CgKWl9DVg5etkI+HwG8fGB5CBC
         t0vNY4p5trrLw0flm/QyCM1l4sGDom1yO6V41yiVvA1qaOHNEGw3HQTFdTFkjMVPt2a1
         W+gINDcfRvPG9DEY2qXXJBLcOanOMNW2tRNQRoFBy8W2kO+QeYLXTYK//o/06eeAFAwx
         tr7GT/RTJUhuuCZ16dO4j9H2Xhhz7B/xh5vx+YyZ0MumJ1d4idjF0y2NZRW6KNvvRSt1
         9f0A==
X-Received: by 10.112.145.72 with SMTP id ss8mr26393207lbb.12.1368978358080;
 Sun, 19 May 2013 08:45:58 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 08:45:58 -0700 (PDT)
In-Reply-To: <CALkWK0kuj00uUW5C5zKyaCBM72HBzxAk9G2UT1P3bKx9Lc8tkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224894>

On Sun, May 19, 2013 at 10:17 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>> There's a non-optional space before the "<email>" in your regex, which
>> is what I was pointing out.
>
> Er, scratch that.  It's the space after the "Whatevered-by:"

It doesn't really matter. We can operate under the assumption that
there will always be a name and remove the extra code in fmt_person(),
IIRC it was because of the muttrc simplification which I don't think
makes sense any more. It's still possible that the name will be
missing, but I don't personally care, it would probably work for
99.99% of the cases.

-- 
Felipe Contreras
