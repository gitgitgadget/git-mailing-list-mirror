From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 0/3] sh-i18n--envsubst; case-sensitive getenv on Windows
Date: Mon, 06 Jun 2011 08:57:41 +0200
Message-ID: <4DEC7A65.7020207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 08:57:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTTl4-0002Wd-Lr
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 08:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755692Ab1FFG5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 02:57:49 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35726 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753955Ab1FFG5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 02:57:49 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QTTku-0008Js-50; Mon, 06 Jun 2011 08:57:44 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BF61E1660F;
	Mon,  6 Jun 2011 08:57:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175094>

From: Johannes Sixt <j6t@kdbg.org>

Here are the fixes needed on Windows for the ab/i18n-scripts topic.

Johannes Sixt (3):
  sh-i18n--envsubst: do not crash when no arguments are given
  mingw.c: move definition of mingw_getenv down
  Windows: teach getenv to do a case-sensitive search

 compat/mingw.c      |   47 ++++++++++++++++++++++++++++++++---------------
 sh-i18n--envsubst.c |    1 +
 2 files changed, 33 insertions(+), 15 deletions(-)

-- 
1.7.6.rc0.1186.gfb4fd
