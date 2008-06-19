From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: Question: git commit -v uncomment Changes to be commited
Date: Thu, 19 Jun 2008 12:08:14 +0200
Message-ID: <485A300E.2050404@free.fr>
References: <4859CCB5.9070200@asolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "mike.gaffney" <mike.gaffney@asolutions.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 12:09:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9H4h-0005SI-00
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 12:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbYFSKII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 06:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbYFSKIG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 06:08:06 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:53118 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960AbYFSKIF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 06:08:05 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 7AF4112B723;
	Thu, 19 Jun 2008 12:08:03 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 51A8D12B6FD;
	Thu, 19 Jun 2008 12:08:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <4859CCB5.9070200@asolutions.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85467>

mike.gaffney a =E9crit :
> I find myself always uncommenting the "Changes to be commited:" secti=
on
> on a git commit -v. Other than a nifty regex with vi, I'm wondering i=
f
> there is a way to customize the unified diff that is created with com=
mit
> -v. I've looked through the list, but it is one of those things where=
 I
> don't really know how to ask the question (phrase the search). I woul=
d
> be glad of any help that people could give me.

You probably want to edit the hook .git/hooks/prepare-commit-msg in you=
r
repository. Don't forget to enable it with chmod +x.

More information at:
  http://www.kernel.org/pub/software/scm/git/docs/githooks.html

Olivier.
