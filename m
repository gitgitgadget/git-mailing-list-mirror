From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 0/2] Update git-send-email-script with --compose
Date: Mon, 5 Sep 2005 01:13:07 -0400
Message-ID: <11258971871874-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Sep 05 07:16:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC9ID-0002sw-S7
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 07:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVIEFNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 01:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVIEFNL
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 01:13:11 -0400
Received: from mail.autoweb.net ([198.172.237.26]:19614 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1751018AbVIEFNK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 01:13:10 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1EC9I5-0003jS-Ln
	for git@vger.kernel.org; Mon, 05 Sep 2005 01:13:09 -0400
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EC9I4-00042a-00
	for <git@vger.kernel.org>; Mon, 05 Sep 2005 01:13:08 -0400
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan with smtp (Exim 4.52)
	id 1EC9I3-00088q-Hx
	for git@vger.kernel.org; Mon, 05 Sep 2005 01:13:07 -0400
In-Reply-To: 
X-Mailer: git-send-email-script
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8080>


As I promised Junio a few weeks ago (via private email), here's an update to git-send-email-script
that fixes a few annoying things it does.

1. No longer require --subject for most uses.
2. No longer require --in-reply-to for most uses.
3. If not given as command line parameters, don't prompt for either 1 or 2.
4. Add --compose that lets the user compose an email using $EDITOR, and make
use of --subject and --in-reply-to

The first patch is the update to the code, the second patch updates the
documentation to match.  And the fact that this is on the list at all is proof
that it works (for me, at least.)

-- 
Ryan Anderson
  sometimes Pug Majere
