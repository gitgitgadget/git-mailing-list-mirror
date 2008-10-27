From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix potentially dangerous uses of mkpath and git_path
Date: Mon, 27 Oct 2008 08:08:37 +0100
Message-ID: <490568F5.9060206@viscovery.net>
References: <20081026215913.GA18594@blimp.localdomain> <20081026220852.GC18594@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 08:10:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuMEk-0004Qv-33
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 08:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbYJ0HIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 03:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbYJ0HIm
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 03:08:42 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48112 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbYJ0HIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 03:08:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KuO5B-0008EC-Gz; Mon, 27 Oct 2008 10:08:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D53246EF; Mon, 27 Oct 2008 08:08:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081026220852.GC18594@blimp.localdomain>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99210>

Alex Riesen schrieb:
> Replace them  with mksnpath/git_snpath and a local buffer
> for the resulting string.

You should describe your definition of "potentially dangerous" to save the
reader some time.

-- Hannes
