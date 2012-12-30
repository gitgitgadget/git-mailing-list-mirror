From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH 0/3] Move CodingGuidelines and SubmittingPatches to
 ./Documentation/technical
Date: Sun, 30 Dec 2012 15:56:33 +0100 (CET)
Message-ID: <1965427282.405137.1356879393533.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: artagnon@gmail.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Sun Dec 30 15:56:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpKJp-0005Gh-Uc
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 15:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab2L3O4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 09:56:36 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:53665 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753101Ab2L3O4e (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Dec 2012 09:56:34 -0500
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 83440306E9;
	Sun, 30 Dec 2012 15:56:33 +0100 (CET)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 7FD3733F5C1;
	Sun, 30 Dec 2012 15:56:33 +0100 (CET)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net [151.189.8.76])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 7A55D197AC0;
	Sun, 30 Dec 2012 15:56:33 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net 7A55D197AC0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1356879393; bh=Adj3Ltwc24Kwm7ZAY6zOcGYMATnt8AEui2vCE6OFbtw=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=r5PoSkoVRNRAGWFvMtNuBoqdqlOKrDoWwiVGkctU7+x+ZI7/T7aXa/DK7xG0RwyUd
	 et1SG64dFhvnJP4RmNGxctG5dhvFIZOxwzw1yAcHgEA1uFfUSXLi3xVUyLmxFT+VA2
	 88dJGgUTJ5zEMyq4RAM+yY0vCwkKVzk/h9SoQQsc=
Received: from [188.98.241.53] by webmail18.arcor-online.net (151.189.8.76) with HTTP (Arcor Webmail); Sun, 30 Dec 2012 15:56:33 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.241.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212334>

 
./Documentation/technical contains not only API documentation but also
several other documents describing Git implementation topics and thus
is the place someone wanting to join Git development should look at.
So IMHO CodingGuidelines and SubmittingPatches should also be there.
(One could even consider renaming ./technical to ./internal to stress this point
and get rid of the rather generic "technical" ...)

In contrast ./howto implies containing documents a Git *user* might 
need to solve some tricky problems (and to this end maintain-git.txt
and new-command.txt should also be moved to ./technical (sorry for
being the guy who just moved ./technical/api-command to 
./howto/new-command.txt ;-)).

./Documentation itself should only contain the command manpages
and tutorials.

----- Original Nachricht ----
Von:     Ramkumar Ramachandra <artagnon@gmail.com>
An:      Thomas Ackermann <th.acker@arcor.de>
Datum:   30.12.2012 12:52
Betreff: Re: [PATCH 0/3] Move CodingGuidelines and SubmittingPatches to ./Documentation/technical

> Thomas Ackermann wrote:
> > CodingGuidelines and SubmittingPatches are IMHO a little bit hidden in
> ./Documentation
> > and with respect to their content should be better placed in
> ./Documentation/technical.
> 
> I don't think SubmittingPatches and CodingGuidelines belong to
> Documentation/technical; that location is mostly reserved for API
> documentation.  Also, being prominent documents, they're probably
> linked to by many places on the internet.  I wouldn't want to
> unnecessarily break those links.
> 
> Ram
> 

---
Thomas
