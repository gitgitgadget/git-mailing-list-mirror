From: Michael Poole <mdpoole@troilus.org>
Subject: Re: Groups of commits
Date: Tue, 27 Apr 2010 22:15:05 -0400
Message-ID: <87sk6ge312.fsf@troilus.org>
References: <j2u43d8ce651004271859t8f306261n330004142a42b6df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 04:15:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6wo0-0000EZ-SM
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 04:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698Ab0D1CPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 22:15:10 -0400
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:54340 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751007Ab0D1CPI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 22:15:08 -0400
Received: from source ([209.85.221.183]) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS9eaKwRAGmcOmTXiHH9R/gIdW8tz2LzX@postini.com; Tue, 27 Apr 2010 19:15:08 PDT
Received: by mail-qy0-f183.google.com with SMTP id 13so17985412qyk.18
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 19:15:07 -0700 (PDT)
Received: by 10.224.52.164 with SMTP id i36mr2042208qag.147.1272420907328;
        Tue, 27 Apr 2010 19:15:07 -0700 (PDT)
Received: from graviton.troilus.org (pool-72-83-66-147.washdc.east.verizon.net [72.83.66.147])
        by mx.google.com with ESMTPS id 23sm3312317qyk.15.2010.04.27.19.15.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 19:15:06 -0700 (PDT)
In-Reply-To: <j2u43d8ce651004271859t8f306261n330004142a42b6df@mail.gmail.com>
	(John Tapsell's message of "Wed, 28 Apr 2010 10:59:44 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Tapsell writes:

> Hi all,
>
>   In my work place, we have a lot of strict rules to get something
> committed.  The code has to pass against a large test suite, it has to
> be tested on different hardware, and so on.
>
>   The problem is that it forces everyone to have one single large
> commit for a week's work.  All the intermediate stages get squashed
> and that history forever lost.
>
>   It would be nice to have a commit in the repository, treated as a
> single commit for all purposes, but then be able to split it into
> multiple commits if necessary.
>
>   Any ideas?

Isn't that what topic branches are for?  When development is done on a
short-lived branch (hopefully one with a descriptive name), the only
commit that needs to go through that process is the merge onto the
integration branch.

Michael Poole
