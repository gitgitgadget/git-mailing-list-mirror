From: David Soria Parra <sn_@gmx.net>
Subject: Re: [PATCH v2] Add --track option to git clone
Date: Wed, 2 Dec 2009 10:33:41 +0000 (UTC)
Message-ID: <slrnhhcgi8.cpv.sn_@experimentalworks.net>
References: <1259707865-6561-1-git-send-email-sn_@gmx.net>
 <20091202192028.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 11:34:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFmXE-00070n-6x
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 11:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbZLBKeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 05:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbZLBKeA
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 05:34:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:45776 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbZLBKd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 05:33:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NFmX6-0006xm-Fa
	for git@vger.kernel.org; Wed, 02 Dec 2009 11:34:04 +0100
Received: from 217.114.211.68 ([217.114.211.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 11:34:04 +0100
Received: from sn_ by 217.114.211.68 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 11:34:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 217.114.211.68
User-Agent: slrn/0.9.9p1 (SunOS)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134327>

On 2009-12-02, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Quoting David Soria Parra <sn_@gmx.net> writes:
>
>> I'm aware that it's not possible to give more than one --track
>> option. Implementing the possibility to specify multiple --track option
>> would certainly a good improvment later, but would also require a lot
>> more work as far as I understand the clone code.
>
> I'm sorry if I'm asking the obvious, but how can multiple --track 
> options be a useful future enhancement? If I understand your use 
> case correctly, it's useful when you want to work on only one 
> branch that isn't the default, and that is why you don't want to 
> get data necessary for other branches. What does it mean to give 
> two --track options? You will get one master branch that tracks
> both versions, and "git pull" will merge both branches you track?

Similar to git remote add --track it'll pull all branches specified by a --track
option and checkout the first one or -o <name> if given. For me personally it's
not an improvemen, because I just need to clone on branch, but as git remote add allows
multiple branches specified by --track I thought this might be an improvment.
