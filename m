From: "Max Kirillov" <max@max630.net>
Subject: RE: Recording the current branch on each =?UTF-8?Q?commit=3F?=
Date: Sun, 27 Apr 2014 23:42:06 -0700
Message-ID: <20140427234205.96eec638b311907e2368f42b42021fd8.e03a1e7076.wbe@email02.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Jeremy Morton" <admin@game-point.net>,
	"Git mailing list" <git@vger.kernel.org>,
	"Johan Herland" <johan@herland.net>
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 08:42:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WefGX-0004QR-Pf
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 08:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbaD1GmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 02:42:09 -0400
Received: from p3plsmtp02-01-2.prod.phx3.secureserver.net ([72.167.218.94]:34949
	"EHLO p3plwbeout02-01.prod.phx3.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbaD1GmI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 02:42:08 -0400
Received: from localhost ([72.167.218.116])
	by p3plwbeout02-01.prod.phx3.secureserver.net with bizsmtp
	id vJi71n0012XGKeo01Ji7Ql; Sun, 27 Apr 2014 23:42:07 -0700
X-SID: vJi71n0012XGKeo01
Received: (qmail 9338 invoked by uid 99); 28 Apr 2014 06:42:07 -0000
X-Originating-IP: 193.64.145.29
User-Agent: Workspace Webmail 5.6.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247239>

> Personally, I am _strongly_ opposed.  How I name and juggle my private
> branches is nobody else's business in a distributed version control
> system.
> 
> They are private.  My personal workflow.  Not part of a commit.

Mercurial inherits the branch label from previous commit, unless
it's specified by user, I think this could be quite reasonable behavior.
(if make them at all, I don't think this specific branch label feature
should be implemented in git core, but rather there should be a way
to extend git so that it makes them)

-- 
Max
