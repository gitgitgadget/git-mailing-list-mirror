From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Odd problem in repository
Date: Tue, 24 Apr 2007 13:35:46 -0400
Message-ID: <20070424173546.GG18538@fieldses.org>
References: <462E3D32.60804@gmail.com> <20070424173048.GA5942@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clark Williams <clark.williams@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:35:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgOvg-0004Qv-Pn
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 19:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422813AbXDXRft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 13:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbXDXRft
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 13:35:49 -0400
Received: from mail.fieldses.org ([66.93.2.214]:42889 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422813AbXDXRfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 13:35:48 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HgOva-0001e5-Pp; Tue, 24 Apr 2007 13:35:46 -0400
Content-Disposition: inline
In-Reply-To: <20070424173048.GA5942@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45476>

On Tue, Apr 24, 2007 at 01:30:48PM -0400, Shawn O. Pearce wrote:
> This is a change in Git versions.  Pre Git-1.5.0 we used to put all
> of the branches from the remote system into refs/heads, but now in
> 1.5.0 and later we put them in refs/remotes/origin.
> 
> Nothing screwed up on the central repository, its just the
> new layout.  refs/heads is reserved for *this* local repository,
> while refs/remotes/$name is reserved for the heads of $name remote
> repository.

See also

	http://www.kernel.org/pub/software/scm/git/docs/RelNotes-1.5.0.txt

(grep for "repository layout") for more details on the change.

The new system is surprising if you don't expect it, but it's really
much simpler to work with.

--b.
