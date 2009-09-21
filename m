From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Trivial fix: Make all the builtin usage strings to use
 the same pattern.
Date: Mon, 21 Sep 2009 18:09:24 +0200
Message-ID: <4AB7A534.2070406@viscovery.net>
References: <1253452645-3220-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 18:09:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MplST-0001UT-OT
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 18:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbZIUQJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 12:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbZIUQJY
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 12:09:24 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15217 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbZIUQJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 12:09:21 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MplS8-0006fM-JO; Mon, 21 Sep 2009 18:09:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 636E36D9; Mon, 21 Sep 2009 18:09:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1253452645-3220-1-git-send-email-tfransosi@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128894>

Thiago Farina schrieb:
> They follow the pattern of file name:
> File name pattern: builtin-command-name.c
> Usage string pattern: builtin_command_name_usage

Well, file names are not so constant: every now and then an external
command is turned into a builtin (and the filename is changed), and we
have even seen that a builtin was turned into an external command.
Moreover, some commands are implemented in the same file, for example 'git
log' and 'git show'. How about naming the variable after the command name?
E.g.:

command:  git cat-file
variable: git_cat_file_usage

-- Hannes
