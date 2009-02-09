From: Ben Bucksch <ben.bucksch.news@beonex.com>
Subject: Re: Thunderbird and patches
Date: Mon, 09 Feb 2009 23:39:02 +0100
Organization: Beonex
Message-ID: <4990B086.10804@beonex.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:41:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWeoR-0007GN-HC
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 23:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbZBIWjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 17:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbZBIWjo
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 17:39:44 -0500
Received: from mail.server.beonex.com ([78.46.195.11]:33009 "EHLO
	mail.server.beonex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbZBIWjo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 17:39:44 -0500
Received: from [10.1.1.3] (localhost [127.0.0.1])
	by mail.server.beonex.com (Postfix) with ESMTP id 6EE05303C560;
	Mon,  9 Feb 2009 23:39:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2a1pre) Gecko/20081217 Shredder/3.0b2pre
In-Reply-To: <49903521.1060101@codeweavers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109153>

Summary of proposed/possible solutions:

    * TB | normal msg viewer | main menu | File | Save As | File |
      "foo.eml" saves the verbatim, on the wire RFC822 mail
      (that may include quoted printable etc., though, so verbatim may
      not actually be what you want)
    * You can turn off format=flowed during sending, if it disturbs you:
         1. Prefs | Advanced | General | Config Editor...
         2. "mailnews.send_plaintext_flowed" = false
    * Jeremy White has a patch for git-imap-send to work around TB's
      body reformatting, by inserting a preformatted (<pre>) section.

(Other solutions, involves other software:)

    * I strong suggest to send inline attachments (Content-Disposition:
      inline, RFC 2183 [1], Internet Standard), because patches are
      arguably files, and the body is for human language text.
      Therefore, it's an attachment that you want to see inline,
      therefore inline attachment is the IMHO correct solution.
      If some mailers cannot handle this comfortably (display inline,
      quote), maybe you can also advocate having *them* fixed.


[1] <http://www.apps.ietf.org/rfc/rfc2183.html>
