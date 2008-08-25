From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Is there have development library or API for git ?
Date: Sun, 24 Aug 2008 21:12:17 -0700
Message-ID: <20080825041217.GA19127@spearce.org>
References: <976e6d070808242025n24b282dei5c79b4c9bf2e390e@mail.gmail.com> <976e6d070808242109s53af2624td45dbb936ca25896@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sky Patrick <patricksky852@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 06:13:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXTSF-0003kU-RU
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 06:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbYHYEMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 00:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbYHYEMS
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 00:12:18 -0400
Received: from george.spearce.org ([209.20.77.23]:55587 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbYHYEMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 00:12:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 34C4338375; Mon, 25 Aug 2008 04:12:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <976e6d070808242109s53af2624td45dbb936ca25896@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93592>

Sky Patrick <patricksky852@gmail.com> wrote:
> Is there have development library or API for git ? Thank ~

No.  However you can look at jgit if you are programming in Java.
In Ruby look up Grit (a wrapper around the plumbing commands), or
the pure-Ruby implementation of Git (I forget its name).

Anything else, use the plumbing commands and just fork+exec what
you need.  Many of them have a -z flag to use null termination
on records, making it easier (and safer) to slurp data that may
contain LFs.

-- 
Shawn.
