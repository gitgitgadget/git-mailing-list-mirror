From: Jeremy White <jwhite@codeweavers.com>
Subject: RFC re Thunderbird + imap-send
Date: Mon, 09 Feb 2009 15:49:51 -0600
Message-ID: <4990A4FF.6020404@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ben Bucksch <ben.bucksch.news@beonex.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 22:51:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWe2I-0006EH-Vq
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 22:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbZBIVtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 16:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbZBIVty
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 16:49:54 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:49363 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbZBIVty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 16:49:54 -0500
Received: from localhost
	([127.0.0.1] helo=[216.251.189.140] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LWe0m-0000e5-LC; Mon, 09 Feb 2009 15:49:52 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109139>

So, MajorDomo knows that what I'm trying is sick and twisted; I seem to
have run afoul of the taboos:
  http://vger.kernel.org/majordomo-taboos.txt

(ixnay on the ention may of ontentcay ypetay tmlhay :-/).

So here is a pointer to a proposed patch to enable git-imap-send to work
with Thunderbird, based on Ben's suggestion:

http://www.codeweavers.com/~jwhite/0001-Add-an-option-to-wrap-a-patch-in-pre-in-git-imap-s.patch

Essentially, with this patch, I add an html option to the imap-send
server configuration block.  If turned on, we structure each patch as
html, inside of pre blocks.  And, in fact, Thunderbird does
automatically convert such an email into a plain/text, format=fixed
email, that seems to diff cleanly with a regular git-format-patch result.

Thoughts?  Tar and feathers?

Cheers,

Jeremy
