From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: pushing specific branches to a public mirror repos
Date: Fri, 17 Jul 2009 10:51:06 +0200
Message-ID: <4A603B7A.6050208@viscovery.net>
References: <h3pcrg$ekk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 10:51:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRj9w-0001gQ-OV
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 10:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934252AbZGQIvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 04:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934242AbZGQIvI
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 04:51:08 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22730 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934181AbZGQIvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 04:51:08 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MRj9m-0003PO-TA; Fri, 17 Jul 2009 10:51:07 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A8DFF6D9; Fri, 17 Jul 2009 10:51:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <h3pcrg$ekk$1@ger.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123453>

Graeme Geldenhuys schrieb:
> I currently have the following git config setting for the remote github
> repository:
> 
> [remote "github"]
>     url = git@github.com:graemeg/freepascal.git
>     push = +refs/remotes/*:refs/heads/*
> 
> I only want to push the "trunk" and "fixes_2_2" SubVersion branches to
> GitHub as heads. How must I change by remote.github.push config setting,
> or must I do a manual push as I do with the local tracking "master" branch.

You can have more than one push line in the config:

    push = +refs/remotes/trunk:refs/heads/trunk
    push = +refs/remotes/fixes_2_2:refs/heads/fixes_2_2

-- Hannes
