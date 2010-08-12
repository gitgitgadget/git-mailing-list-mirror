From: david@lang.hm
Subject: Re: [PATCH V5 00/17] Reroll a version 5 of this series
Date: Thu, 12 Aug 2010 01:31:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008120130280.23369@asgard.lang.hm>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch,
	gitster@pobox.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 10:31:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjTCe-000223-J8
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 10:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933144Ab0HLIbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 04:31:52 -0400
Received: from mail.lang.hm ([64.81.33.126]:37376 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933075Ab0HLIbu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 04:31:50 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id o7C8VHuZ007911;
	Thu, 12 Aug 2010 01:31:17 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153354>

what is this series?

this is all good incramental information, but there's no info indicating 
what this is updating.

David Lang

On Wed, 11 Aug 2010, Bo Yang wrote:

> Changes:
> 1. Fix all format problems;
> 2. Split the "too long" lines in multiple lines;
> 3. '$' to represent the last line of a file;
> 4. Error string change;
> 5. Add more comments;
> 6. Combine test cases together;
> 7. Struct name change
>
> Bo Yang (17):
>  parse-options: enhance STOP_AT_NON_OPTION
>  parse-options: add two helper functions
>  Add the basic data structure for line level history
>  Refactor parse_loc
>  Parse the -L options
>  Export three functions from diff.c
>  Add range clone functions
>  map/take range to the parent of commits
>  Print the line log
>  Hook line history into cmd_log, ensuring a topo-ordered walk
>  Make rewrite_parents public to other part of git
>  Make graph_next_line external to other part of git
>  Add parent rewriting to line history browser
>  Add --graph prefix before line history output
>  Add --full-line-diff option
>  Add tests for line history browser
>  Document line history browser
>
> Documentation/blame-options.txt     |   19 +-
> Documentation/git-log.txt           |   15 +
> Documentation/line-range-format.txt |   18 +
> Makefile                            |    2 +
> builtin/blame.c                     |   89 +--
> builtin/log.c                       |  113 +++-
> diff.c                              |    6 +-
> diff.h                              |   17 +
> graph.c                             |   14 +-
> graph.h                             |   10 +
> line.c                              | 1551 +++++++++++++++++++++++++++++++++++
> line.h                              |  141 ++++
> parse-options.c                     |   22 +-
> parse-options.h                     |    7 +-
> revision.c                          |   25 +-
> revision.h                          |   23 +-
> t/t4301-log-line-single-history.sh  |  627 ++++++++++++++
> t/t4302-log-line-merge-history.sh   |  163 ++++
> 18 files changed, 2733 insertions(+), 129 deletions(-)
> create mode 100644 Documentation/line-range-format.txt
> create mode 100644 line.c
> create mode 100644 line.h
> create mode 100755 t/t4301-log-line-single-history.sh
> create mode 100755 t/t4302-log-line-merge-history.sh
>
>
