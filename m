From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pre-receive - 1st push / rev-list didn't work
Date: Mon, 28 Jun 2010 11:03:24 -0700
Message-ID: <20100628180324.GD2337@spearce.org>
References: <AANLkTikGtbfcHCUXm7aVljj_Opb3blKWC0dzfq_HiV8-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 20:03:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTIgJ-0001HX-Ex
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 20:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677Ab0F1SDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 14:03:38 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63900 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845Ab0F1SD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 14:03:27 -0400
Received: by pvg2 with SMTP id 2so2066880pvg.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 11:03:27 -0700 (PDT)
Received: by 10.142.8.21 with SMTP id 21mr4153188wfh.175.1277748207308;
        Mon, 28 Jun 2010 11:03:27 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id b2sm6268880rvn.7.2010.06.28.11.03.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 11:03:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikGtbfcHCUXm7aVljj_Opb3blKWC0dzfq_HiV8-@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149845>

Mahesh Vaidya <forvaidya@gmail.com> wrote:
> I am writing pre-receive hooks for commit validation. I use command
> "git rev-list <from> <to>" to determine what am I pushing. I can
> possibly pust more than one commit at a time.
> 
> If I am doing 1st ever push ; then <from> becomes "0" (40 times). How
> do I determine what all commits I am pushing i this situations ?

Your hook has to detect the 0x40 case and just omit it from the
command line when you run git rev-list.

-- 
Shawn.
