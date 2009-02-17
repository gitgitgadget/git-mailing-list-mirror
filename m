From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: List of all tags on a branch/remote-repo
Date: Tue, 17 Feb 2009 19:17:52 +0900
Message-ID: <20090217191752.6117@nanako3.lavabit.com>
References: <f662f0210902160329h2ad09ac3r13c64c1e41947e89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Aneesh Bhasin <contact.aneesh@gmail.com>
To: Jake Goulding <goulding@vivisimo.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:20:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZN3Y-0004cv-LM
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 11:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbZBQKSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 05:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZBQKSc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 05:18:32 -0500
Received: from karen.lavabit.com ([72.249.41.33]:58586 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbZBQKSc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 05:18:32 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 70A6311B8E6;
	Tue, 17 Feb 2009 04:18:31 -0600 (CST)
Received: from 1191.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 5UQECCQC6BUQ; Tue, 17 Feb 2009 04:18:31 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=iO1/VFuGYb9ipfr9qnFXTDbFv9aTNkz7hEGMyaa22U87/iGrsdMvg5/3BBup6Ku0aY3a+LwlMe0NQ6oqslKDq2Tr0XdtFVOGvGUNyFDcfd/0lOwh/TdnnDhgY2b0wJvt21CM2/HBIN80/d0jssHQmPpcjb3CZGL8XLX586wsG5E=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <f662f0210902160329h2ad09ac3r13c64c1e41947e89@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110350>

Quoting Aneesh Bhasin <contact.aneesh@gmail.com>:

> I have a small question. How do I see all the tags that exist on a
> particular branch. eg, if I have two branches : B1 and B2 and B1 has
> tags : T1_1, T1_2... and B2 branch has tags T2_1, T2_2... then if I
> say :
>>git tag
> I will see all the tags (T1_1, T1_2, T2_1, T2_2...). How do I see just
> the tags that exist on branch B2 ?? Is there a single command for it
> or any other way of doing it ?
>
> And extending this concept, if I add a remote tracking repo with the command :
>>git remote add linux-2.6.25_DEV1 /home/DEV1//linux-2.6.25_DEV1/.git
>
> then how do i see all the tags that existed in linux-2.6.25_DEV1
> without showing all the tags in my git repo ??
>
> Thanks in advance..

Jake, last month you ported --contains option from the git-branch command to the git-tag command. Do you have a thought on this question?

I think what Aneesh wants is not --contains but --merged option from the git-branch command, but I am not sure.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
