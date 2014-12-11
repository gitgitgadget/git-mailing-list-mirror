From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] core.ignoreStat is affected by --assume-unchanged misunderstandings
Date: Thu, 11 Dec 2014 23:48:52 +0000
Message-ID: <1418341733-1656-1-git-send-email-philipoakley@iee.org>
Cc: ?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>,
	Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:48:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzDTd-0002mU-U0
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 00:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbaLKXsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 18:48:52 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:53450 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933361AbaLKXsv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2014 18:48:51 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AoQbAMksilROl3QYPGdsb2JhbABZgwUBAVGDDbRojkoPhWgEAoEVFwEBAQEBAQUBAQEBODuEaRgLGIECCgYBEwEtiBUJ2BwoBI9yhDAFhCQCjReWZIQOPoJzAQEB
X-IPAS-Result: AoQbAMksilROl3QYPGdsb2JhbABZgwUBAVGDDbRojkoPhWgEAoEVFwEBAQEBAQUBAQEBODuEaRgLGIECCgYBEwEtiBUJ2BwoBI9yhDAFhCQCjReWZIQOPoJzAQEB
X-IronPort-AV: E=Sophos;i="5.07,560,1413241200"; 
   d="scan'208";a="124089458"
Received: from host-78-151-116-24.as13285.net (HELO localhost) ([78.151.116.24])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 11 Dec 2014 23:48:48 +0000
X-Mailer: git-send-email 1.9.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261308>

A recent thread on the Msysgit mailing list 
https://groups.google.com/forum/#!topic/msysgit/d9CltDxx11g noted the
config core.ignoreStat flag as a solution to slow performance on
Windows 8.1 for their system.

This config flag uses the --assume-unchanged flag to speed up systems
with slow lstat(2) calls. Just like the regular --assume-changed
documentation, this need some tweaking to be clear that it is not a
"poor man's .gitignore".

Philip Oakley (1):
  doc: core.ignoreStat clarify the --assume-unchanged effect

 Documentation/config.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
1.9.4.msysgit.0
