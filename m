From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Git::SVN: handle missing ref_id case correctly
Date: Sat, 10 Jan 2015 22:13:08 +0000
Message-ID: <20150110221308.GA32253@dcvr.yhbt.net>
References: <1420900510-78522-1-git-send-email-artagnon@gmail.com>
 <CALkWK0=jEh06hZSmHim54BaP_KiC8hg-455STQphu17PSoQTqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 23:13:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA4HS-0000og-Gb
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 23:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbbAJWNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 17:13:09 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42380 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbbAJWNI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 17:13:08 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398331FA58;
	Sat, 10 Jan 2015 22:13:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALkWK0=jEh06hZSmHim54BaP_KiC8hg-455STQphu17PSoQTqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262274>

Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
> > -our $default_ref_id  = $ENV{GIT_SVN_ID} || 'git-svn';
> > +our $default_ref_id  = defined $ENV{GIT_SVN_ID} ? $ENV{GIT_SVN_ID} : 'git-svn';
> 
> This is probably not a functional change; please look at the second hunk.

It is functional, maybe someone will use GIT_SVN_ID=0 ?
