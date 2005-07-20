From: Wolfgang Denk <wd@denx.de>
Subject: Should cg-mkpatch output be usable with cg-patch?
Date: Thu, 21 Jul 2005 01:49:04 +0200
Message-ID: <20050720234904.B3ED735267C@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jul 21 01:49:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvOJd-00032f-Ao
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 01:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVGTXtW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jul 2005 19:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVGTXtW
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jul 2005 19:49:22 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:40596 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261539AbVGTXtV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2005 19:49:21 -0400
Received: from fwd18.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 1DvOJT-0001vh-00; Thu, 21 Jul 2005 01:49:19 +0200
Received: from denx.de (GoBvAYZlZepetoT9uo+POooPxRElWlh2MpNBb8zGdjNpZW0GDXPs6U@[84.150.85.110]) by fwd18.sul.t-online.de
	with esmtp id 1DvOJG-2AIjxo0; Thu, 21 Jul 2005 01:49:06 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id 1D02142EA5
	for <git@vger.kernel.org>; Thu, 21 Jul 2005 01:49:05 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id B3ED735267C
	for <git@vger.kernel.org>; Thu, 21 Jul 2005 01:49:04 +0200 (MEST)
To: git@vger.kernel.org
X-ID: GoBvAYZlZepetoT9uo+POooPxRElWlh2MpNBb8zGdjNpZW0GDXPs6U@t-dialin.net
X-TOI-MSGID: 907707b7-a408-4087-b231-ad87663e8340
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I wander what I should do with "cg-mkpatch" generated output;  I  had
the  impression that this should be usable with "cg-patch", but these
are incompatible with each other. Forexample. if  a  commit  contains
permission changes, my generated patch may look like this:

	...
	diff --git a/MAKEALL b/MAKEALL
	old mode 100644
	new mode 100755
	diff --git a/mkconfig b/mkconfig
	old mode 100644
	new mode 100755
	diff --git a/tools/img2brec.sh b/tools/img2brec.sh
	old mode 100644
	new mode 100755
	...

If I feed this into "cg-patch", I get:

	patch: **** Only garbage was found in the patch input.

-> rpm -q cogito
cogito-0.12.1-1


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I really hate this damned machine     It never does quite what I want
I wish that they would sell it.              But only what I tell it.
