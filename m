From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: First web interface and service API draft
Date: Fri, 22 Apr 2005 23:47:10 +1000
Message-ID: <2cfc4032050422064728470606@mail.gmail.com>
References: <1114166517.3233.4.camel@localhost>
	 <4268F027.6030304@eldiablo.co.uk> <1114177468.3233.55.camel@localhost>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Apr 22 15:43:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOyQc-0008ET-Kd
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 15:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVDVNrO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 09:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVDVNrO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 09:47:14 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:13958 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261733AbVDVNrL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 09:47:11 -0400
Received: by rproxy.gmail.com with SMTP id i8so648453rne
        for <git@vger.kernel.org>; Fri, 22 Apr 2005 06:47:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X8evQRB0NVYYyTJnLawJO/aLPTGJ8o2T1RLqNTnbAo+QKBmXWWUPag8XiSGMy/ntzQ0+h7jqAV5RnxKBsR8xFps4Kkc1T8NdFxLMjPkK7iGMkJDbt2o5HXVa6QnEPFwsgf9z/P/5SXrmMPNG7xQM15swu8H5qmzwttai822/i9E=
Received: by 10.38.11.1 with SMTP id 1mr3440218rnk;
        Fri, 22 Apr 2005 06:47:10 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Fri, 22 Apr 2005 06:47:10 -0700 (PDT)
To: El Draper <el@eldiablo.co.uk>, git@vger.kernel.org
In-Reply-To: <1114177468.3233.55.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> >
> > >From the point of view of a specification, though, I think it would be
> > useful to focus on an XML content model rather than the details of one
> > particular HTML model - get the XML model right and you can do
> > whatever you like with the HTML model at any time after that.
>
> Actually I think the order is get the C content model right (done), get
> the Python object model right (in flux), produce an appropriate XML
> model.

Mmm.. I am not sure that a Python model is logically a pre-requisite
to the XML model nor that the ideal C API model is complete - we still
don't have a libgit, for example.  For an XML model we can get by
pretty well with the data model as it is - and an XML model really
shouldn't be dependent on any particular API or programming language.

Certainly, though, an XML model isn't a pre-requisite to a Python
model. Though it might be a pre-req to a SOAP model :-).

jon.
