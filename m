From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] git-svn - bidirection operations between svn and git
Date: Thu, 16 Feb 2006 00:01:36 -0800
Message-ID: <7v4q2zg2an.fsf@assigned-by-dhcp.cox.net>
References: <20060216073826.GA12055@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Aneesh Kumar <aneesh.kumar@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:01:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9e5A-00063B-9t
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 09:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWBPIBj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 03:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWBPIBj
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 03:01:39 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53434 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932512AbWBPIBi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 03:01:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216075910.QLDO17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Feb 2006 02:59:10 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060216073826.GA12055@hand.yhbt.net> (Eric Wong's message of
	"Wed, 15 Feb 2006 23:38:26 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16280>

Eric Wong <normalperson@yhbt.net> writes:

> @ Junio: Is there room for this in the git distribution alongside
> git-svnimport?

Surely.  Things that superficially do similar things are not
necessarily mutually exclusive, if that is what you are worried
about.  There is not much incumbent advantage for tools that
support a narrowly defined specific task (e.g. interfacing with
foreign SCM X) on the periphery, while I would perhaps feel more
hesitant to support 47 different variants of git-commit ;-).

Especially, from your description (I haven't looked at the
code), its point is to give a better support for an alternative
workflow from svnimport supports.

I was privately advised (by somebody I respect and trust) that I
should not be too hesitant to expand the scope of the project.
Also there are some interesting developments such as Martin's
git-backed fake CVS server and Aneesh's gitview that I have been
interested in, among other things.

Even having some experimental tools that are only starting to do
useful things might be useful, if we had it in the git.git
repository.  For one thing, it would give more exposure to them
and help improve things.

How about first adding a contrib/ directory and see how it goes?
