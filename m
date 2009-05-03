From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] mergetool--lib: specialize diff options for emerge and ecmerge
Date: Sun, 3 May 2009 08:27:56 +0200
Message-ID: <200905030827.56932.markus.heidelberg@web.de>
References: <1241254641-54338-1-git-send-email-davvid@gmail.com> <20090502194636.GA599@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, marcin.zalewski@gmail.com,
	charles@hashpling.org, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 08:28:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0VB9-0000eB-5D
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 08:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbZECG1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 02:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbZECG1v
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 02:27:51 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:57731 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbZECG1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 02:27:50 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 129A410139770;
	Sun,  3 May 2009 08:27:48 +0200 (CEST)
Received: from [89.59.70.225] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M0VAx-0002kO-00; Sun, 03 May 2009 08:27:47 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090502194636.GA599@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19AdQSezoITO8c6U2nLIwBnVQyT7UT1KTRZsf8h
	L4FjbAE62oNWyliOsABbFZ63+R6QJx38uH64wSTj7rD8No9jdp
	lJF9BKbX7GW1W4WZOs7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118163>

David Aguilar, 02.05.2009:
> I installed ecmerge on a mac today and gave this a try.
> ecmerge is indeed better with this patch.
> 
> After configuring the path it all "just works":
> 
> $ git config --global mergetool.ecmerge.path \
> 	/Applications/ECMerge.app/Contents/MacOS/guimerge

Would it make sense to set merge_tool_path to guimerge by default then?

Markus
