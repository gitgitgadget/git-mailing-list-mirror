From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Repo with only one file
Date: Wed, 07 Aug 2013 12:43:44 +0200
Message-ID: <520224E0.5060206@viscovery.net>
References: <CAH_OBid8SO3ydpjhRHa68s+54CScLh=jactxTQhwQPo-jcnAvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 12:43:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V71Dc-0001T0-2E
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 12:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367Ab3HGKns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 06:43:48 -0400
Received: from so.liwest.at ([212.33.55.14]:60432 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932212Ab3HGKnr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 06:43:47 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1V71DU-0004bw-9D; Wed, 07 Aug 2013 12:43:44 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 11DEF1660F;
	Wed,  7 Aug 2013 12:43:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <CAH_OBid8SO3ydpjhRHa68s+54CScLh=jactxTQhwQPo-jcnAvA@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231819>

Am 8/7/2013 8:24, schrieb shawn wilson:> ... create a repo for one of
> these scripts and I'd like to keep the commit history.
>
> Ok, so:
> % find -type f ! -iname "webban.pl" | while read f; do git
> filter-branch -f --index-filter "git rm --cached --ignore-unmatch $f"
> HEAD ; done
>
> Which basically did it. But, I've got this one commit that seems to be
> orphaned - it doesn't change any files.

Try this:

  git filter-branch HEAD -- webban.pl

-- Hannes
