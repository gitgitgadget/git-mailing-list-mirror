From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] reset: update help text
Date: Thu, 31 Mar 2011 16:57:41 -0500
Message-ID: <20110331215741.GA20474@elie>
References: <1301404805-12095-1-git-send-email-pclouds@gmail.com>
 <20110329210457.GA14031@elie>
 <AANLkTiknvWE9Fe3u88Jbis4Cgxd5ubqaR6MzYOJZ-AtM@mail.gmail.com>
 <20110331184246.GA19264@elie>
 <7v39m3j780.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 23:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5PsL-0007zk-KA
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 23:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758985Ab1CaV5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 17:57:52 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47855 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576Ab1CaV5u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 17:57:50 -0400
Received: by yxs7 with SMTP id 7so1168441yxs.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7I+rcqpNtbiSy99kmpwrMUG4Vy1dfc7+uLT5fifRstg=;
        b=oViO5Tti2dQAwpPp1np73tyYa6hWgr0hylJfpzqV/1BXiGAfGSr6hdN7TeehQASIWI
         Vv0h2nOWfvuGv6c/VE9AXIy5El5aMOaCTuNn2IYLBzZFDdP1wHKILcaJ7+KYtGjX/wEz
         L59Kv+H6apY6Ax6iBUyz4rnFoBvDSRYHdYKpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mbAvQJjTjmoXuPT5+F7r/QyhkcFjJBABQhcfcvFLmzb9uAQihph2G810jVgnmbDySZ
         wv2go7+kmcHSuOWPLRshet3UDr8gd91jYV+/4uZJl+ob+TS/mvChbpJVl65O0lTzodpO
         z3RI9WLlmdlEYYtDgUm04286kIO8Eok7bNS1A=
Received: by 10.151.124.6 with SMTP id b6mr3167126ybn.267.1301608670346;
        Thu, 31 Mar 2011 14:57:50 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id u35sm680239yba.12.2011.03.31.14.57.48
        (version=SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 14:57:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v39m3j780.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170535>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> [1] Detailed semantics: for each path listed by "git diff --name-only
>> HEAD <commit>":
>>
>>  * if the worktree, index, and HEAD match, make the index and worktree
>>    match <commit>.
>>
>>  * otherwise, if it is "not easy" to keep local changes, error out.
>>    We are not going to do a three-way merge.  That is,
>>
>>    - if the index matches neither HEAD nor <commit>, error out;
>>    - if the index matches HEAD but not the worktree, error out.
>>
>>  * otherwise, it is "easy", so keep local changes.
>>
>>    - if the index already matches <commit>, leave the index and
>>      worktree alone.
>>    - if the index and worktree match HEAD, make them match the
>>      <commit> instead.
>
> The latter item in the last "otherwise" is the same as the first "if all
> match, move to the one from the named commit", isn't it?

Yes, sorry for the nonsense.
