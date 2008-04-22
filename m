From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Maintaining commit.template config through clones
Date: Tue, 22 Apr 2008 08:12:20 +0200
Message-ID: <480D81C4.2030501@viscovery.net>
References: <48070EA4.2050503@rea-group.com> <48072458.70005@viscovery.net> <480D6D6C.7040708@rea-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Toby Corkindale <toby.corkindale@rea-group.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:13:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoBkb-0006XN-LQ
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 08:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbYDVGMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 02:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbYDVGMX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 02:12:23 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35578 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbYDVGMX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 02:12:23 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JoBjo-0006oe-QZ; Tue, 22 Apr 2008 08:12:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 74EAE6C4; Tue, 22 Apr 2008 08:12:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <480D6D6C.7040708@rea-group.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80064>

Toby Corkindale schrieb:
> Johannes Sixt wrote:
>> Toby Corkindale schrieb:
>>> I'm attempting to implement Git at our company, and we currently use a
>>> commit template for CVS. I can convert this to a Git-formatted template,
>>> and set it for use with git-config commit.template ....
>>>
>>> However, once the repository is cloned, this configuration option
>>> vanishes from .git/config
>>>
>>> Is there a way to make configuration options sticky?
>>
>> Create or edit $prefix/share/git-core/templates/config.
> 
> Thanks.
> Will that keep the commit-template propagated even when the repo is
> cloned from another machine? (ie. using git: or ssh: methods)

No. You have to edit this file on each machine.

-- Hannes
