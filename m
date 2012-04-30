From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Mon, 30 Apr 2012 08:19:39 +0000
Message-ID: <20120430081939.GA27715@dcvr.yhbt.net>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
 <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
 <20120427082118.GA7257@dcvr.yhbt.net>
 <20120427082559.GC4023@login.drsnuggles.stderr.nl>
 <20120429082341.GA32664@dcvr.yhbt.net>
 <7vvckihyqm.fsf@alter.siamese.dyndns.org>
 <7vk40yhv5q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
To: Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Mon Apr 30 10:19:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOlph-0007wj-GR
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 10:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939Ab2D3ITk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 04:19:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47538 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688Ab2D3ITk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 04:19:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775361F424;
	Mon, 30 Apr 2012 08:19:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vk40yhv5q.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196545>

Junio C Hamano <gitster@pobox.com> wrote:
> As I am already too deep into today's integration round, I will not be
> rewinding this pull anymore, but on one of my Ubuntu 10.04 boxes, I am
> seeing this:
> 
>     Initialized empty Git repository in
>     /srv/git/t/trash directory.t9118-git-svn-funky-branch-names/project/.git/
>     ValueError svn_auth_get_platform_specific_client_providers is not implemented yet

Which version of SVN is that?  (git svn --version)
http://packages.ubuntu.com/lucid/libsvn-perl says 1.6.6
(+distro patches), which shouldn't be affected by this patch...

Matthijs: any suggestions/ideas on what could be wrong?

> So the tip of 'master' may be broken for some "git svn" users.

-- 
Eric Wong
