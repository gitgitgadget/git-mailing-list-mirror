From: Thomas Harning <harningt@gmail.com>
Subject: Re: [RFC] Idea for Git Bugtracking Tool
Date: Mon, 10 Mar 2008 23:29:17 -0400
Message-ID: <20080310232917.7c71ccbe@shiva>
References: <20080306142246.5d9460b7@gmail.com>
	<vpqskz3pqdo.fsf@bauges.imag.fr>
	<m3zltaf7vs.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Pierre Habouzit <madcoder@debian.org>, <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 04:32:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYvEB-0004Mb-BT
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 04:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbYCKDb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 23:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753948AbYCKDb4
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 23:31:56 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:34185 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbYCKDbz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 23:31:55 -0400
Received: by py-out-1112.google.com with SMTP id u52so3264956pyb.10
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 20:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=gCgVuKIvgI7xmO/X3Ly9elB6iBUSKBIQH7T6zLcfhAU=;
        b=pOxB3t0YkBk62RCjcoKJDbI7tThsJYwEyacRmxiibVJFAT101s2Eeeck13mdWXesR5gA+o3ba0QexgYY+ss2bbDF7vTxBoVWMOXRXwg7fd5RYDPEuyA20PODO5p9fkNhO6LS8b68Lgaab8VW0mFhE6DAiFt9NBlPAVkgkCf/n54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=nxfkCHsv4/fcstL4L/NQ0pY+IrpAK3p1HbTxUVCz/+As5XOiGe+l+mKblp307wUDADCZFFz4BlbCojGZNZ6/kJCjRxybu1J3GKELHKTpzNHY5gGuS/0ZSglsK+Vxoi8pCo6MZ1q+TTYqGhAaeUQVKx274rzWxJ2+FE/gaHsKymM=
Received: by 10.35.28.12 with SMTP id f12mr9060187pyj.9.1205206310377;
        Mon, 10 Mar 2008 20:31:50 -0700 (PDT)
Received: from shiva ( [69.245.236.18])
        by mx.google.com with ESMTPS id i6sm893709wxd.21.2008.03.10.20.31.49
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Mar 2008 20:31:49 -0700 (PDT)
In-Reply-To: <m3zltaf7vs.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.12.5; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76792>

On Fri, 07 Mar 2008 15:10:18 -0800 (PST)
Jakub Narebski <jnareb@gmail.com> wrote:

>  * Bugs Everywhere (http://bugseverywhere.org), written in Python,
>    developed in Bazaar, has Git backend support. Formerly written by
>    Panoramic Feedback (note that there is stale version of this tool),
>    picked up by one of developers
This doesn't appear to let you mark bugs as existing at previous points
in history... which partly removes the usefulness of branch tracking....

Grit has the same problems it seems... (at least at the state it was
the last time I saw it).. besides the problem of being gone.
>  * DisTract (http://www.distract.wellquite.org), written in Haskell,
>    uses Monotone as backend. Has good reviews on blogs, e.g. by
>    Masukomi.
Monotone+Haskell+Local Firefox...  doesn't look like this will go far
in the real world where people w/o the entire actual would like to post
bugs...
> 
>  * DITrack (http://www.ditrack.org), written in Python, currently
>    uses Subversion as backend, has plans to be backend-agnostic.
>    Inspired by Subissue.
Doesn't seem to be able to deal w/ branches particularly... looks more
like a way to work as an offline-capable bug tracking system...

I've posted up a wiki @ http://www.eharning.us/wiki/stick/ for a
working concept for how a branch-tracking w/ possibility for
distribution...  Feel free to comment on the page or (preferable) use
the Discussion page...
