From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] Implement unstage and reset modes for git-add--interactive
Date: Sat, 25 Jul 2009 01:17:28 +0200
Message-ID: <200907250117.31847.trast@student.ethz.ch>
References: <200907231041.32567.trast@student.ethz.ch> <7vocrakpbo.fsf@alter.siamese.dyndns.org> <20090725065822.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 01:18:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUU1e-00015K-Hr
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 01:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbZGXXRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 19:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbZGXXRp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 19:17:45 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:42677 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754989AbZGXXRo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 19:17:44 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 01:17:43 +0200
Received: from thomas.localnet ([129.132.209.125]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 01:17:42 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <20090725065822.6117@nanako3.lavabit.com>
X-OriginalArrivalTime: 24 Jul 2009 23:17:43.0259 (UTC) FILETIME=[F2520AB0:01CA0CB4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123974>

Nanako Shiraishi wrote:
> Quoting Junio C Hamano <gitster@pobox.com>
> 
> > "resetting index entries selectively" makes perfect sense.  So do
> > "checking out index entries selectively" and "adding to index
> > selectively".
> 
> Are you saying that you are fine with the concept of Thomas'es patch
> series but you don't want to see different words used to name these
> operations?
> 
> In other words, do you mean the following would be a pair of better
> companions to "git add -p $file" than Thomas'es discard and unstage?
> 
>  - "git checkout -p $file" and "git checkout -p $commit $file" [...]
>  - "git reset -p $file" and "git reset -p $commit $file" [...]

I'd be quite interested to hear some opinions on this.  I wasn't sure
what to do and eventually opted for unstage/discard because I felt
'git checkout -p $file' was not an accurate description of what it
does, but maybe I just have the mental blocks in the wrong places.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
