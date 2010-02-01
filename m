From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Bug in git-filter-branch example
Date: Mon, 01 Feb 2010 13:57:29 +0100
Message-ID: <4B66CFB9.2060603@viscovery.net>
References: <557ea2711002010348m57aa31fesd1047cbe3f01cb0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ivo Anjo <knuckles@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 13:57:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbvqT-0001yM-4m
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 13:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734Ab0BAM5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 07:57:32 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21847 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752804Ab0BAM5b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 07:57:31 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NbvqM-0002G0-0m; Mon, 01 Feb 2010 13:57:30 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id AD8301660F;
	Mon,  1 Feb 2010 13:57:29 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <557ea2711002010348m57aa31fesd1047cbe3f01cb0b@mail.gmail.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138608>

Ivo Anjo schrieb:
> I've been working on importing my svn repo into git, and while moving
> some things around using git-filter-branch I ran into a bug in the
> example provided on the manpage:

Thanks for the report, but: Examples are just that: examples. IMO, it is
OK that there are implicit assumptions (such as that only "common" file
names are used in the repo).

Making the example universally applicable would greatly obfuscate the
important messages.

> I ended up using git filter-branch to remove the offending file ("if
> all you have is a hammer..."), and re-adding it after the move.

It seems that the example has met its objective: It showed you how to use
the hammer, and with your creativity mixed in, it enabled you to use the
hammer in new ways.

-- Hannes
