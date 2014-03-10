From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Mar 2014, #01; Tue, 4)
Date: Mon, 10 Mar 2014 09:22:38 +0100
Message-ID: <531D764E.2000809@viscovery.net>
References: <xmqqiortijxp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 09:23:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMvUS-0004MD-IG
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 09:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbaCJIWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 04:22:44 -0400
Received: from so.liwest.at ([212.33.55.23]:43149 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbaCJIWn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 04:22:43 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WMvTq-0001kN-SR; Mon, 10 Mar 2014 09:22:38 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 70EE816613;
	Mon, 10 Mar 2014 09:22:38 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqiortijxp.fsf@gitster.dls.corp.google.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243710>

Am 3/5/2014 1:10, schrieb Junio C Hamano:
> * nd/gitignore-trailing-whitespace (2014-02-10) 2 commits
>  - dir: ignore trailing spaces in exclude patterns
>  - dir: warn about trailing spaces in exclude patterns
> 
>  Warn and then ignore trailing whitespaces in .gitignore files,
>  unless they are quoted for fnmatch(3), e.g. "path\ ".
> 
>  Will merge to 'next'.

The new test does not pass on Windows. I'll attempt to prepare patches
that amount to work around using FUNNYNAMES, but I'm running out of time now.

-- Hannes
