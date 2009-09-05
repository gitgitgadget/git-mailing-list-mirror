From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [git-svn] always prompted for passphrase with subversion 1.6
Date: Fri, 4 Sep 2009 23:46:50 -0700
Message-ID: <20090905064649.GD22272@dcvr.yhbt.net>
References: <4A95D58C.1070409@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Potter <tpot@hp.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 08:47:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjp37-000464-Rn
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 08:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbZIEGqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 02:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbZIEGqs
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 02:46:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34035 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbZIEGqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 02:46:48 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 29B681F602;
	Sat,  5 Sep 2009 06:46:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A95D58C.1070409@hp.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127784>

Tim Potter <tpot@hp.com> wrote:
> Hi everyone.  I am using git-svn with the Subversion 1.6 client compiled
> with GNOME Keyring support.  This neat features allows a SSL client
> certificate password to be cached inside GNOME Keyring instead of being
> prompted to enter it every time.  However the git-svn script doesn't
> appear to know about this and always prompts for a password.
> 
> Obviously there's some tweak required in the _auth_providers()
> subroutine but I don't know enough about the Subversion Perl client to
> figure out a fix.
> 
> Has anyone else run in to this problem?  I did a quick search on the
> list but didn't find anything relevant.

Hi Tim,

I think one user wanted to get SSL certificate authentication going but
my SSL knowledge was too weak at the time[1] and I think we both forgot
about it or lost interest.

[1] and probably still so, though I have recently managed to set
    *something* up with SSL client certs and maybe it's done
    right.  SSL is just one of those things that never really
    "clicked" for me (ssh on the other hand...)

-- 
Eric Wong
