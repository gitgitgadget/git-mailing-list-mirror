From: Jan Engelhardt <jengelh@medozas.de>
Subject: rfe: git-config: lack of color reset option
Date: Mon, 20 Feb 2012 21:50:11 +0100 (CET)
Message-ID: <alpine.LNX.2.01.1202202142160.31585@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 21:50:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzaBh-0002yF-Lo
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 21:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659Ab2BTUuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 15:50:14 -0500
Received: from seven.medozas.de ([188.40.89.202]:39195 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312Ab2BTUuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 15:50:13 -0500
Received: by seven.medozas.de (Postfix, from userid 25121)
	id 90C1321A06A9; Mon, 20 Feb 2012 21:50:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id 67AE121A0315
	for <git@vger.kernel.org>; Mon, 20 Feb 2012 21:50:11 +0100 (CET)
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191102>

Hi,


given the following config:

[color "diff"]
	commit = bold white blue
[color "decorate"]
	branch = green

The attributes from color.diff.commit are inherited for color.decorate.

1. There seems to be no way to reset the attributes such that
"color.decorate.branch = default green blue" wouuld have an effect.

2. It would be nice if there was an option to only paint the 
commit hash, rather than the entire line including the decorate 
parenthesis group.

(My current version is 1.7.7, but there seem to be no changes regarding 
color config in 1.7.8 and 1.7.9 in the release notes, so I presume the 
issue is still current.)
