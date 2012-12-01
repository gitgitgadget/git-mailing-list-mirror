From: "=?iso-8859-1?q?Jean-No=EBl?= AVILA" <avila.jn@gmail.com>
Subject: Bug report : gitattribute export-ignore behavior does not match documentation
Date: Sat, 1 Dec 2012 12:24:55 +0100
Message-ID: <201212011224.55686.avila.jn@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 12:25:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TelCH-0001NX-3k
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 12:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722Ab2LALZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Dec 2012 06:25:06 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:33499 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592Ab2LALZF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Dec 2012 06:25:05 -0500
Received: from coriandre.localnet (unknown [IPv6:2a01:e35:2ef1:f910:216:6fff:fe38:e8a3])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 1D940940132
	for <git@vger.kernel.org>; Sat,  1 Dec 2012 12:24:58 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.6.0jna; KDE/4.8.4; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210964>

Tested on latest maint and master.

The 'export-ignore' gitattribute is documented as behaving on a pattern=
, just=20
like in .gitignore.

In repo where I have a tree like this:

=2Egitattributes
figures/
fr/figures/

I want to remove from archive all the figures directories. So I added=20

figures/ export-ignore=20

to the top level .gitattributes file.

but then:

$  git check-attr -a fr/figures
$  git check-attr -a figures
$

If I change the line in .gitattributes to :

figures export-ignore

I get the correct result, but I am not sure to exclude only directories=
=2E

Am I wrong somewhere?

Thank you.

Jean-No=EBl AVILA
