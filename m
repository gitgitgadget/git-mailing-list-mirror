From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: xfuncname problems with C++
Date: Fri, 2 Jan 2015 12:19:59 -0800
Message-ID: <20150102201959.GG29365@google.com>
References: <CAHd499Cn8C51i_+Dm4h_U4X_Jc-nhNMjoufiZRdn5LGxFqD_HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 21:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y78hg-0002Fc-Ih
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 21:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbbABUUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2015 15:20:05 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:41163 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbbABUUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2015 15:20:04 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so17311524iec.1
        for <git@vger.kernel.org>; Fri, 02 Jan 2015 12:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3rxDRW4ptk6Y/Y3zg4OCoLUTZouMJ8MdTBq2cimYrb8=;
        b=nv/5eui6B1y0Li3fv7maQTrUmqHh3mhbvc93YHpS1pTXvkSuYFIGcZOtbn+F9RiDfW
         6p2zhz+wSWCqIeV5Ki7cwa9ZSwvtxDX7JU91FJ+C1CTmOH3YK8vDdB8jp5fPSDlXyZRh
         crIUa86rxVxG9UQKEvSfxZe14h9GOBp095PvORdDLIQrJ3LodXwpnKqCNeA2vjxHbHti
         m8Ln42MhUn3aL+a+62p53zZEwneG4o1GOxoZilcwdEknG0bg9A1fcMuZFQ1el2+IAUqS
         KtreNYHnqqarH9LxmAODBz8L4Y5hMr1ArZnEf9eIvrOzWdXL9I4nRgY1tbfdhKuM4MDa
         mLWA==
X-Received: by 10.43.100.67 with SMTP id cv3mr59089329icc.92.1420230002584;
        Fri, 02 Jan 2015 12:20:02 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:4dc:a2d1:6dcb:ef51])
        by mx.google.com with ESMTPSA id n36sm23254567ioe.4.2015.01.02.12.20.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Jan 2015 12:20:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHd499Cn8C51i_+Dm4h_U4X_Jc-nhNMjoufiZRdn5LGxFqD_HA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261980>

Hi,

Robert Dailey wrote:

> I have a function like so:
>
> void MyClass::SomeFunction(int someParameter)
> {
>     // Stuff changed in here
> }
>
> When I do `git diff` on the file containing this function, I get a
> chunk showing some changed code in this function somewhere in the
> middle of the body. However, the chunk header shows my root namespace
> name in the file instead of the function header:
>
> @@ -144,15 +149,22 @@ namespace Utils
>
> What I expect to see:
>
> @@ -144,15 +149,22 @@ void MyClass::SomeFunction(int someParameter)

What version of git are you using?  Could you give a full copy of the
diff so we can have more context (feeling free to mark parts of it as
CENSORED where appropriate, but keeping leading whitespace and the
first +/- column)?

Thanks,
Jonathan
