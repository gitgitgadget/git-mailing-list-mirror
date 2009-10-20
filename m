From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC PATCH] hooks: add some defaults to support sane
	workflow to pre-commit
Date: Tue, 20 Oct 2009 21:59:22 +0200
Message-ID: <20091020195922.GA1725@book.hvoigt.net>
References: <499EF2B6.7060103@hvoigt.net> <7v4opv4vjh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:59:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Kri-0006nu-LC
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 21:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbZJTT7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 15:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbZJTT7U
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 15:59:20 -0400
Received: from darksea.de ([83.133.111.250]:35541 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751364AbZJTT7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 15:59:20 -0400
Received: (qmail 19544 invoked from network); 20 Oct 2009 21:59:22 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 20 Oct 2009 21:59:22 +0200
Content-Disposition: inline
In-Reply-To: <7v4opv4vjh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130832>

On Mon, Oct 19, 2009 at 01:50:26AM -0700, Junio C Hamano wrote:
> Heiko Voigt <git-list@hvoigt.net> writes:
> 
> > It sometimes happens that you move to a new machine and forget to setup your
> > name and email address. To find this out after 10 commits can be quite
> > frustrating.
> 
> Doesn't env_hint[] kick in in fmt_ident() in such a case, though?

It is not want you usually want. You get <username>@<hostname> as the
committer but if you are working on a workstation this is seldomly your
email address. At least in my experience.

I would like this as a safeguard that you have done some basic setup
before you create any commits.

cheers Heiko
