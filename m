From: Josef Wolf <jw@raven.inka.de>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Fri, 14 Feb 2014 16:16:19 +0100
Message-ID: <20140214151619.GB17817@raven.inka.de>
References: <20140214113136.GA17817@raven.inka.de>
 <87a9dt981o.fsf@igel.home>
 <CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 14 16:20:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEKYu-0001Q2-3U
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 16:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbaBNPUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 10:20:14 -0500
Received: from quechua.inka.de ([193.197.184.2]:57940 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbaBNPUN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 10:20:13 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1WEKYl-0001Yd-Ug; Fri, 14 Feb 2014 16:20:11 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 112667629A; Fri, 14 Feb 2014 16:16:19 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242104>

On Fri, Feb 14, 2014 at 07:59:18PM +0700, Duy Nguyen wrote:
> On Fri, Feb 14, 2014 at 7:45 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> > Josef Wolf <jw@raven.inka.de> writes:
> >
> >> Notice the refs/heads _within_ refs/heads!
> > Probably you did something like "git branch refs/heads/master".  You can
> > remove it again with "git branch -d refs/heads/master".
> As a porcelain, "git branch" should prevent (or at least warn) users
> from creating such refs, I think.

I don't think I did it the way Andreas thinks. This repository is maintained
by a script, I don't create branches manually. The only command in this script
that uses "heads" is

  git symbolic-ref HEAD "refs/heads/$new_branch"

to create new branches without any ancestry. And I double-checked that this
command is _not_ resposible for those ghost branches.

BTW: I see such ghost branches reappearing again and again, so it must be
     something systematic.

-- 
Josef Wolf
jw@raven.inka.de
