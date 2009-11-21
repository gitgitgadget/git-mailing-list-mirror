From: "Alexander Veit" <alexander.veit@gmx.net>
Subject: Per file configurable eol-style transformations with Git?
Date: Sat, 21 Nov 2009 21:21:40 +0100
Message-ID: <9ED0EB52C33C41209726C6F4DB7FC194@helium>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 21 21:49:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBwsc-00041R-9j
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbZKUUVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 15:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbZKUUVh
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 15:21:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:38005 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752616AbZKUUVh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Nov 2009 15:21:37 -0500
Received: (qmail invoked by alias); 21 Nov 2009 20:21:41 -0000
Received: from pD9E95106.dip.t-dialin.net (EHLO helium) [217.233.81.6]
  by mail.gmx.net (mp058) with SMTP; 21 Nov 2009 21:21:41 +0100
X-Authenticated: #19984920
X-Provags-ID: V01U2FsdGVkX1+TrhpWeDGTUqZdsqIBfbtGhyWqCfv6AfADDaEbEe
	dZQM07nGSkQK2A
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Acpq6DwdYldElqOYQHK7BcsXdmiKVg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6002.18005
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133400>

Hi,

we have projects that contain text files that need to
have different end-of-line sequences, depending on the
type of file, and depending on the operating system where
they are checked out.

There are files that have

 - LF line breaks on each platform,
 - CR LF line breaks on each platform, or
 - either LF or CR LF line breaks, depending on the
   platform's native end-of-line style.

With Subversion, the correct behaviour in checkouts, commits,
diffs, or merges can easily be achieved by setting the appropriate
svn:eol-style [*].

As I understand the Git documentation there's no such concept as a
repository end-of-line style, or as an end-of-line transformation
between repository and working copy.

So I wonder if it is possible to mimic Subversion's end-of-line handling
with Git, especially for the svn:eol-style=native.

-- 
Regards,
Alex


[*]
http://svnbook.red-bean.com/nightly/de/svn-book.html#svn.advanced.props.special.eol-style
