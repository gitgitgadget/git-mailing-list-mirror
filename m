From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH 05/13] Fix some typos
Date: Sun, 25 Aug 2013 11:13:11 +0200 (CEST)
Message-ID: <892787868.481320.1377421991470.JavaMail.ngmail@webmail16.arcor-online.net>
References: <20130825050159.GH2882@elie.Belkin> <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <1171853844.1090991.1377329328622.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: jrnieder@gmail.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Sun Aug 25 11:13:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDWNp-0004xX-2B
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 11:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab3HYJNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 05:13:13 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:36199 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754619Ab3HYJNM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Aug 2013 05:13:12 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mx.arcor.de (Postfix) with ESMTP id 7FCEAA9D38;
	Sun, 25 Aug 2013 11:13:11 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id 776F42E60C5;
	Sun, 25 Aug 2013 11:13:11 +0200 (CEST)
Received: from webmail16.arcor-online.net (webmail16.arcor-online.net [151.189.8.70])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 6E8D7197581;
	Sun, 25 Aug 2013 11:13:11 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net 6E8D7197581
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377421991; bh=pPWbTIn/ChiMhdwj154Rlt5hYsnGv5lrhUoeW41mqd4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=JBs6jYbziBhm7gddNLRL7y5PSbUkxu+rsHar8guF28IHy5BYUae7HkT6SVuNm2O5u
	 CVdw2Flz/LfOggwyMc+oxctb2Dce2ES8VKitmS40dUvIukX+m81rAbSlDN1RPWW5yl
	 U9Irz1cEat6wJy4rCGfJnuDJEOQNQ9WNiUZRM2LY=
Received: from [178.7.23.208] by webmail16.arcor-online.net (151.189.8.70) with HTTP (Arcor Webmail); Sun, 25 Aug 2013 11:13:11 +0200 (CEST)
In-Reply-To: <20130825050159.GH2882@elie.Belkin>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.23.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232942>

 
> >  
> > -Or you can use linkgit:git-name-rev[1], which will give the commit a
> > +or you can use linkgit:git-name-rev[1], which will give the commit a
> 
> I think this reads better with a capital 'O'.  (The pedant in me
> likes it, too, since a colon ends a sentence.)
> 
> The lowercase 'but' later in this section should perhaps also be
> capitalized, since it also starts an independent thought.
> 
> 	But that may sometimes help you guess which tags come after the
> 	given commit.
>

I am no native speaker, but I am a little reluctant to start a new sentence
with "But" or "Or". 

> The sentence "So, you can run something like ... then search for a
> line that looks like ..." is a sequence of incomplete thoughts.  It
> could be paraphrased a little to scan better:
> 
> 	So, if you run something like "git show-branch e05db0fd
> 	v1.5.0-rc0 v1.5.0-rc1 v1.5.0-rc2"
> 
> 		$ git show-branch e05db0fd v1.5.0-rc0 v1.5.0-rc1 v1.5.0-rc2
> 		! [e05db...
> 
> 	then a line like
> 
> 		+ ++ [e05db0fd] Fix warnings in ...
> 
> 	shows that e05db0fd is reachable from itself, from v1.5.0-rc1,
> 	and from v1.5.0-rc2, and not from v1.5.0-rc0.
> 

OK; thanks! I will add this.

> >  
> > -To see how submodule support works, create (for example) four example
> > +To see how submodule support works, create four example
> 
> I'd keep the joke.
>

I totally missed the joke ...


---
Thomas
