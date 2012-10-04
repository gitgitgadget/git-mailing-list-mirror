From: Phil Hord <phil.hord@gmail.com>
Subject: Re: git commit --amen
Date: Thu, 4 Oct 2012 10:25:50 -0400
Message-ID: <CABURp0rbNZSOC_Jtxfjp+j3SQR=+r0pU6vOXvc0Jnth0UU9mDA@mail.gmail.com>
References: <0d559e3191a392841124d96870a67735@rom1v.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Romain_Vimont_=28=AEom=29?= <rom@rom1v.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:09:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtZY-0001w8-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010Ab2JDO0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 10:26:14 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:53237 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964926Ab2JDO0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 10:26:13 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so254102lag.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3x+hHyofLtbqhKa2ECmVNz66jS25cldkWeL64VwZ5QY=;
        b=b3WxZKvlXM7P9DKeMYy2VWrm9klvomie2YQIhkrFD88FlKhMJSAefDId/N+tQ1a9ZX
         AurICIgQUcnOeOtob5MPzAOw4vO8d7eKIg18HXnHIeTuZFWuqiAUFSQbfJPJMsPj3Ay2
         rFUHqAKVn2JQK/ZatPDYfscNKWAttQbTG5bJN5du4NIEe9OxdbXua2usOcPXGcllPnB1
         hxbRIpwBmCBe8ajd2nuO8F/6VWJ6/HL57hLrM85M2kfINN8omfZ61/Ud0PCroJYGBOlM
         4cG1XevqFPWNcjyXXMwuIyvfDr9rFCv9zHzcePQjlCZBNa4oZlW38hHlkcimxoSs7qlw
         zj0A==
Received: by 10.112.50.106 with SMTP id b10mr2800314lbo.51.1349360770655; Thu,
 04 Oct 2012 07:26:10 -0700 (PDT)
Received: by 10.114.17.225 with HTTP; Thu, 4 Oct 2012 07:25:50 -0700 (PDT)
In-Reply-To: <0d559e3191a392841124d96870a67735@rom1v.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206970>

> Is it normal that "git commit --amen" actually works ?
> (it does like --amend)
>
> version 1.7.10.4

Yes.  From Documentation/technical/api-parse-options.txt:

    * Long options may be 'abbreviated', as long as the abbreviation
      is unambiguous.

Apparently since 2008-06-22.

So 'git commit --am' also works.  But it should probably be avoided
because of its similarity to 'git commit -am'.

Phil
