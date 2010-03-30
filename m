From: Miles Bader <miles@gnu.org>
Subject: Re: RFC - "git editlog" feature for fixing up local commit messages
Date: Tue, 30 Mar 2010 14:46:34 +0900
Message-ID: <buobpe6bbut.fsf@dhlpc061.dev.necel.com>
References: <20100329133132.GA12201@thyrsus.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Tue Mar 30 07:46:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwUHm-0003v7-1V
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 07:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab0C3Fql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 01:46:41 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:43032 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab0C3Fqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 01:46:40 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o2U5kXBN007875;
	Tue, 30 Mar 2010 14:46:34 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay21.aps.necel.com with ESMTP; Tue, 30 Mar 2010 14:46:34 +0900
Received: from dhlpc061 ([10.114.112.30] [10.114.112.30]) by relay11.aps.necel.com with ESMTP; Tue, 30 Mar 2010 14:46:34 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 344B952E26A; Tue, 30 Mar 2010 14:46:34 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <20100329133132.GA12201@thyrsus.com> (Eric Raymond's message of
	"Mon, 29 Mar 2010 09:31:32 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143547>

Eric Raymond <esr@thyrsus.com> writes:
> There is a semi-documented procedure for amending previous commits
> using an interactive rebase, but trying to understand it makes my
> brain hurt.  Don't want to go there.

I'd recommend becoming familiar with rebase -i anyway -- it's just
plain useful, and really almost trivial to use once you've tried it.

Fixing comment typos is simple using the "r"/"reword" directive, but
the ability to rearrange, drop, and merge commits, is also very
handy and easy using rebase -i.

-Miles

-- 
In New York, most people don't have cars, so if you want to kill a person, you
have to take the subway to their house.  And sometimes on the way, the train
is delayed and you get impatient, so you have to kill someone on the subway.
  [George Carlin]
