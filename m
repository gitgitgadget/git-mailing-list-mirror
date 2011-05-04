From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] t3700: note a .gitignore matching fault
Date: Wed, 04 May 2011 08:06:37 +0200
Message-ID: <4DC0ECED.2020409@viscovery.net>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com> <1304340923-15927-1-git-send-email-pclouds@gmail.com> <4DBEC766.8020008@viscovery.net> <BANLkTik=GYXUOeo3hA5yyXfOuBydT40koA@mail.gmail.com> <7voc3jis61.fsf@alter.siamese.dyndns.org> <BANLkTi=ZL5aPnPMXai==gyjYRT_LHovisA@mail.gmail.com> <7vd3jzgww8.fsf@alter.siamese.dyndns.org> <BANLkTinSx=MAkF5mt8gReNd1qEaeFTEBpA@mail.gmail.com> <BANLkTi=TNjUaD4EP8sYXDqJ-tmBEzz4t4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 08:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHVEU-0002z8-W4
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 08:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613Ab1EDGGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 02:06:41 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12853 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab1EDGGk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 02:06:40 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QHVEM-00053C-4m; Wed, 04 May 2011 08:06:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D96F61660F;
	Wed,  4 May 2011 08:06:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <BANLkTi=TNjUaD4EP8sYXDqJ-tmBEzz4t4w@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172717>

Am 5/4/2011 3:05, schrieb Nguyen Thai Ngoc Duy:
> Maybe something like this instead of a implemantation fix?

Yes, but...

> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 8416f34..81e9d43 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -71,6 +71,8 @@ PATTERN FORMAT
>     matching file excluded by a previous pattern will become
>     included again.  If a negated pattern matches, this will
>     override lower precedence patterns sources.
> +   If a directory is excluded by earlier patterns, negated
> +   patterns that touch files inside the directory will be ignored.
> 
>   - If the pattern ends with a slash, it is removed for the
>     purpose of the following description, but it would only find
> 

... as I already said here:

http://thread.gmane.org/gmane.comp.version-control.git/170907/focus=170916

I think that this is not quite the right place to mention this
restriction. See my proposal in the same post.

-- Hannes
