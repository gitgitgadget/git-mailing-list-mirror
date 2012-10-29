From: Thomas Ackermann <th.acker66@arcor.de>
Subject: Aw: Re: [Patch 1/1] Wire html for all files in ./technical and
 ./howto in Makefile
Date: Mon, 29 Oct 2012 19:33:47 +0100 (CET)
Message-ID: <884264929.71955.1351535627736.JavaMail.ngmail@webmail09.arcor-online.net>
References: <20121025094205.GI8390@sigill.intra.peff.net> <139737172.296334.1351014913982.JavaMail.ngmail@webmail16.arcor-online.net>
 <1531209463.296427.1351015084181.JavaMail.ngmail@webmail16.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: peff@peff.net, th.acker66@arcor.de
X-From: git-owner@vger.kernel.org Mon Oct 29 19:34:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSuA1-0006Bh-AI
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 19:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760364Ab2J2Sdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 14:33:49 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:35523 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757336Ab2J2Sds (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2012 14:33:48 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id B97075A6FE;
	Mon, 29 Oct 2012 19:33:47 +0100 (CET)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id BA8DC46E01A;
	Mon, 29 Oct 2012 19:33:47 +0100 (CET)
Received: from webmail09.arcor-online.net (webmail09.arcor-online.net [151.189.8.45])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id AA342197896;
	Mon, 29 Oct 2012 19:33:47 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net AA342197896
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1351535627; bh=iB/rJjsuWxJAgbQxPNfk1KPgExK/be7wKwW8VYPInBQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Lf/npEuMkcarBF7aUzQhPtl1XaKPRu5A5HpQj+p82Vn6J89mPKSs39l8L5f2QBBCL
	 hMV4VZBN7KjT3l151Ajv/nJ97X0EP+5huwqfI/5oILpKFjOyd2U7WTjx9ePy7I3Xpn
	 oJCSuS0Lwdgm42AtL9lRB90mWUDQJjMB3vJP9KSU=
Received: from [178.7.28.75] by webmail09.arcor-online.net (151.189.8.45) with HTTP (Arcor Webmail); Mon, 29 Oct 2012 19:33:47 +0100 (CET)
In-Reply-To: <20121025094205.GI8390@sigill.intra.peff.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.28.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208634>

 
This patch addresses Junios comment in WC:
"Misapplication of a patch fixed; the ones near the tip needs to
 update the links to point at the html files, though."

See older mail in this thread:
---
Thomas Ackermann <th.acker66@arcor.de> writes:

> BTW1: As only the changes in the doc files where cherry-picked, currently on pu howto-index.sh
> will create invalid links in howto-index.html because it scans all .txt-files in ./howto for 
> 'Content-type: text/asciidoc' and if found, creates a reference to a html file. But these are not created
> for the new asciidoc files. So the changes in Documentation/Makefile which create html for the new  
> files should be merged also.

Ah, I didn't notice that.

That means that for the patch [6/8], which adds content-type to the
text files, to be complete, it needs to update Makefile to produce
html files from them.

Thanks.
---

So IMHO no open issues with this patch.

----- Original Nachricht ----
Von:     Jeff King <peff@peff.net>
An:      Thomas Ackermann <th.acker66@arcor.de>
Datum:   25.10.2012 11:42
Betreff: Re: [Patch 1/1] Wire html for all files in ./technical and ./howto
 in Makefile

> On Tue, Oct 23, 2012 at 07:58:04PM +0200, Thomas Ackermann wrote:
> 
> > - target "html" creates html for all files in Documentation/howto and
> > Documentation/technical
> 
> Thanks.
> 


---
Thomas
