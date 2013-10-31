From: Karl Wiberg <kha@treskal.com>
Subject: Re: Show patch in gitk --first-parent ?
Date: Thu, 31 Oct 2013 11:10:54 +0100
Message-ID: <CAFAOj7oskj3TKZU4O5-=CejJVV7v0OiS9t-S9vO4nBtC+jA6jQ@mail.gmail.com>
References: <CAFAOj7p49pQo=hXZT3TmMFF+KThKY-PZ2cgsZasH=e8rgjri1A@mail.gmail.com>
	<874n7yiqxo.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Oct 31 11:11:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbpDh-0006J7-RG
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 11:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590Ab3JaKK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 06:10:57 -0400
Received: from mail1b.space2u.com ([194.218.23.146]:47710 "EHLO
	mail1.space2u.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750712Ab3JaKK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 06:10:57 -0400
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.5/8.14.4) with ESMTP id r9VAAsoA029009
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 31 Oct 2013 11:10:55 +0100
Received: by mail-wg0-f51.google.com with SMTP id l18so2449145wgh.18
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 03:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Sdl04tZTPV79qEEZ1o5EW+0WTpmCxELUQRABo3Us8Is=;
        b=bHsGTe+pFfT+4x5ofDD0zl+4NUL6MStp0OWcq1OpMruep5RvKANVmiCniLs3LghaFv
         6BSOUChBTIZeOIEx6moZMLS4PxIQt1kvZr9/yEYMZTYv8uhuo1cklu4v0hW+WxgW1GDZ
         nZvmVBA0iW+3j6kvpRcVp6SG8Z0vN4AfF7PUr0isQsjgCUJxuGgzVM0xUU7tlobPRwJg
         mYzTIF7tWGHJ1Nc55cIVJuBbirAdHL7kA9Z4b9u1XHquOvUX8wtmWrM4f1gJbpQzBTpX
         95+VsOZslPuBhPU9cD0PukZgKkz8Kj1wtbjH9ofTLksDRUANtCeOwI4VpMTk25kPpiXV
         uxiw==
X-Received: by 10.194.200.100 with SMTP id jr4mr1893271wjc.37.1383214254742;
 Thu, 31 Oct 2013 03:10:54 -0700 (PDT)
Received: by 10.216.207.141 with HTTP; Thu, 31 Oct 2013 03:10:54 -0700 (PDT)
In-Reply-To: <874n7yiqxo.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237117>

On Wed, Oct 30, 2013 at 6:55 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> While not automatic, you can right click on the parent and select
> Diff this->selected.

And there's also the option to "mark" a commit, and diff this with
marked. Thanks, that's just what I needed (although as you say, it
isn't automatic).

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
