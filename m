From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: First web interface and service API draft
Date: Fri, 22 Apr 2005 21:34:45 +1000
Message-ID: <2cfc4032050422043419b578cd@mail.gmail.com>
References: <1114166517.3233.4.camel@localhost>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 13:31:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOwMo-00052q-Uc
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 13:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVDVLe7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 07:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVDVLe7
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 07:34:59 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:33162 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262023AbVDVLeq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 07:34:46 -0400
Received: by rproxy.gmail.com with SMTP id c51so630304rne
        for <git@vger.kernel.org>; Fri, 22 Apr 2005 04:34:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EeN27mj74UwfDE+70g6d0TKiK3jrkTRg2XHZj0RqugjjOCfS1wDeKsg8T4e+FzTtc96y3UUHlqum3efwTMkTekamAzA62kwmsu2WNw86mp1YHKZHoJPaVf8zyfuHXFifpXgYZEQYD7i0YtaXvk88duhItGGlBJPJbPpvzYl7aA4=
Received: by 10.38.15.7 with SMTP id 7mr3328537rno;
        Fri, 22 Apr 2005 04:34:45 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Fri, 22 Apr 2005 04:34:45 -0700 (PDT)
To: Christian Meder <chris@absolutegiganten.org>
In-Reply-To: <1114166517.3233.4.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/22/05, Christian Meder <chris@absolutegiganten.org> wrote:
>
> Comments ? Ideas ? Other feedback ?
> 

I'd suggest serving XML rather than HTML and using client side XSLT to
transform it into HTML. Client-side XSLT works well in IE 6 and all
versions of Firefox, so there is no question that it is a mature
technology. Provide a fall back via server transformed HTML if need
be, but that is trivial to do once you have the client-side XSLT
stylesheets.

Serving XML is as easy as serving HTML and gives you a much more
flexible outcome.

jon.
