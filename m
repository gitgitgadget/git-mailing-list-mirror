From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v3 3/4] Add map_user() and clear_mailmap() to mailmap
Date: Wed, 4 Feb 2009 18:15:20 +0900
Message-ID: <20090204181520.6117@nanako3.lavabit.com>
References: <cover.1233584536.git.marius@trolltech.com> <36adb0d2cc4c20c4efb3b03a912b27e67c166855.1233584536.git.marius@trolltech.com> <76e643ff7e99985ce46b6bf36ec967124d7fc6aa.1233584536.git.marius@trolltech.com> <53facc1773745ae477f15103718e08ea6a5ae58d.1233584536.git.marius@trolltech.com> <7v3aeu66hv.fsf@gitster.siamese.dyndns.org> <498956E9.3050606@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 10:18:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUdtQ-0003uM-Eq
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 10:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbZBDJQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 04:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbZBDJQI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 04:16:08 -0500
Received: from karen.lavabit.com ([72.249.41.33]:33284 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754869AbZBDJQG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 04:16:06 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 3B092C86B0;
	Wed,  4 Feb 2009 03:16:04 -0600 (CST)
Received: from 6914.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id QT2BYC9ZYYGH; Wed, 04 Feb 2009 03:16:04 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=txIjJrjUmgUTcptbbpRwrq3z0TO2qGYueLSMeVXQiOy6uMlAqp8VxOU6HrSDaV86K60oqsmD0WDiJ2tmYkUc6Zif0sMGnx+vmWjPYNKX9mnMkEkYd7kkfYLVxBgRZwLGQ6iLxOzEDnfl4YkwWj4oAZ5ZnuYCa8dsqvIcMoCxYgE=;
  h=From:To:Cc:Date:Subject:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <498956E9.3050606@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108320>

Quoting Marius Storm-Olsen <marius@trolltech.com>

>>> @@ -86,6 +95,27 @@ Jane Doe <jane@desktop.(none)>
>>>  Joe R. Developer <joe@random.com>
>>
>> This context line was updated a few days ago (not a big deal, just in case
>> you didn't know).
>
> Right, I saw the patch on the list, but I based the patch series on
> master, which I don't think had the update at the time? Anyways, do
> you prefer the patches based on next instead?
> (Documentation/SubmittingPatches says master, but maybe that has
> changed)

According to "What's in git.git (Feb 2009, #01; Sun, 01), the commit has
been in master for the past few days.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
