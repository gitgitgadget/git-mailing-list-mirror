From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/2] StGIT and remotes
Date: Thu, 25 Jan 2007 23:45:47 +0100
Message-ID: <20070125224106.30563.54680.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 23:46:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HADMu-0003Tj-N9
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 23:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030629AbXAYWqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 17:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030648AbXAYWqx
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 17:46:53 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:58402 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030629AbXAYWqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 17:46:53 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 304635577;
	Thu, 25 Jan 2007 23:46:52 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1HADMw-0002T4-8v; Thu, 25 Jan 2007 23:46:58 +0100
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37771>

The 1st patch moves code from commands/pull to a more appropriate
generic location, and the 2nd introduces a handful of functions to get
informations about remotes in the repository.

Both are mostly targetted at 
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
