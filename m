From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH] Remove pdf target from Makefiles
Date: Tue, 18 Jun 2013 09:59:51 +0200 (CEST)
Message-ID: <146574770.2154401.1371542391078.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jrnieder@gmail.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Tue Jun 18 09:59:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoqpZ-0004MO-5F
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 09:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632Ab3FRH7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 03:59:53 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:56517 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752552Ab3FRH7w (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jun 2013 03:59:52 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mx.arcor.de (Postfix) with ESMTP id 21B8610BB3A;
	Tue, 18 Jun 2013 09:59:51 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 1E72C6F25CA;
	Tue, 18 Jun 2013 09:59:51 +0200 (CEST)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net [151.189.8.76])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 13E351085E8;
	Tue, 18 Jun 2013 09:59:51 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net 13E351085E8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1371542391; bh=lEnoh+YWobWohHUoWnfXj1LP9cHf3xZ+PQtQ94vWCY8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=ZTX5BNUFWW48RAaHJkwg8chyR3BUpGaxFxH5KKdBIqCNzhn+qusqp/oJDErUL9ssc
	 TctyZqLVFPyqBmWY+PUA0RwR0+c6fjS+fYkN+SR0YvDBXwN86LaqBMeBBkVqmuIF+M
	 HRqKZgXgpuQPAaYsixgBmlGAAVw8H4Cg8k5WeB+Y=
Received: from [194.138.39.59] by webmail18.arcor-online.net (151.189.8.76) with HTTP (Arcor Webmail); Tue, 18 Jun 2013 09:59:50 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 194.138.39.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228171>

> 
> I don't understand.  Do you mean that you want to change the rules
> that generate user-manual.xml?  Would generating different XML files
> for the PDF and for other purposes (with different names) work as a
> way to achieve that without losing the printable manual?
> 

This would be even worse when we have to create different xml depending on the
wanted output. The problem here is in the xml->pdf/html step: I wanted to change
the formatting of links in the pdf from "Section <number>" to "<section_name>" to
make it the same as in the html. Thereby I noticed that the definition for this is
in files from /etc/asciidoc/dblatex. So to change it we have to introduce our own files
in ./Documentation and work on them to bring the formatting of user-manual.html
and user-manual.pdf closer together.


---
Thomas
