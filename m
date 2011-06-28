From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [GSoC 11 submodule] Status update
Date: Tue, 28 Jun 2011 20:43:58 +0200
Message-ID: <20110628184358.GA3700@book.hvoigt.net>
References: <20110627193444.GA26778@paksenarrion.iveqy.com> <4E09205E.2080904@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 20:48:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbdKb-00053Q-2S
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 20:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760423Ab1F1Soz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 14:44:55 -0400
Received: from darksea.de ([83.133.111.250]:54835 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760638Ab1F1SoB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 14:44:01 -0400
Received: (qmail 10384 invoked from network); 28 Jun 2011 20:43:58 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 28 Jun 2011 20:43:58 +0200
Content-Disposition: inline
In-Reply-To: <4E09205E.2080904@cisco.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176414>

Hi,

On Mon, Jun 27, 2011 at 08:29:18PM -0400, Phil Hord wrote:
> On 06/27/2011 03:34 PM, Fredrik Gustafsson wrote:
> > My fourth task (and the main task of this summer) will start on June 27 and
> > will be to move a submodules .git-dir into the super-projects .git-dir.
> > Design of this is already done and approved by my mentors.
> 
> This frightens me a bit, so I read the wiki link about it.  Thanks for
> explaining where I can find this information.

I do not know what part of this change frightens you?

> But I'm still confused.
> 
> If I understand right, the submodule/.git dirs will be moved into the
> top-level at .git/submodule/.git.  The benefit is supposed to be that
> this will free up contention on the non-empty submodule directory when
> the super-project switches branches.
> 
> In the simple case, git warns "unable to rmdir sub: Directory not
> empty".  But I can think of other conflicts as well.
> 
> My question is, how does this proposed change help the situation?

The proposed change allows us to implement that a submodules directory
can be completely removed if it was deleted or moved. If we would do
that currently you would loose all local history of the submodule. I do
not know what you mean with "conflicts" but this change will help
submodule towards behaving like they were ordinary directories in git.

Cheers Heiko
