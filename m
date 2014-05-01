From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git
 interpret-trailers'
Date: Thu, 01 May 2014 20:54:38 +0200 (CEST)
Message-ID: <20140501.205438.1173327839304856205.chriscool@tuxfamily.org>
References: <535F8785.10302@game-point.net>
	<CAP8UFD2oXpW9QEkSh+vpNGRAxRFp0zJF39ZZ8sUZLTcKB9mHWQ@mail.gmail.com>
	<535FA83B.3010008@game-point.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, git@vger.kernel.org
To: admin@game-point.net
X-From: git-owner@vger.kernel.org Thu May 01 20:54:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfw85-0002iZ-3q
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 20:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbaEASyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 14:54:41 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:33327 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbaEASyk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 14:54:40 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 1D0BE3A;
	Thu,  1 May 2014 20:54:38 +0200 (CEST)
In-Reply-To: <535FA83B.3010008@game-point.net>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247825>

From: Jeremy Morton <admin@game-point.net>

> On 29/04/2014 12:47, Christian Couder wrote:
>>> Also, if there were no current branch name because you're committing
>>> in a
>>> detached head state, it would be nice if you could have some logic to
>>> determine that, and instead write the trailer as:
>>>          Made-on-branch: (detached HEAD: AB12CD34)
>>
>> You may need to write a small script for that.
>> Then you just need the "trailer.m-o-b.command" config value to point
>> to your script.
>>
>>> ... or whatever.  And also how about some logic to be able to say that
>>> if
>>> you're committing to the "master" branch, the trailer doesn't get
>>> inserted
>>> at all?
>>
>> You can script that too.
> 
> But it would be nicer if the logic were built-in, then you wouldn't
> have to share some script with your work colleagues. :-)

The above logic is very specific to your workflow. For example some
people might a "Made-on-branch: " trailer only when they are on real
branches except "dev" and "master".

Best,
Christian.
