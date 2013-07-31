From: Dirk Wallenstein <halsmit@t-online.de>
Subject: [PATCH 1/2] howto: Suppress indentation with tabs
Date: Wed, 31 Jul 2013 18:54:17 +0200
Message-ID: <20130731165417.GB11219@bottich>
References: <20130716180158.GA7524@bottich>
 <cover.1375288760.git.halsmit@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junio@vger.kernel.org, Thomas Ackermann <th.acker@arcor.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 18:54:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Zfc-0007Yw-LY
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 18:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760557Ab3GaQyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 12:54:31 -0400
Received: from mailout06.t-online.de ([194.25.134.19]:58643 "EHLO
	mailout06.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760503Ab3GaQyX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 12:54:23 -0400
Received: from fwd16.aul.t-online.de (fwd16.aul.t-online.de )
	by mailout06.t-online.de with smtp 
	id 1V4ZfJ-00011T-R5; Wed, 31 Jul 2013 18:54:21 +0200
Received: from localhost (TcV4liZ-whR7ckqAVpkrDLR7nP3zMPoVrJRawX7KRQi9E3Lpd3WsX25LoboUrsEQG1@[78.94.248.235]) by fwd16.t-online.de
	with esmtp id 1V4ZfG-0Dz1Ci0; Wed, 31 Jul 2013 18:54:18 +0200
Content-Disposition: inline
In-Reply-To: <cover.1375288760.git.halsmit@t-online.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ID: TcV4liZ-whR7ckqAVpkrDLR7nP3zMPoVrJRawX7KRQi9E3Lpd3WsX25LoboUrsEQG1
X-TOI-MSGID: bdbedfe0-0344-4b4f-806d-6eee14379158
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231431>

The AsciiDoc files in the 'howto' folder are installed as documentation
and AsciiDoc files are meant to be read and printed as is.  To quote the
AsciiDoc Home Page:

    AsciiDoc files are designed to be viewed, edited and printed
    directly or translated to other presentation formats using the
    asciidoc(1) command.

Tabs have the property of a configurable width and can thereby skew the
layout of a page and distort the meaning.  This is particularly a
problem when mixing lines with different indentation (space vs tab) in
code examples and ASCII art.

Prevent such a mix-up by prohibiting tab indentation entirely.

Signed-off-by: Dirk Wallenstein <halsmit@t-online.de>
---
 Documentation/howto/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 Documentation/howto/.gitattributes

diff --git a/Documentation/howto/.gitattributes b/Documentation/howto/.gitattributes
new file mode 100644
index 0000000..fecc113
--- /dev/null
+++ b/Documentation/howto/.gitattributes
@@ -0,0 +1 @@
+* whitespace=tab
-- 
1.8.3.3.2.g85103ba
