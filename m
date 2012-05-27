From: Seth Robertson <in-gitvger@baka.org>
Subject: =?windows-1252?Q?Re=3A_Git_hangs_at_=93Writing_objects=3A_11=25?= =?windows-1252?Q?=94?=
Date: Sat, 26 May 2012 23:12:43 -0400
Message-ID: <201205270312.q4R3Chef014187@no.baka.org>
References: <EF4D4C5F-2D6B-46F2-B5A4-9DB1BA55BB6B@att.net> <20120525005156.GC11300@sigill.intra.peff.net> <033AF49C-4CB3-4412-8845-0246D356358C@att.net>
        <2DE05B0B-1D7E-451F-9151-B01CDDF4593E@att.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Timothy Normand Miller <theosib@att.net>
X-From: git-owner@vger.kernel.org Sun May 27 05:12:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYTuc-0007d8-Hl
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 05:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab2E0DMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 23:12:54 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:42057 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751656Ab2E0DMx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 23:12:53 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q4R3CiUn010300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 26 May 2012 23:12:44 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q4R3Chef014187;
	Sat, 26 May 2012 23:12:43 -0400
In-reply-to: <2DE05B0B-1D7E-451F-9151-B01CDDF4593E@att.net>
Comments: In reply to a message from "Timothy Normand Miller <theosib@att.net>" dated "Sat, 26 May 2012 18:54:57 -0400."
Bypass: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198575>


In message <2DE05B0B-1D7E-451F-9151-B01CDDF4593E@att.net>, Timothy Normand Miller writes:

    I did some more research and testing.  This is an ssh problem.  If
    I change the protocol to git://, then I can push remotely all I
    want.  Same for file://.  But using ssh, it hangs.  Since I want
    ssh encryption, I still need to figure out why ssh is going wrong.

You could try smart-http with encryption, either as an experiment or
as a workaround.

http://sethrobertson.github.com/HowToPutGitOnTheWeb/ provides
information on how to put a git repository on the web, with encryption
and password/pam/ldap/public key authentication.

					-Seth Robertson
