From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Add --allow-eof-whitelines to git-apply while still doing  whitespace trailing-space fixing.
Date: Wed, 05 Aug 2009 06:15:19 +0900
Message-ID: <20090805061519.6117@nanako3.lavabit.com>
References: <f002290c0908010957pf14d18dv7c80270eb9af3c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Thell Fowler <tbfowler4@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:15:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYRMH-00053A-DA
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 23:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbZHDVPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 17:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbZHDVPi
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 17:15:38 -0400
Received: from karen.lavabit.com ([72.249.41.33]:43989 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932419AbZHDVPi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 17:15:38 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 33CCC11B9BE;
	Tue,  4 Aug 2009 16:15:39 -0500 (CDT)
Received: from 9884.lavabit.com (190-14-246-42.ip.mediacommerce.com.co [190.14.246.42])
	by lavabit.com with ESMTP id IG7KU5L9UGIH; Tue, 04 Aug 2009 16:15:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=I/Pwz5Ayp7b4Ii/nU6X+/lPwl11SzaqUcx9ugzQXoAiue6/GZQ712cNVYQ3SqBibcQsr1N0PQG9oCVNnR/9lNtwB+QFU9zTpKs39Fcn1fh1R/U+E4ZzKymGWt/kmdE7DZVkMo+qrW4Gqc6xXcCWhtmaq1vxeJeLpPZk+P9Tu/5I=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <f002290c0908010957pf14d18dv7c80270eb9af3c8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124813>

Quoting Thell Fowler <tbfowler4@gmail.com>

>   - Added --allow-eof-whitelines to git apply to short-circuit removal
> of new empty lines when tailing-space is set.
>   - Added pass-through to apply from git-am.sh
>   - Added pass-through to git-am from git-rebase.sh
>   - Added the auto-completion entries.
>
> Signed-off-by: TBFowler <thell@almostautomated.com>

I like this new feature. However, this topic came up last week, and Junio said that whitespace checking should be controlled with the attributes mechanism.

http://thread.gmane.org/gmane.comp.version-control.git/124113/focus=124138

Please do not talk "I did this, I did that" in your proposed commit log
message.  From Documentation/SubmittingPatches:

	- the body should provide a meaningful commit message, which:
		- uses the imperative, present tense: "change",
		  not "changed" or "changes".
		- includes motivation for the change, and contrasts
		  its implementation with previous behaviour

In other words, the messages are often written as if you are giving an order to the program to correct itself.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
