From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git submodules
Date: Sun, 18 Oct 2009 07:30:39 +0900
Message-ID: <20091018073039.6117@nanako3.lavabit.com>
References: <f488382f0910171015j1a6d4d9fg690867154334c514@mail.gmail.com>
    <m3tyxydj8f.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Steven Noonan <steven@uplinklabs.net>,
	crawl-ref-discuss@lists.sourceforge.net
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 00:31:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzHng-0002Ws-BZ
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 00:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbZJQWas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 18:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbZJQWas
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 18:30:48 -0400
Received: from karen.lavabit.com ([72.249.41.33]:55192 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbZJQWas (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 18:30:48 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id A74B211B87B;
	Sat, 17 Oct 2009 17:30:52 -0500 (CDT)
Received: from 9740.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 8PW8KENHS9U5; Sat, 17 Oct 2009 17:30:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=XyCS7fVwGNrI1QCLdKu8Hk8LPhE0j2W8HhZLl3fhf4599bP1g3D3XaTw3YmOlYnUEOdCYuIls3aUMCUv/xskoUONdQXLSzktcx1d0I0QGzgzYut6zYpPZCWG0bjtjYdUnHHZ6AWTJBvohwhqa6eteW2VEbSxP7uoR1qN384dHH4=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <m3tyxydj8f.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130580>

Quoting Jakub Narebski <jnareb@gmail.com>

> Steven Noonan <steven@uplinklabs.net> writes:
>
>> We're using git submodules for the contributing libraries. When I
>> commit changes to those contribs, it correctly shows in the parent
>> repository that those folders have different revisions than what's
>> currently committed. However, if someone pulls those changes, it
>> doesn't automatically update the contribs to match the committed
>> version. But doing a pull or merge _should_ update the working tree to
>> match the committed versions. It does with file data, so why not
>> update the submodules? Especially if the submodule revision matched
>> the committed version -before- the pull. Why are we forced into using
>> 'git submodule update'?
>
> Because you might want not to use most current version of submodule,
> so git-pull shouldn't update submodules by default.  And because
> git-pull didn't learn --recursive option yet.

I don't think your description is correct. Steven is talking about what the command should do by default. If you checked out the current superproject, by default you should get the submodule that matches. If you don't want the most current version, you can checkout an older submodule yourself.

You may want to follow this discussion:

  http://thread.gmane.org/gmane.comp.version-control.git/130155/focus=130330

After stating that he isn't against the idea to make it automatic, Junio describes what needs to be done for it to happen and what are the corner cases that needs to be treated with care.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
