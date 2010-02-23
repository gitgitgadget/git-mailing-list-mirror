From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] shell setup: clear_local_git_env() function
Date: Tue, 23 Feb 2010 07:49:23 +0100
Message-ID: <4B837A73.8010406@viscovery.net>
References: <7vsk8s274t.fsf@alter.siamese.dyndns.org> <1266881518-11213-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:49:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjoaL-0002YF-VI
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 07:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606Ab0BWGt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 01:49:29 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27581 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab0BWGt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 01:49:28 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NjoaB-0000La-TO; Tue, 23 Feb 2010 07:49:24 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9768E1660F;
	Tue, 23 Feb 2010 07:49:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1266881518-11213-1-git-send-email-giuseppe.bilotta@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140771>

Giuseppe Bilotta schrieb:
> +# Clear repo-local GIT_* environment variables. Useful when switching to
> +# another repository (e.g. when entering a submodule)
> +clear_local_git_env() {
> +	unset	GIT_DIR GIT_WORKTREE GIT_OBJECT_DIRECTORY \
> +		GIT_INDEX_FILE GIT_GRAFT_FILE GIT_CONFIG \
> +		GIT_NO_REPLACE_OBJECTS

IMO, this list should be in sync with the one you find in
connect.c:git_connect() around line 611. They have the same purpose.

(And, BTW, a vertical list would be more readable than a mixed
horizontal+vertical list, IMVHO.)

-- Hannes
