From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/5] refs.c: make @ a pseudo-ref alias to HEAD
Date: Wed, 1 May 2013 14:31:29 -0500
Message-ID: <CAMP44s3D3yPx6mfLvnkf3Ef55=kP1Jtx1P947uG7pg8_HrH3Vg@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-6-git-send-email-artagnon@gmail.com>
	<CAMP44s3nzuecoM+h+pNknV4A68R1gZ6DZpehp3uKcJhppXo+1w@mail.gmail.com>
	<CALkWK0=WjctcYv30V9b3NMb5motYz=57OqmLU7pdW_fbOP40MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 21:31:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXcka-0001J4-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 21:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171Ab3EATbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 15:31:32 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:40648 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab3EATbb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 15:31:31 -0400
Received: by mail-la0-f45.google.com with SMTP id el20so1604135lab.18
        for <git@vger.kernel.org>; Wed, 01 May 2013 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=x1JmuBLYfrARgJGNMhUepimWsho6jd8DHnXuaFGfsE8=;
        b=rnQWBxraKhvXn733DhKhespuIYvInBagfzZT5YNTE5CXbqcgcEN3eH7BdXAS/HJmNq
         jc3YrJpu55So7DcwpVYxnt/nyE2vUoQCHFVirKFSKjL9BjhXDk6ShFdwdyXUiBjQYN5j
         0jdT+jF23ALR9ZRC58wPZdnCHYYjZ//02nTRZyMd2Lp/eVm/Xh7TPavMuzEm6rhWn1dh
         p+QI9mcL0lDyWnEhStYWc9h3axPn8ZAH0QMCBRWam8XFc5idY9RusO4Bvarrx56AS405
         L5H8AxzK/RJfT1++bCTHxKbR6HSthbaCQIxchKVuBxgUaiOm3q1ue5XJHq4GeyzfOUnt
         0nNQ==
X-Received: by 10.112.166.101 with SMTP id zf5mr1585160lbb.59.1367436689927;
 Wed, 01 May 2013 12:31:29 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 12:31:29 -0700 (PDT)
In-Reply-To: <CALkWK0=WjctcYv30V9b3NMb5motYz=57OqmLU7pdW_fbOP40MA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223129>

On Wed, May 1, 2013 at 2:00 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Does the user really cares if it's a pseudo-ref or not? Also, what
>> does it mean that "refers" to HEAD?
>
> It's not about whether the user cares or not; it's about saying it in
> a way that doesn't make it less precise.  I'm saying "@ is like a
> symbolic-ref .git/@ ref referring to HEAD, except it doesn't sit on
> the filesystem".

If I put my user shoes, I don't care how @ is implemented, I just care
that it's a shortcut for HEAD, that's what it means to me, the common
user.

-- 
Felipe Contreras
