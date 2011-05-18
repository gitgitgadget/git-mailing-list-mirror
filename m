From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: New flag to add a file in empty
	directories
Date: Wed, 18 May 2011 13:01:39 -0700
Message-ID: <20110518200139.GB10697@dcvr.yhbt.net>
References: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu> <4DD373CD.6010607@alum.mit.edu> <20110518083314.GA22204@dcvr.yhbt.net> <BANLkTimGrkL2KjGC652tr3=Y0h02C_fzaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Ray Chen <rchen@cs.umd.edu>
X-From: git-owner@vger.kernel.org Wed May 18 22:01:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMmwD-0007EL-Od
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 22:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab1ERUBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 16:01:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52871 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575Ab1ERUBk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 16:01:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75E01F404;
	Wed, 18 May 2011 20:01:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <BANLkTimGrkL2KjGC652tr3=Y0h02C_fzaQ@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173900>

Ray Chen <rchen@cs.umd.edu> wrote:
> On Wed, May 18, 2011 at 4:33 AM, Eric Wong <normalperson@yhbt.net> wr=
ote:
> >
> >> 4. If it is a goal to support long-term tracking of a Subversion
> >> repository, then it would be good to add a config option to turn o=
n this
> >> feature permanently for a git-svn repository, so that the user doe=
sn't
> >> have to enter the extra options with each command invocation.
> >
> > Command-line options should be automatically converted into config =
file
> > options inside git svn. =C2=A0We should however discourage this fro=
m getting
> > mixed...
> >
> I'm not sure what you mean by this.  Do you mean that options
> shouldn't be settable both on the command line and the config file?  =
I
> think this situation already exists with the --no-metadata option.

git-svn automatically understands configuration options based on the
command-line options (see sub read_get_config).

--=20
Eric Wong
