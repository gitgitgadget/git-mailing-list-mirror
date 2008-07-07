From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current branch
Date: Mon, 07 Jul 2008 15:14:01 +0900
Message-ID: <20080707151401.6117@nanako3.lavabit.com>
References: <7v7iby9ucx.fsf@gitster.siamese.dyndns.org> <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 08:15:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFk0X-00073s-Me
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 08:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbYGGGOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 02:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYGGGOa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 02:14:30 -0400
Received: from karen.lavabit.com ([72.249.41.33]:44875 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbYGGGOa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 02:14:30 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 4D999C8408;
	Mon,  7 Jul 2008 01:14:21 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id HHRITTQC5QX5; Mon, 07 Jul 2008 01:14:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=HkrHrG/ps/N7a/17EsvJ89FxIiYWGys2qtaPnOmmqI9/q0RzilFizI3sGDUqxAJcswRYyrwpT1diL8PGaoojwHQ4Q5MU6MyE7/Kw5bNRqbI7DZIGTQIMaCp+SagVbG0IsAY5WfuQOIHiDClRftyPK1RDBXXmF4NRmI03nvji9lU=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com>;
In-Reply-To: <7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87582>

Quoting Junio C Hamano <gitster@pobox.com>:

> Brian Gernhardt <benji@silverinsanity.com> writes:
>
>> This makes rebase act a little more like merge when working on the
>> current branch.  This is particularly useful for `git pull --rebase`
>>
>> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
>> ---
>>
>>  ARG!  This is what v3 was supposed to be.  I should make sure I am sending in
>>  the correct patch.
>
> Yeah, I was scratching my head about the discrepancy between the revision
> comment and the patch in the previous one.
>
> Having said that, thanks to updates to git-rebase, rebased_branch@{1} has
> useful information these days, so I do not see much practical upside, even
> though I _will_ apply this patch, just for the sake of consistency.

Are you really aiming for consistency, Junio?

Doesn't this make the behavior of the command inconsistent between "git-rebase" and "git-rebase -m"?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
