From: Jonathon Mah <jmah@me.com>
Subject: Re: Revert option for git add --patch
Date: Thu, 8 Nov 2012 00:57:19 -0800
Message-ID: <EE89F0A1-1C07-4597-B654-035F657AD09F@me.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nathan Broadbent" <nathan.f77@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:12:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWOAR-00056J-Bx
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 10:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab2KHJMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2012 04:12:40 -0500
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:9293 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752102Ab2KHJC0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2012 04:02:26 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2012 04:02:26 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhJAAGdym1BHynyrPGdsb2JhbAANN4pSuTEBAQEBOC2DIAUbgQkaE7Emk3uRc2EDiFqgdQ
Received: from c-71-202-124-171.hsd1.ca.comcast.net (HELO [192.168.120.21]) ([71.202.124.171])
  by ipmail04.adl6.internode.on.net with ESMTP; 08 Nov 2012 19:27:21 +1030
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209150>

Nathan,

I find myself performing similar actions to you: using git add -p to st=
age hunks, sometimes editing the staged patch; and keeping mental notes=
 of things I wanted to revert, sometimes changing them in the editor in=
 another window, and sometimes reverting them after the add session wit=
h git checkout -p).

The interactive staging-and-editing tool could be improved, but I'm not=
 sure that tool should be called 'git add -p'. git add doesn't touch th=
e working tree =97 at least I hope not, because I wouldn't expect it.

But I eagerly support more discussion. If someone does want to add this=
 feature to "git add -p" (or named differently), I'll add a request for=
 another letter (perhaps '!')  to edit the hunk in the working tree.
=09


Jonathon Mah
me@JonathonMah.com
