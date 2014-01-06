From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: Re: Re: [Bug report] 'git status' always says "Your branch
 is up-to-date with 'origin/master'"
Date: Mon, 6 Jan 2014 17:00:23 +0100 (CET)
Message-ID: <1067660482.1596252.1389024023072.JavaMail.ngmail@webmail11.arcor-online.net>
References: <20140106154552.GA22189@google.com> <CAGyf7-FX1sPjwvKdxeEXopffFPiftgDRqoe7NRWyM1Cm=5n6Sw@mail.gmail.com>
 <1963290835.719443.1388996669450.JavaMail.ngmail@webmail15.arcor-online.net>
 <1283978462.720554.1388999328222.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bturner@atlassian.com, worldhello.net@gmail.com,
	git@vger.kernel.org, gitster@pobox.com
To: jrnieder@gmail.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Jan 06 17:00:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0CbX-0000Sk-Er
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 17:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbaAFQA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 11:00:29 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:59659 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754733AbaAFQAY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 11:00:24 -0500
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mx.arcor.de (Postfix) with ESMTP id 24D33D8FB8;
	Mon,  6 Jan 2014 17:00:23 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 1E2E37DAF0F;
	Mon,  6 Jan 2014 17:00:23 +0100 (CET)
Received: from webmail11.arcor-online.net (webmail11.arcor-online.net [151.189.8.83])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 16918107A70;
	Mon,  6 Jan 2014 17:00:23 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net 16918107A70
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1389024023; bh=VsvymcMRQqfSa+v6ReMafaTx9LvXt9Zj14Rr1QkaZSU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=mRnWnwCn5FTVAELsrYNcxOxPCXs/gbm4PLo9+ZuY00Oni06ZKsePg67cPZaAZjTGw
	 yz6FqokX/JsC5zwa+kaRfFXY2kbtF4GVbckjYw5GTY4bCyGt+Dh/OVabclo9rJNmpU
	 HMy0rLFKlmj/JYoUFd8sSuYDW2gocgUgayiOUnK0=
Received: from [178.7.31.225] by webmail11.arcor-online.net (151.189.8.83) with HTTP (Arcor Webmail); Mon, 6 Jan 2014 17:00:17 +0100 (CET)
In-Reply-To: <20140106154552.GA22189@google.com>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.31.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240020>

 
> > But for the simple use case where you only have a master
> > branch I consider it not really helpful and - at least for me -
> > misleading.
> 
> I see what you mean, and you're not the only one.
> 
> Git follows a rule of "never contact another machine unless explicitly
> asked to using a command such as 'git pull' or 'git fetch'".  To
> support this, it makes a distinction between (1) the remote-tracking
> ref origin/master and (2) the actual branch "master" in the remote
> repository.  The former is what is updated by 'git fetch', and the
> latter is something git does not know about without talking to the
> remote server.
> 
> What documentation did you use when first starting to learn git?
> Perhaps it can be fixed to emphasize the distinction between (1) and
> (2) earlier.

I think it's not the problem of the documentation but of myself
not having it read thorough enough ;-)

(This new feature in V1.8.5 of course is not documented in any of the books
up to now but in the future could be used to explain the above mentioned
rule.)

Thanks to you, Bryan and Jiang for your help!

---
Thomas
