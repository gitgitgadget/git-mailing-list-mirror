From: Christian Meder <chris@absolutegiganten.org>
Subject: Re: First web interface and service API draft
Date: Fri, 22 Apr 2005 15:44:28 +0200
Message-ID: <1114177468.3233.55.camel@localhost>
References: <1114166517.3233.4.camel@localhost>
	 <4268F027.6030304@eldiablo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:41:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOyOG-0007nD-0A
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 15:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVDVNou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 09:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVDVNou
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 09:44:50 -0400
Received: from shadow.prohost.de ([216.71.84.228]:19593 "EHLO
	shadow.prohost.de") by vger.kernel.org with ESMTP id S261723AbVDVNor
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 09:44:47 -0400
Received: from blue.office.onestepahead.de (h-62.96.100.62.host.de.colt.net [62.96.100.62] (may be forged))
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j3MDiUr19158;
	Fri, 22 Apr 2005 15:44:30 +0200
To: El Draper <el@eldiablo.co.uk>
In-Reply-To: <4268F027.6030304@eldiablo.co.uk>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-22 at 13:37 +0100, El Draper wrote:
> Christian Meder wrote:
> 
> >Comments ? Ideas ? Other feedback ?
> >
> >  
> >
> 
> Hi guys,
> 
> New around these parts, so be gentle :-)
> 
> I would like to suggest the idea of a SOAP interface. If we are talking 
> about a true service orientated API, then a way of calling a uri and 
> having it return a nice SOAP packet with the return data in it would be 
> great. If we ensured compliance with web service standards, then it 
> would then mean anyone could write themselves a client desktop based 
> program, a web interface, or any utility command line tools (in Java, 
> .net, whatever they want, and for whatever platform), that could 
> communicate with the web service and retrieve relevant data. You'd then 
> have a true service interface into a Git repository. Seeing as how the 
> idea of returning XML has already come up, I don't think it would be a 
> stretch to extend the web interface to returning web service compliant 
> SOAP packets in order to return data.

Ok, I should've known we get into this being a Web Java guy by
profession ;-)

Right now I'd like to concentrate more on a RESTful approach
http://www.xfront.com/REST-Web-Services.html

I'm concentrating on getting a clean and simple API for mere mortals and
developers alike. SOAP is likely further down on my list. But I
certainly will take patches ;-)



			Christian


-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

