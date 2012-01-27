From: Mike Hommey <mh@glandium.org>
Subject: Re: commit/from command in git-fast-import
Date: Fri, 27 Jan 2012 15:08:08 +0100
Message-ID: <20120127140808.GA31535@glandium.org>
References: <20120127124837.GA24084@glandium.org>
 <CAFfmPPPYc=9BdwuE+ANiHKrFk+_7aXDgnMv3fHxVmF0ttZu8bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 15:08:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqmTQ-000182-LL
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 15:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab2A0OIK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 09:08:10 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19]:43534
	"EHLO jigen.glandium.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755116Ab2A0OIK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 09:08:10 -0500
Received: from mh by jigen.glandium.org with local (Exim 4.77)
	(envelope-from <mh@glandium.org>)
	id 1RqmTI-0008Dl-6Z; Fri, 27 Jan 2012 15:08:08 +0100
Content-Disposition: inline
In-Reply-To: <CAFfmPPPYc=9BdwuE+ANiHKrFk+_7aXDgnMv3fHxVmF0ttZu8bA@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189222>

On Sat, Jan 28, 2012 at 01:00:17AM +1100, David Barr wrote:
> On Fri, Jan 27, 2012 at 11:48 PM, Mike Hommey <mh@glandium.org> wrote=
:
> > When I do create a commit on a given branch with a stream like:
> > =A0commit refs/heads/branch
> > =A0author ...
> > =A0committer ...
> > =A0data <<EOF
> > =A0Commit message
> > =A0EOF
> > =A0deleteall
> >
> > All I get is this warning:
> > =A0warning: Not updating refs/heads/branch (new tip new_sha1
> > does not contain old_sha1)
> >
> > And the branch only has one commit, which is the one I just created=
=2E
> > On the other hand, if I add a "from" instruction in the above strea=
m,
> > I have the expected branch history.
>=20
> This is precisely the expected behavior.
> If 'from' is omitted, the resulting commit has no preceding history.
> On the other hand, what you want is to specify the parent so that
> there is a continuation of history.

This is however not what the manpage suggests in what I quoted in my
message:
  Omitting the from command on existing branches is usually desired, as
  the current commit on that branch is automatically assumed to be the
  first ancestor of the new commit.

Mike
