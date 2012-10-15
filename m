From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: make test
Date: Mon, 15 Oct 2012 13:52:30 +0200
Message-ID: <507BF8FE.1060502@viscovery.net>
References: <k5gov5$fe1$1@ger.gmane.org> <507BEB12.9040101@viscovery.net> <003101cdaac4$430b7a30$c9226e90$@schmitz-digital.de> <507BF0EA.7000805@viscovery.net> <003801cdaac9$81d5bff0$85813fd0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 13:52:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNjDu-0005Yo-P8
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 13:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab2JOLwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 07:52:32 -0400
Received: from so.liwest.at ([212.33.55.24]:40089 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286Ab2JOLwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 07:52:32 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TNjDi-0004sD-1x; Mon, 15 Oct 2012 13:52:30 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BFE431660F;
	Mon, 15 Oct 2012 13:52:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <003801cdaac9$81d5bff0$85813fd0$@schmitz-digital.de>
X-Enigmail-Version: 1.4.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207739>

Am 10/15/2012 13:37, schrieb Joachim Schmitz:
> ...
> + eval '
>         find .git/objects -type f -print >should-be-empty &&
>         test_line_count = 0 should-be-empty
> '
> ++ find .git/objects -type f -print
> ++ test_line_count = 0 should-be-empty
> ++ test 3 '!=' 3
> +++ wc -l
> ++ test 0 = 0
> + eval_ret=0

This is the key line. If it is 'eval_ret=1' (or other non-zero value),
then the test failed, and the lines above it usually indicate where in the
test snippet the failure occurred.

-- Hannes
