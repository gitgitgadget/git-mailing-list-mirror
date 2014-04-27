From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 0/2] fix and examples for git interpret-trailers
Date: Sun, 27 Apr 2014 22:12:35 +0200
Message-ID: <20140427200327.16880.53255.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 22:13:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeVS7-0006SR-VX
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 22:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbaD0UNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 16:13:23 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:64701 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbaD0UNW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 16:13:22 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 1201461;
	Sun, 27 Apr 2014 22:13:19 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247225>

As I sent version 11 of the "Add interpret-trailers builtin" only a few
days ago, I am sending now a short series on top instead of another full
version.

Christian Couder (2):
  trailer: fix to ignore any line starting with '#'
  trailer: add examples to the documentation

 Documentation/git-interpret-trailers.txt | 98 +++++++++++++++++++++++++++++++-
 t/t7513-interpret-trailers.sh            | 26 +++++++++
 trailer.c                                | 29 ++++++----
 3 files changed, 141 insertions(+), 12 deletions(-)

-- 
1.9.rc0.17.g651113e
