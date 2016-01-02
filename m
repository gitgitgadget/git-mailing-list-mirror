From: David Greene <greened@obbligato.org>
Subject: Remote subtree split --annotate
Date: Sat,  2 Jan 2016 14:36:23 -0600
Message-ID: <1451766984-4648-1-git-send-email-greened@obbligato.org>
Cc: techlivezheng@gmail.com, alex.crezoff@gmail.com, davvid@gmail.com,
	cbailey32@bloomberg.net, danny0838@gmail.com, prohaska@zib.de,
	th.acker@arcor.de, sschuberth@gmail.com, peff@peff.net,
	gitter.spiros@gmail.com, nod.helm@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 02 21:36:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aFSup-0001yy-Ie
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jan 2016 21:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbcABUgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2016 15:36:39 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:43516 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751590AbcABUgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2016 15:36:39 -0500
Received: from 206-55-177-216.fttp.usinternet.com ([206.55.177.216] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aFSvV-0002zw-00; Sat, 02 Jan 2016 14:37:25 -0600
X-Mailer: git-send-email 2.6.1
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283268>

This is a fairly simple patch to remove subtree's split --annotate
option.  The intent of the option is to mark commits split from
a subdirectory but git has other tools more suitable for editing
commit messages.  Given --annotate an --unannotate feature seems
obvious and in fact was requested at one point.  Discussion ensued
and it became clear that the definition of --unannotate is not
obvious given the multitude of ways one might want to rewrite a
commit message.

Since it is simple to run other git commit message rewriting tools
on commits split from a subdirectory, it seems best to just
get git-subtree out of the commit rewriting business altogether.
