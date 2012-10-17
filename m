From: Thomas Ackermann <th.acker66@arcor.de>
Subject: Aw: Re: [Patch v3 0/8] Create single PDF for all HTML files
Date: Wed, 17 Oct 2012 19:04:18 +0200 (CEST)
Message-ID: <2064042984.134573.1350493458315.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, philipoakley@iee.org, peff@peff.net,
	git@drmicha.warpmail.net
To: gitster@pobox.com, th.acker66@arcor.de
X-From: git-owner@vger.kernel.org Wed Oct 17 19:04:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOX2l-0008QC-6l
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 19:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503Ab2JQREU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 13:04:20 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:35487 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754150Ab2JQRET (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2012 13:04:19 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mx.arcor.de (Postfix) with ESMTP id 674C83AEC92;
	Wed, 17 Oct 2012 19:04:18 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 5738552202D;
	Wed, 17 Oct 2012 19:04:18 +0200 (CEST)
Received: from webmail22.arcor-online.net (webmail22.arcor-online.net [151.189.8.137])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 51B9BD8E81;
	Wed, 17 Oct 2012 19:04:18 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-03.arcor-online.net 51B9BD8E81
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1350493458; bh=NQhhrk7kJ+x83gG0jZqev0S9TTeX8CsE1oSTVUxGE64=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=r09ma1uzNeN+C/JwJpJr0ZvKNmytrAv1jf83utCu9kD3ONp5XPrPKWVdEvkjtK8Wm
	 DJsvm5jvNo7vpzM7E2ytI0rOUWXGMx0hxkyg55rrAL5kC7IFadEfxeXG9GtMfxeZYu
	 uGFEoYDB6YRLK/o4BLzVHK7nygIKGQsf0EK/jqAk=
Received: from [94.217.29.35] by webmail22.arcor-online.net (151.189.8.137) with HTTP (Arcor Webmail); Wed, 17 Oct 2012 19:04:18 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.29.35
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207923>

----- Original Nachricht ----
Von:     Junio C Hamano <gitster@pobox.com>
An:      Thomas Ackermann <th.acker66@arcor.de>
Datum:   17.10.2012 00:11
Betreff: Re: [Patch v3 0/8] Create single PDF for all HTML files

> 
> I (and other people who wrote documentation, I suspect, as well)
> feel somewhat offended by the word "fix" here and there in the
> message in commits that turn files that so far have been plain text
> into asciidoc, though ;-).
> 

When I started working on this topic, I was wondering why not all files in ./technical and ./howto
where converted to html. So I tried it myself and found out, that only minor changes where needed
to get them processed by asciidoc. So from my perspective I was simply "fixing some asciidoc problems".
But of course this wording was never meant to offend anybody. Sorry for that.

BTW1: As only the changes in the doc files where cherry-picked, currently on pu howto-index.sh
will create invalid links in howto-index.html because it scans all .txt-files in ./howto for 
'Content-type: text/asciidoc' and if found, creates a reference to a html file. But these are not created
for the new asciidoc files. So the changes in Documentation/Makefile which create html for the new  
files should be merged also.

BTW2: The 'pretty-print shell script in update-hook-example.txt' part of my changes was left out
from the merge to pu but should also be considered as belonging to the category 'convert plain text files to asciidoc'
as the original file contained a mixture of tabs and spaces which caused suboptimal indendation formatting
with asciidoc.


---
Thomas
