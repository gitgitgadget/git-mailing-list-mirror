From: Benjamin LaHaise <bcrl@kvack.org>
Subject: git clone downloads objects that are in GIT_OBJECT_DIRECTORY
Date: Sun, 5 Mar 2006 20:08:25 -0500
Message-ID: <20060306010825.GF20768@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 06 02:14:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG4IM-0008EX-9U
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 02:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWCFBNu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 20:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWCFBNu
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 20:13:50 -0500
Received: from kanga.kvack.org ([66.96.29.28]:54437 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751323AbWCFBNu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 20:13:50 -0500
Received: (from localhost user: 'bcrl' uid#63042 fake: STDIN
	(bcrl@kanga.kvack.org)) by kvack.org id <S26570AbWCFBIZ>;
	Sun, 5 Mar 2006 20:08:25 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17256>

Hi folks,

Doing a fresh git clone git://some.git.url/ foo seems to download the 
entire remote repository even if all the objects are already stored in 
GIT_OBJECT_DIRECTORY=/home/bcrl/.git/object .  Is this a known bug?  
At 100MB for a kernel, this takes a *long* time.

		-ben (who needed to free up disk space)
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
