From: John Feuerstein <john@feurix.com>
Subject: Re: Feature request: option to not fetch tags for 'git remote' branches
Date: Wed, 24 Mar 2010 22:08:43 +0100
Message-ID: <4BAA7F5B.2040400@feurix.com>
References: <201003242154.29245.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Wed Mar 24 22:19:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuXz9-0001Io-Nn
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 22:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505Ab0CXVT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 17:19:27 -0400
Received: from mx1.cluster1.pyrox.eu ([78.46.200.211]:52883 "EHLO
	mx1.cluster1.pyrox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab0CXVT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 17:19:26 -0400
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Mar 2010 17:19:26 EDT
Received: from [192.168.10.100] (ip-81-210-160-120.unitymediagroup.de [81.210.160.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.cluster1.pyrox.eu (PX-MAIL) with ESMTPSA id 930A418049;
	Wed, 24 Mar 2010 22:08:43 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100311 Thunderbird/3.0.3
In-Reply-To: <201003242154.29245.elendil@planet.nl>
X-Enigmail-Version: 1.0.1
OpenPGP: id=5C7CB166
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143128>

Hello Frans,

> It would be great to be able to tell 'git remote' to skip tags and only 
> fetch the requested branch. A --no-tags option maybe?
> 
> AFAIK this is currently not possible, although I'd happy to be proven 
> wrong.

have a look at -n, --no-tags provided by git-fetch, ie.

$ git remote add ... foo ...
$ git fetch -n foo


Regards,
John
