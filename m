From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/2] Series short description
Date: Mon, 14 Aug 2006 18:53:07 +0200
Message-ID: <20060814165307.20350.63286.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 18:55:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCfid-0005BT-Dm
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 18:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWHNQzK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 12:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWHNQzK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 12:55:10 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:45184 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932155AbWHNQzJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 12:55:09 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 7A1FB75BCA;
	Mon, 14 Aug 2006 18:55:08 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1GCfjA-00060V-SV; Mon, 14 Aug 2006 18:55:48 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25363>

The following series allow to pick from all over the tree, even if your tree
is full of merge commits, and if you use grafts extensively.

The series is not really complete, it lacks a fix for a nasty bug that
crashes stgit when "pick" encounters a file-creation conflict.  But
nevertheless, I would not have been able to do my job today without them :)
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
