From: Cedric Gava <gava.c@free.fr>
Subject: Forcing git top-level
Date: Tue, 31 Mar 2015 11:25:58 +0200
Message-ID: <0FD999DB-3DBF-40D4-8128-715BDC49EAAB@free.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 11:26:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcsR6-0007ED-4I
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 11:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbbCaJ0M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2015 05:26:12 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:37302 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbbCaJ0L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2015 05:26:11 -0400
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id EDC8ECA8CD2
	for <git@vger.kernel.org>; Tue, 31 Mar 2015 11:26:04 +0200 (CEST)
Received: from [192.168.77.195] (unknown [82.227.130.118])
	(Authenticated sender: gava.c@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 70F60822FC
	for <git@vger.kernel.org>; Tue, 31 Mar 2015 11:24:33 +0200 (CEST)
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266518>


Hello

I=92ve copied a .git folder located at the root (/) of a filesystem, in=
to another directory (/home/mydir). If I issue a git rev-parse =97show-=
toplevel I got "/"...
I would like to change the top-level to point to /home/mydir.

I=92ve also tried to bare clone the original .git folder, but the new g=
it repo stills points it top-level to "/".

Thank you for your answer

Best regards
Cedric