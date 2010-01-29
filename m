From: Jonathan del Strother <maillist@steelskies.com>
Subject: v1.7.0-rc0 shows lots of "unable to find <sha1>" on git-stash
Date: Fri, 29 Jan 2010 15:12:04 +0000
Message-ID: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 16:12:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NasWR-0000Tb-SO
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 16:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073Ab0A2PMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 10:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755985Ab0A2PMb
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 10:12:31 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:46432 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab0A2PMa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 10:12:30 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:38606)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1NasWM-0006uq-0d
	for git@vger.kernel.org; Fri, 29 Jan 2010 10:12:30 -0500
Received: by ewy28 with SMTP id 28so207386ewy.28
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 07:12:25 -0800 (PST)
Received: by 10.216.93.1 with SMTP id k1mr311635wef.151.1264777944249; Fri, 29 
	Jan 2010 07:12:24 -0800 (PST)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138323>

Heya,

git-stash in v1.7.0-rc0 gives me several hundred lines of :

error: unable to find dd4a345a770f5c82a668932b7289f42b1ae38103
error: unable to find dd4a345a770f5c82a668932b7289f42b1ae38103
error: unable to find dd4a345a770f5c82a668932b7289f42b1ae38103
....
error: unable to find 0dc67edc22017de22161dde93baa615767b9c6e0
error: unable to find 0dc67edc22017de22161dde93baa615767b9c6e0
error: unable to find 0dc67edc22017de22161dde93baa615767b9c6e0
error: unable to find 0dc67edc22017de22161dde93baa615767b9c6e0
....
error: unable to find 980f084e71097df3d4086aaab574972321df80f2
error: unable to find 980f084e71097df3d4086aaab574972321df80f2
error: unable to find 980f084e71097df3d4086aaab574972321df80f2
error: unable to find 980f084e71097df3d4086aaab574972321df80f2


Other than that, it appears to work fine.  'git show <sha1>' works too
- they're all a bunch of file contents, with no particular pattern.

This only happens in my main (private) repo.  I can't seem to come up
with a reproducible example for anyone else...

The previous build I was using -
5b15950ac414a8a2d4f5eb480712abcc9fe176d2 from Jan 19th - didn't show
this problem.  Want me to try and bisect further?


-Jonathan
