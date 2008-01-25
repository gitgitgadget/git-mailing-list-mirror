From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: per branch cover letters
Date: Fri, 25 Jan 2008 17:46:33 +0100
Message-ID: <20080125164633.GA12321@diana.vm.bytemark.co.uk>
References: <9e4733910801250657p2d7fdc66o8a631d7587125949@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 17:47:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIRhu-00069L-ER
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 17:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbYAYQqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 11:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbYAYQqj
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 11:46:39 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3958 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbYAYQqj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 11:46:39 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JIRhJ-0003Hs-00; Fri, 25 Jan 2008 16:46:33 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910801250657p2d7fdc66o8a631d7587125949@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71718>

On 2008-01-25 09:57:50 -0500, Jon Smirl wrote:

> It would be convenient to have per branch cover letters that are
> stored by stg and get automatically applied when a patch set is
> mailed. Use 'stg edit' to alter them. The first time you email a
> series you would get an editor to write the cover letter if you
> hadn't already done it. You could track the "to=3D" this way also.

I don't think we need to get quite that fancy. Wouldn't it suffice to
have a --cover-file=3D<filename> option to stg mail, and if both
--cover-file and --edit-cover were given, update that file with new
diffstat etc?

And per-branch config options if you want to set these permanently, of
course.

> Another useful feature would be a config option that says something
> like "prompt for new version" when mailed. Now each time you mail
> the series it throws you into the cover page editor with an
> incremented patch version. You can just quit out of the editor if
> you don't want to increment the version.

Patches without cover letters can also have versions, so I don't think
associating versions with cover letters is a splendid idea, but I get
your point.

I guess a solution much like the one for cover letters would work
here. A separate file, and command-line and config options to point to
it.

> I didn't know I wanted features like this until I made a patch that
> has gone through 25 versions.

Your feedback is much appreciated. Keep at it!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
