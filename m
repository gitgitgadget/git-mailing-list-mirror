From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: some git-commands --help don't act like git commands --help
Date: Mon, 29 Dec 2008 17:53:05 +0900
Message-ID: <20081229175305.6117@nanako3.lavabit.com>
References: <87iqp333bk.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Mon Dec 29 09:55:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHDu4-0000ha-Ti
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 09:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbYL2Ixo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 03:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbYL2Ixn
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 03:53:43 -0500
Received: from karen.lavabit.com ([72.249.41.33]:41615 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706AbYL2Ixn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 03:53:43 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 7AB10C8425;
	Mon, 29 Dec 2008 02:53:42 -0600 (CST)
Received: from 3893.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 8D6MCYTMQY2O; Mon, 29 Dec 2008 02:53:42 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=wc4Ni8c29vjrkn7JxY8JmA7Ntl04Bsq5JGIU8UiQ/6NN3zDf1YdyYF4/n9gh8NnYZQLT06I8RZqY51nhdOM7+q0xWUdg23QzsaxLi+i7MsnYC4wyDpML4TUGD46ZErJHuqr0fopxutXxDjEZUYKutMHmqbICQF3wSh/189tGvBA=;
  h=From:To:Cc:Subject:Date:MIME-Version:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <87iqp333bk.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104085>

Quoting jidanni@jidanni.org:

> Hmmm, some git-commands --help act just like git commands --help,
> $ git commit --help 2>&1|wc -l
> 336
> $ git-commit --help 2>&1|wc -l
> 336
>
> But others don't
> $ git am --help 2>&1|wc -l
> 152
> $ git-am --help 2>&1|wc -l
> 19

Thank you for your observation; what do you want to do about it?

Are you complaining that some commands do not have customized description that is not as long as the full manual page but not as terse as the short help "-h" output? Or are you complaining some other commands do not give you full manual pages for "--help"?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
