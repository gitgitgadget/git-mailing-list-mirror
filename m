From: nadim khemir <nadim@khemir.net>
Subject: Cygwin error?
Date: Wed, 19 Nov 2008 18:57:30 +0100
Message-ID: <200811191857.30793.nadim@khemir.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 19:25:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2rjt-0007SM-4W
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 19:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbYKSSX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Nov 2008 13:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754470AbYKSSX1
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 13:23:27 -0500
Received: from mail1.perspektivbredband.net ([81.186.254.13]:35030 "EHLO
	mail1.perspektivbredband.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754465AbYKSSXZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 13:23:25 -0500
Received: from khemir.net (h51bafc0a.c46-01-06.sta.perspektivbredband.net [81.186.252.10])
	by mail1.perspektivbredband.net (Postfix) with ESMTP id E2D9A94000E
	for <git@vger.kernel.org>; Wed, 19 Nov 2008 18:56:54 +0100 (CET)
Received: from naquadim.khemir.lan (naquadim.khemir.lan [192.168.1.234])
	by khemir.net (Postfix) with ESMTP id D0C751264ECF
	for <git@vger.kernel.org>; Wed, 19 Nov 2008 18:56:54 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL,UNPARSEABLE_RELAY
	autolearn=ham version=3.2.5-gr0
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr0 (2008-06-10) on firewall
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101365>

Hi, Given:

$ git pull
remote: Counting objects: 46, done.
=2E..
Updating b80286d..a543dae
error: Untracked working tree file 'xxx.txt' would be overwritten by me=
rge.


This is due to a rename of xxx.txt to Xxx.txt. I =A0understand that thi=
s is due=20
to files being just case preserving on Cycwin/Win32.

The only I found was to remove the xxx.txt localy and do a pull. The=20
interresting thing is that Xxx.txt is no present in my file system. I c=
an=20
check it out from HEAD though.

What did I missunderstood and do wrong?

Cheers, Nadim.
