From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] .mailmap: Map email addresses to names
Date: Fri, 12 Jul 2013 11:57:35 -0700
Message-ID: <20130712185735.GC8482@google.com>
References: <7vzjttq9wk.fsf@alter.siamese.dyndns.org>
 <1373629769-23647-1-git-send-email-stefanbeller@googlemail.com>
 <1373629769-23647-2-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 20:57:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxiXH-0000Hu-9z
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 20:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224Ab3GLS5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 14:57:39 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:47917 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965176Ab3GLS5j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 14:57:39 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so8769234pdd.20
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MTlXj+mbSxWIzdP9N27zkTteJJczIHcEhnp9KwomcV8=;
        b=oCp9pomFd+5UHfj8hsYsf+bibeGoWd2B9a+hZ2wi6dEG5I6HklIXxEfVE26eTM0x4+
         tzdZ1wm+TS4LPkGhhRRCM2LdsYzdRUoq+vSH7G2J9pVUJOxdtH09+FQf6pJcjrDr1bSX
         uujDEvhu+QI+8OO4JnI0M1Kq0ybXiV3e7WPUdZ+O0GoA1G23k+QUjwOv2cmsfcGm1gx6
         Y7x/9zay3JjyI9r479iLRzy8cV9/11QZdaRjyksoWK6sTmd9q5NSbV5GcufX8T/tYy00
         3BHYhKB3aqDBenh+Vvgd1YN1PYiLNIlTrYcLSc5LYITdSzSGT00eCGH9eCr0lzid1TzS
         Pw8w==
X-Received: by 10.68.164.33 with SMTP id yn1mr43521304pbb.71.1373655458525;
        Fri, 12 Jul 2013 11:57:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ht5sm1087837pbb.29.2013.07.12.11.57.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 11:57:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373629769-23647-2-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230238>

Stefan Beller wrote:

> --- a/.mailmap
> +++ b/.mailmap
> @@ -5,99 +5,146 @@
[...]
>  Chris Shoemaker <c.shoemaker@cox.net>
> -Dan Johnson <computerdruid@gmail.com>
>  Dana L. How <danahow@gmail.com>
>  Dana L. How <how@deathvalley.cswitch.com>
>  Daniel Barkalow <barkalow@iabervon.org>
> +Dan Johnson <computerdruid@gmail.com>

Small nit: the sorting looks broken here and in similar places below
(the usual ordering is Dan < Dana < Daniel).

Thanks,
Jonathan
