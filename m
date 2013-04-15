From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH v3 4/4] glossary: improve definitions of refspec and
 pathspec
Date: Mon, 15 Apr 2013 20:41:37 +0200 (CEST)
Message-ID: <298825540.997906.1366051297394.JavaMail.ngmail@webmail19.arcor-online.net>
References: <7v8v4ju0e5.fsf@alter.siamese.dyndns.org> <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
 <1496585271.996545.1366048207561.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Apr 15 20:41:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URoLX-0006SW-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 20:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756629Ab3DOSlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 14:41:39 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:36735 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752426Ab3DOSli (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Apr 2013 14:41:38 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mx.arcor.de (Postfix) with ESMTP id 759A4BE1A4;
	Mon, 15 Apr 2013 20:41:37 +0200 (CEST)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 6E1316F3375;
	Mon, 15 Apr 2013 20:41:37 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 62BC49BB4C;
	Mon, 15 Apr 2013 20:41:37 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-14.arcor-online.net 62BC49BB4C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1366051297; bh=nUm0Ua8GhgaNJ/ynCzktJQpP6hSc9p/5LP9MBTmNpFU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=r1cRhtvHWvXe8972rkyXMyGxD1/NuF9m4uKktK79nwVxw7pLsR1/QtgekNJS7JRff
	 YU9SWmpNZdFt0AZAp8GDWXC2FSJxX+VL8RrrCgJsDhMz35PwdsmisvM7A5E2c/WCoF
	 rIkOaqbi59b4L2VOUdY2yXEvXBYYbTVDTxKfd8rM=
Received: from [188.105.109.185] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Mon, 15 Apr 2013 20:41:37 +0200 (CEST)
In-Reply-To: <7v8v4ju0e5.fsf@alter.siamese.dyndns.org>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.109.185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221284>

 
> 
> But I do not know if the description of the longhand ":(top)" is
> unnecessary for the user.  Is the equivalence between it and :/
> described anywhere else in our documentation set?
> 
The only complete "documentation" for all of this is in setup.c and I must
confess that I missed the subtle difference of "magic words" which can be 
used in the long form and "magic signatures" which are used in the short
form. Because currently there is only one "magic *", from a user perspective
I would prefer to document only the short form.
So I suggest to drop the "long form" paragraph entirely and start the 
"short form paragraph" with
"A pathspec that begins with a colon `:` has special meaning.
If the leading colon `:` is followed by zero or more "magic ..."



---
Thomas
