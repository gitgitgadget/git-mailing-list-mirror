From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: You have local changes; cannot switch branches error question
Date: Fri, 25 Dec 2009 07:59:52 +0900
Message-ID: <20091225075952.6117@nanako3.lavabit.com>
References: <76c5b8580912241425k741b24e9ie8ed92ca7cb8a659@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 25 00:05:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNwkT-0001gk-Pt
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 00:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993AbZLXXCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 18:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755585AbZLXXCi
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 18:02:38 -0500
Received: from karen.lavabit.com ([72.249.41.33]:46648 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755096AbZLXXCi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 18:02:38 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 3C15C157544;
	Thu, 24 Dec 2009 17:02:37 -0600 (CST)
Received: from 1477.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id NAYBLIRTNVPA; Thu, 24 Dec 2009 17:02:37 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=gT2L/qv7v0Nau3eXLSCyMDkZBwqye1biRngbIR4Yb8vAsrj9cEArSeRsDVomcFWWDfHD/mutBTLbcUn2cVFokAzC/i2AmY3HL7fxt4DFpU4Vmxodp7ETuLXgIbyAC65xMuITjfoj/hrlcvvS/UsJDeNiteHJOYXvSsCZ55cgykc=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <76c5b8580912241425k741b24e9ie8ed92ca7cb8a659@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135662>

Quoting Eugene Sajine <euguess@gmail.com>

> My question is related to the fact that most of the time when i have
> some local file changes Git is switching branches OK. But from time to
> time in some repos I'm hitting this error and I cannot figure out why
> it suddenly starts to complain about it?

The command is telling you that it refrained to overwrite 
your local changes. It's not complaining.  There is an 
excellent summary of what switching branches with 'git 
checkout' while you have local changes in your working tree.

http://thread.gmane.org/gmane.comp.version-control.git/77700/focus=77708

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
