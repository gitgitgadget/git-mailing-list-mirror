From: Steffen Prohaska <prohaska@zib.de>
Subject: msysgit: should core.autocrlf=true be the default on Windows?
Date: Sat, 11 Aug 2007 22:56:43 +0200
Message-ID: <7816DAAF-53CB-468C-9597-36AA94AC6476@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 22:56:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJy08-000598-Uj
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 22:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730AbXHKUz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 16:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756714AbXHKUz6
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 16:55:58 -0400
Received: from mailer.zib.de ([130.73.108.11]:53855 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756126AbXHKUz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 16:55:57 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7BKtthF004996;
	Sat, 11 Aug 2007 22:55:55 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1a312.pool.einsundeins.de [77.177.163.18])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7BKtsF6016554
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 11 Aug 2007 22:55:54 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55632>

I think core.autocrlf=true should be the default on Windows.
I strongly believe that Windows users expect this default,
as others Windows application rely on it. I recently tried to
use kdiff3 on Windows and got satisfactory results only after
using autocrlf.

autocrlf should be set right from the very beginning. If you
found out about it later, you would have to convert your existing
working trees, which is not too easy. Therefore we should
guide the user to a reasonable default.

We can report the defaults we chose in *bold* after the
installation completed and give a hint where further background
information can be found, and what would be needed to adjust
the default.

What do you think?

Would /etc/gitconfig in msysgit be the right place to set the
default?

	Steffen
