From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH 0/7] guilt patches, including git 1.8 support
Date: Sun, 27 Jan 2013 09:38:58 -0500
Message-ID: <20130127143858.GA101013@meili.valhalla.31bits.net>
References: <20130116022606.GI12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>,
	Theodore Ts'o <tytso@mit.edu>, Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 15:39:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzTOJ-0006oA-0N
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 15:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab3A0OjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 09:39:05 -0500
Received: from josefsipek.net ([64.9.206.49]:1702 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754965Ab3A0OjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 09:39:04 -0500
Received: from meili.valhalla.31bits.net (c-68-40-59-75.hsd1.mi.comcast.net [68.40.59.75])
	by josefsipek.net (Postfix) with ESMTPSA id 0ECCC11840;
	Sun, 27 Jan 2013 09:39:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130116022606.GI12524@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214702>

On Tue, Jan 15, 2013 at 06:26:06PM -0800, Jonathan Nieder wrote:
> Hi Jeff and other guilty parties,
> 
> I collected all the guilt patches I could find on-list and added one
> of my own.  Completely untested, except for running the regression
> tests.  These are also available via git protocol from
> 
>   git://repo.or.cz/guilt/mob.git mob
> 
> Thoughts?

Sorry for taking so long.  I finally reclaimed access to
git://repo.or.cz/guilt.git.  I pulled from mob, and merged it with what I
had locally.

http://repo.or.cz/w/guilt.git

Thanks for collecting all these in one place!

Jeff.

> Jonathan Nieder (1):
>   Drop unneeded git version check.
> 
> Per Cederqvist (6):
>   get rid of "cat: write error: Broken pipe" error message
>   The tests should not fail if log.date or log.decorate are set.
>   Testsuite: get rid of "Broken pipe" errors from yes.
>   Handle empty patches and patches with only a header.
>   Fix fatal "guilt graph" error in sha1sum invocation.
>   Change git branch when patches are applied.
> 
>  Documentation/guilt.7 |   4 +
>  guilt                 |  73 +++++---
>  guilt-branch          |  12 +-
>  guilt-commit          |   7 +
>  guilt-import-commit   |   4 +-
>  guilt-repair          |   7 +-
>  os.Darwin             |   7 +-
>  os.Linux              |   7 +-
>  os.SunOS              |   7 +-
>  regression/scaffold   |   7 +-
>  regression/t-029.sh   |   6 +-
>  regression/t-052.out  |  24 +--
>  regression/t-052.sh   |   7 +-
>  regression/t-061.out  | 468 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  regression/t-061.sh   | 148 ++++++++++++++++
>  15 files changed, 743 insertions(+), 45 deletions(-)
>  create mode 100644 regression/t-061.out
>  create mode 100755 regression/t-061.sh

-- 
I have always wished for my computer to be as easy to use as my telephone;
my wish has come true because I can no longer figure out how to use my
telephone.
		- Bjarne Stroustrup
