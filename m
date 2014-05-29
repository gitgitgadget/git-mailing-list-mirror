From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG REPORT] Git log pretty date
Date: Thu, 29 May 2014 19:52:50 +0700
Message-ID: <CACsJy8CzMcaQ0q4bsUmR34fE+VunTFiW_oVmC-mKFORq89bsKQ@mail.gmail.com>
References: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
 <1401361654.26905.2.camel@spirit> <CACJZPBvn4nX4aVGiiC1VAhHi7vPZJDBR8T5p13qaE6B+2Q9bUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Git Mailing List <git@vger.kernel.org>
To: Rodrigo Fernandes <rtfrodrigo@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 14:53:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpzpl-0000OD-Mx
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 14:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392AbaE2MxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 08:53:22 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:46514 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757389AbaE2MxV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 08:53:21 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so748205qgf.21
        for <git@vger.kernel.org>; Thu, 29 May 2014 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eeKHGWOHwSthyi+d50dWUbWqpxiXJvyadg0PpVdiw+A=;
        b=klLJ1CmIN/N+IpjIrFRVYxLBWTR2XEO8fzO7Ryq84PxKvmyoxFyrci7DaAZ4giq3U/
         LtjuB4LXquwwOg2N2ladrjkIiR9S7WfW/erOzt6nJJhhBjx0aQC6C3VX9mHDyHxsTy11
         uXKyfOohP5Ymk8boARZkDjGIwjuWm7x/maDYl0W4sMQ2197nUJeiwo8l4ww6AZixfBz6
         Ie3ECewyskSWXzELg7W8iuPyl0iGxUjFnVKlWnYi9FiTgHWjX0otSWXMlOYtnk5c/9Vc
         gQTRdkYy3NcrclK8B9EzeJQrQVIaJKJLbzSp45KlNdp3n9kZ9tv22OsWh1O8IU7aMWBS
         kKFw==
X-Received: by 10.224.6.199 with SMTP id a7mr10207879qaa.24.1401368000589;
 Thu, 29 May 2014 05:53:20 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 29 May 2014 05:52:50 -0700 (PDT)
In-Reply-To: <CACJZPBvn4nX4aVGiiC1VAhHi7vPZJDBR8T5p13qaE6B+2Q9bUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250370>

On Thu, May 29, 2014 at 7:24 PM, Rodrigo Fernandes <rtfrodrigo@gmail.com> wrote:
> Duy, can you point me where is the date print from normal `git log` or
> `git show` so I can compare?

It's the same function, show_date() in date.c.
-- 
Duy
