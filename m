From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] config.txt: alphabetize configuration variable groups
Date: Mon, 24 Nov 2008 08:28:27 +0100
Message-ID: <492A579B.5000304@viscovery.net>
References: <1227510109.32583.2.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 08:29:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4VtC-0005JE-87
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 08:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbYKXH2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 02:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbYKXH2a
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 02:28:30 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12976 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYKXH23 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 02:28:29 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L4Vrv-0008D2-5B; Mon, 24 Nov 2008 08:28:27 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E18CA4E4; Mon, 24 Nov 2008 08:28:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1227510109.32583.2.camel@mattlaptop2.local>
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Matt McCutchen schrieb: > @@ -963,6 +953,8 @@ man.<tool>.path::
	> Override the path for the given tool that may be used to > display help
	in the 'man' format. See linkgit:git-help[1]. > > +include::merge-config.txt[]
	> + > merge.conflictstyle:: > Specify the style in which conflicted hunks
	are written out to > working tree files upon merge. The default is "merge",
	which [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101594>

Matt McCutchen schrieb:
> @@ -963,6 +953,8 @@ man.<tool>.path::
>  	Override the path for the given tool that may be used to
>  	display help in the 'man' format. See linkgit:git-help[1].
>  
> +include::merge-config.txt[]
> +
>  merge.conflictstyle::
>  	Specify the style in which conflicted hunks are written out to
>  	working tree files upon merge.  The default is "merge", which

Here, the list is not in alphabetic order anymore.

BTW, your commit message should emphasize the use-cases where an
alphabetic order is a real benefit. Otherwise, this is just code churn.

-- Hannes
