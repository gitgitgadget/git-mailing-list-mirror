From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 05/11] Documentation/replace: add Creating
 Replacement Objects section
Date: Sun, 01 Sep 2013 12:27:16 +0200 (CEST)
Message-ID: <20130901.122716.141236934846069455.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
	<20130831191215.26699.37641.chriscool@tuxfamily.org>
	<23F4E42FEAEB41DCA9B6F18EED5DD4D0@PhilipOakley>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, trast@inf.ethz.ch,
	j6t@kdbg.org
To: philipoakley@iee.org
X-From: git-owner@vger.kernel.org Sun Sep 01 12:27:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG4sQ-0002sV-HJ
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 12:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab3IAK1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 06:27:22 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:60471 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab3IAK1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 06:27:22 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 95A0D43;
	Sun,  1 Sep 2013 12:27:18 +0200 (CEST)
In-Reply-To: <23F4E42FEAEB41DCA9B6F18EED5DD4D0@PhilipOakley>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233583>

From: "Philip Oakley" <philipoakley@iee.org>
>
> From: "Christian Couder" <chriscool@tuxfamily.org>
>
>> +CREATING REPLACEMENT OBJECTS
>> +----------------------------
>> +
>> +linkgit:git-filter-branch[1], linkgit:git-hash-object[1] and
>> +linkgit:git-rebase[1],
> 
> Let's not forget the obvious 'git commit' or 'git merge' on a
> temporary branch for creating a replacement commit.

As it is obvious, and as it is somehow addressed in the below part of
this section, I don't think it is worth talking about git commit or
git merge or git cherry-pick or any other command.
 
> In particular we need to have covered the alternate to a graft of "A B
> C" (i.e. A is now a merge of B & C) if we are to deprecate grafts with
> any conviction. (https://git.wiki.kernel.org/index.php/GraftPoint)

Adding such an example in a new EXAMPLE section would address this
better. If people agree I will do it in a following patch.

>> among other git commands, can be used to create
>> +replacement objects from existing objects.
>> +
>> +If you want to replace many blobs, trees or commits that are part of
>> a
>> +string of commits, you may just want to create a replacement string
>> of
>> +commits and then only replace the commit at the tip of the target
>> +string of commits with the commit at the tip of the replacement
>> string
>> +of commits.

Thanks,
Christian.
