From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: How to check new commit availability without full fetch?
Date: Mon, 11 Jan 2010 08:31:28 +0100
Message-ID: <201001110831.28278.robin.rosenberg@dewire.com>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 11 09:00:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUFCM-000732-Td
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 09:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab0AKIAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2010 03:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287Ab0AKIAV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 03:00:21 -0500
Received: from av7-1-sn3.vrr.skanova.net ([81.228.9.181]:56700 "EHLO
	av7-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab0AKIAV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 03:00:21 -0500
X-Greylist: delayed 1726 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2010 03:00:21 EST
Received: by av7-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id C290238175; Mon, 11 Jan 2010 08:31:32 +0100 (CET)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av7-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 8C9D438155; Mon, 11 Jan 2010 08:31:32 +0100 (CET)
Received: from sleipner.localnet (host-90-232-222-157.mobileonline.telia.com [90.232.222.157])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id D914C37E42;
	Mon, 11 Jan 2010 08:31:31 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136615>

s=F6ndagen den 10 januari 2010 12.12.09 skrev  Leo Razoumov:
> Hi List,
> I am trying to find a way to check availability of new commits
> *before* doing fetch or pull. Unfortunately, neither fetch nor pull
> take "--dry-run" option (unlike push)

=46etch has --dry-run. It's a fairly new option. The drawback is that i=
t
still does the fetch, but it does not update the refs. If you re.run it
again it'll be quicker.

A faster option is to use ls-remote, but you'll have to parse the data
yourself and compare with your remote refs to see what refs has changed=
,
and that will not tell you /what/ the changes are.

-- robin
