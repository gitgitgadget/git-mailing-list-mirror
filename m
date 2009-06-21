From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Mon, 22 Jun 2009 06:34:05 +0900
Message-ID: <20090622063405.6117@nanako3.lavabit.com>
References: <19004.34350.109422.730109@cargo.ozlabs.ibm.com>
	<slrnh3ru9v.vgo.sitaramc@sitaramc.homelinux.net>
	<7v3a9uszzl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 23:35:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIUgs-0004m6-VR
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 23:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbZFUVe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 17:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724AbZFUVe4
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 17:34:56 -0400
Received: from karen.lavabit.com ([72.249.41.33]:45397 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585AbZFUVez (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 17:34:55 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 0CA5911B7B1;
	Sun, 21 Jun 2009 16:34:58 -0500 (CDT)
Received: from 4674.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 36YU9ES1GPQX; Sun, 21 Jun 2009 16:34:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Vi0FkamTnTzZWmlrzcANqCNPTzFQxBpSK9/4WV6vJWbAkF0+F1B/S/cQdMLbIxYjzXptJK7Nxr66IQw3lvnCKdzRxYtBwfl4va2Iz9CisvhdR9BUB2QzfY4Z1V+VmklHWyfL/912SQjGH2HYL0DWSAR1xZPeqrrm/14Mk1J6U34=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v3a9uszzl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121994>

Quoting Junio C Hamano <gitster@pobox.com>:

> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> At the command line, this gives you a detailed warning message, but the
>> GUI currently allows it without any fuss.
>>
>> Since the GUI is often used by people much less familiar with git, it
>> seems reasonable to make the GUI more restrictive than the command line,
>> not less.
>> ...
>> This patch helps me a lot.
>
> The patch seems to disable checkout unconditionally, but it at least needs
> an "expert mode" switch to bypass the patch's logic, or (better yet) a
> "training wheel" switch for you to set in repositories of the people you
> manage.

It will be more helpful if it checked out a new local branch that tracks the remote branch, instead of refusing what the user asked to do. It may need a new dialog that asks to confirm (and allows the user to change) the name of the new branch.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
