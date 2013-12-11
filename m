From: Stepan Kasal <kasal@ucw.cz>
Subject: gitk "Parent" is wrong
Date: Wed, 11 Dec 2013 17:41:13 +0100
Organization: <)><
Message-ID: <20131211164113.GA14957@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 17:49:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqmyj-0008JO-K0
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 17:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436Ab3LKQth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 11:49:37 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:53766 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab3LKQtf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 11:49:35 -0500
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2013 11:49:34 EST
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 6F5271C00A8
	for <git@vger.kernel.org>; Wed, 11 Dec 2013 17:41:14 +0100 (CET)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id rBBGfEqu014980
	for <git@vger.kernel.org>; Wed, 11 Dec 2013 17:41:14 +0100
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id rBBGfDF4014979
	for git@vger.kernel.org; Wed, 11 Dec 2013 17:41:13 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239207>

Hello.
I noticed a bug in gitk (as delivered with Git for Windows 1.8.4.msysgit.0).

The description of the current commit (left down quarter) does
contain items "Parent:" and "Child:".

This is not true if gitk is called with a <path> parameter.

These should actually be labeled "Previous" and "Next", as they point
to the neighbours is the displayed list of commits.

Have a nice day,
	Stepan Kasal
