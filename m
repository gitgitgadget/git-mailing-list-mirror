From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/8] Make C-level operable from subdirectories
Date: Sat, 26 Nov 2005 01:51:41 -0800
Message-ID: <7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 10:53:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efwiv-0000bE-1f
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 10:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVKZJvn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 04:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVKZJvn
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 04:51:43 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:14527 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750808AbVKZJvm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 04:51:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126095144.MKO25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 04:51:44 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511251953081.13959@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 25 Nov 2005 20:05:46 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12769>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 25 Nov 2005, Junio C Hamano wrote:
>>
>> I once advocated for an environment to name the top of working
>> tree directory --- it might make sense to resurrect that one.
>
> Please don't. 
>
> We should just make the scripts do it automatically instead.

Here comes an 8-patch series.

  [PATCH 1/8] git-apply: work from subdirectory.
  [PATCH 2/8] peek-remote: honor proxy config even from subdirectory.
  [PATCH 3/8] fsck-objects: work from subdirectory.
  [PATCH 4/8] checkout-index: work from subdirectory.
  [PATCH 5/8] hash-object: work within subdirectory.
  [PATCH 6/8] ls-tree: work from subdirectory.
  [PATCH 7/8] Make networking commands to work from a subdirectory.
  [PATCH 8/8] Make the rest of commands work from a subdirectory.
