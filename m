From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Nov 2011, #03; Sun, 13)
Date: Mon, 14 Nov 2011 08:19:29 +0100
Message-ID: <4EC0C101.4060001@viscovery.net>
References: <7vmxbzl5ch.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Vincent van Ravesteijn <vfr@lyx.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 08:20:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPqqF-0005SY-Ey
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 08:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab1KNHUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 02:20:20 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9017 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751174Ab1KNHUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 02:20:19 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RPqpx-0001jk-NH; Mon, 14 Nov 2011 08:20:13 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5BE8A1660F;
	Mon, 14 Nov 2011 08:20:13 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <7vmxbzl5ch.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185367>

IMO, these two topics can move forward:

> * vr/msvc (2011-10-31) 3 commits
>  - MSVC: Remove unneeded header stubs
>  - Compile fix for MSVC: Include <io.h>
>  - Compile fix for MSVC: Do not include sys/resources.h
> 
> It seems this needs to be rehashed with msysgit folks.

With these patches, git can be built with MSVC. The result is usable,
although a few tests still fail.

> * na/strtoimax (2011-11-05) 3 commits
>  - Support sizes >=2G in various config options accepting 'g' sizes.
>  - Compatibility: declare strtoimax() under NO_STRTOUMAX
>  - Add strtoimax() compatibility function.
> 
> It seems this needs to be rehashed with msysgit folks.

There were a few curiosities around strtoimax being present in MinGW or
not, but these have been resolved. Also, whether or not we should define
NO_STRTOUMAX for the MinGW build is an independent matter.

-- Hannes
