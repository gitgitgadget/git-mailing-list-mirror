From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 09:11:59 +0700
Message-ID: <CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 03:12:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDPJS-0007RK-JP
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 03:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbaBLCMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 21:12:30 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:34126 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbaBLCMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 21:12:30 -0500
Received: by mail-qc0-f175.google.com with SMTP id x13so14473554qcv.34
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 18:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6Jv8IYVNIKHG640Nx4Q039ihp74PE+s8UMuL5YImz9Q=;
        b=F+1pxfYbTqd0HnWVacDJbefzLgGxs8DdcBiJZ5ovalBnds8uQ06u+IT4DIo37A+GMY
         N8q0NFfcgUa+fXz279com/4mqw1YrVesWdJdTCC36ga1+xKeKq//oSikDBcUXu1qWNU2
         daJ9fDbaeWN4Wuv3CeuR9+WjrAmlg3XQiDbP5QGl42KVMx91BVc66qc/p3WyiOmk2GUu
         82ostCxT+Q9b13oRb+QSXRYscfSsVS0qKmLnJzo/HfEb/v3peeHvi9SfbkmwI03wu5X0
         ntgju67zWf6Q6irIqyN8Z4b68pK8wCr9Ymaw9jXcljhU77ev9u8JkW773fRvqDF8H4mO
         9bAA==
X-Received: by 10.140.107.138 with SMTP id h10mr58725269qgf.30.1392171149288;
 Tue, 11 Feb 2014 18:12:29 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Tue, 11 Feb 2014 18:11:59 -0800 (PST)
In-Reply-To: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241969>

On Wed, Feb 12, 2014 at 8:54 AM, Stefan Zager <szager@chromium.org> wrote:
> We in the chromium project have a keen interest in adding threading to
> git in the pursuit of performance for lengthy operations (checkout,
> status, blame, ...).  Our motivation comes from hitting some
> performance walls when working with repositories the size of chromium
> and blink:
>
> https://chromium.googlesource.com/chromium/src
> https://chromium.googlesource.com/chromium/blink

I have no comments about thread safety improvements (well, not yet).
If you have investigated about git performance on chromium
repositories, could you please sum it up? Threading may be an option
to improve performance, but it's probably not the only option.
-- 
Duy
