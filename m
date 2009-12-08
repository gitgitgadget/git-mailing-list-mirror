From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Tue, 08 Dec 2009 15:01:02 +0900
Message-ID: <20091208150102.6117@nanako3.lavabit.com>
References: <cover.1259934977.git.mhagger@alum.mit.edu> <4B192701.4000308@drmicha.warpmail.net> <vpqfx7qocwl.fsf@bauges.imag.fr> <7vws12r5v2.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302> <20091205062708.6117@nanako3.lavabit.com> <7vd42t6f9i.fsf@alter.siamese.dyndns.org> <20091208121314.6117@nanako3.lavabit.com> <7vtyw2p2ju.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 07:01:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHt8R-0002Ou-7Y
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 07:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935620AbZLHGBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 01:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933014AbZLHGBI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 01:01:08 -0500
Received: from karen.lavabit.com ([72.249.41.33]:52061 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933011AbZLHGBG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 01:01:06 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 037CF11B914;
	Tue,  8 Dec 2009 00:01:13 -0600 (CST)
Received: from 6059.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id RPRZTK0O1GH8; Tue, 08 Dec 2009 00:01:12 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=q8k4HpNJ3Tbj/LmJ1rYS/+2W0C+6jeph/J6DHTNtnRjIDmdCtbaM/IkHAkWiiC/qAZ86eqCRWXVY3Sl/xSAoFdQX/SSt8cfwt4hlxrQlP2OJe0WgA2EeqYUjmzfHXPoQ8hiLvsoWDZSRAMyGTGiPR0e8uLtrEhfYxa4Ko15Cniw=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vtyw2p2ju.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134819>

Quoting Junio C Hamano <gitster@pobox.com>

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> Teach a new option, --autosquash, to the interactive rebase.
>> When the commit log message begins with "!fixup ...", and there
>> is a commit whose title begins with the same ..., automatically
>> modify the todo list of rebase -i so that the commit marked for
>> squashing come right after the commit to be modified, and change
>> the action of the moved commit from pick to squash.
>>
>> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
>
> Hmph, did you forget to retitle the message, or keep in-body "Subject:"?

Sorry. Yes I did. Please amend it to -

 Subject: rebase -i --autosquash: auto-squash commits

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
