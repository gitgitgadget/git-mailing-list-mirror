From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: Diff output from a rewrite of a function
Date: Thu, 8 Mar 2007 21:04:46 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0703082049060.19974@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 20:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPNvh-0007WJ-5S
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 20:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933063AbXCHTEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 14:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933065AbXCHTEz
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 14:04:55 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:53905 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933063AbXCHTEy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 14:04:54 -0500
Received: from kivilampi-30.cs.helsinki.fi (kivilampi-30.cs.helsinki.fi [128.214.9.42])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Thu, 08 Mar 2007 21:04:47 +0200
  id 0005FEF2.45F05E4F.00006650
Received: by kivilampi-30.cs.helsinki.fi (Postfix, from userid 50795)
	id E80F8EB365; Thu,  8 Mar 2007 21:04:46 +0200 (EET)
Received: from localhost (localhost [127.0.0.1])
	by kivilampi-30.cs.helsinki.fi (Postfix) with ESMTP id E45D7EB364
	for <git@vger.kernel.org>; Thu,  8 Mar 2007 21:04:46 +0200 (EET)
X-X-Sender: ijjarvin@kivilampi-30.cs.helsinki.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41769>

Hi,

I have a C source file in which couple of functions are fully rewritten 
(only a part of the file), almost no real similarities (block closing 
parents will obviously match still and couple of other keyword lines here 
and there). I wonder if there is way to produce diff that does not get 
confused by the empty lines / identical lines that are present in both 
original and the modified version. Default diff output is very bad looking 
(IMHO) because these identical lines cause a "synchronization point" to 
occur, that is, each identical line of the original is not considered as 
+/- but left as is. Thus I have something like 3-6 add+del blocks per 
function with a part of the change rather than e.g., one block per 
function or so... I found -B from man git-diff-files, but I guess 
"complete rewrite changes" means whole files as it did do anything.

Any ideas?

I'm currently using 1.4.2, if that's significant.

-- 
 i.

ps. Please cc me when replying.
