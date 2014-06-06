From: Steve Hoelzer <shoelzer@gmail.com>
Subject: Re: [PATCH 1/2] userdiff: support C# async methods and correct C# keywords
Date: Fri, 6 Jun 2014 08:27:43 -0500
Message-ID: <CACbrTHcVNmffTHPPnPYDXXwYQacmiS77573Y+GpyjSv-yHQM7g@mail.gmail.com>
References: <1401682405-3319-1-git-send-email-ch3cooli@gmail.com> <xmqqy4xbq7xo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sup Yut Sum <ch3cooli@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 15:28:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsuBm-00088B-Om
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 15:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbaFFN2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 09:28:06 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:50328 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbaFFN2E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 09:28:04 -0400
Received: by mail-oa0-f49.google.com with SMTP id o6so844231oag.22
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 06:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OjZnv11FqLBxcFMA8ej8Rl60bN/j5WxCumi2wrK/SAI=;
        b=oFCv9AKqIE5Edz7/39dwjdKGZ1AW+VkMzLhpTGiy0JoMrYTpYdnwkKs7d9hrsdoqzY
         ZMwH0SVE0e+5Rh5fa3lGxTX91NM+Q9fx0ALdKuWFijJV92Fn3BGsGfPBHuMKf3QW0bGa
         0UUppdqDZ8V1SiLVEwP+QvabWGdZMabZrYI8LZ9amcNcW9zUtn6z0RSlFt+LzR2CCSwn
         mmAeL7S3cJJqvCE9Hi7AjznByyRAX7ERFDtFfJJpvjSCyL24/gMSNkw3URHxF22AXtps
         qxJoh9xAV67CTiubORulQOYaUuDH9D0/8HWldkOSxInxRAfecrQ06k96e7Oj770zguaq
         uUiw==
X-Received: by 10.182.142.69 with SMTP id ru5mr4616617obb.6.1402061283586;
 Fri, 06 Jun 2014 06:28:03 -0700 (PDT)
Received: by 10.202.190.198 with HTTP; Fri, 6 Jun 2014 06:27:43 -0700 (PDT)
In-Reply-To: <xmqqy4xbq7xo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250901>

On Thu, Jun 5, 2014 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sup Yut Sum <ch3cooli@gmail.com> writes:
>
>> async is in C# 5.0
>> foreach is in C# 1.0
>
>> instanceof is in Java. The similar keywords are typeof, is, as in C# 1.0
>
> This one made me read it twice, until I realized you meant
>
>     instanceof() is listed as keywords, but there is no such thing
>     (it is in Java, though); in C# we use typeof() for similar
>     purposes

The original email was a bit hard to parse. Junio's clarification left
out the C# keywords 'is' and 'as'. I suggest phrasing it like this:

instanceof() is listed as keywords, but there is no such thing (it is
in Java, though); in C# we use typeof(), 'is', and 'as for similar
purposes
