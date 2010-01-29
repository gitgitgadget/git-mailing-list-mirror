From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 13:40:46 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-4A6B93.13404629012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <hjvgs1$rep$1@ger.gmane.org> <ron1-953427.13240429012010@news.gmane.org> <fabb9a1e1001291328s1df443d6jdf0501cda17072de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 22:41:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nayaa-0005pO-6z
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967Ab0A2VlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 16:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738Ab0A2VlJ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:41:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:58529 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601Ab0A2VlI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:41:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NayaQ-0005kI-JV
	for git@vger.kernel.org; Fri, 29 Jan 2010 22:41:06 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 22:41:06 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 22:41:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138370>

In article=20
<fabb9a1e1001291328s1df443d6jdf0501cda17072de@mail.gmail.com>,
 Sverre Rabbelier <srabbelier@gmail.com> wrote:

> Heya,
>=20
> On Fri, Jan 29, 2010 at 22:24, Ron Garret <ron1@flownet.com> wrote:
> > Yes, I read that. =C2=A0But what I'm trying to do is not just *look=
* at the
> > history, I want to restore my working tree to a previous version. =C2=
=A0The
> > "Exploring History" section of the docs doesn't say how to do that.
>=20
> Do you want to restore your working tree only,

Yes.

> or also throw away the history?

No.

> If the former, you could look at 'git revert'

If that's the right answer then the docs needs serious revision.  The=20
docs for "git revert" say that what it does is:

"Given one existing commit, revert the change the patch introduces, and=
=20
record a new commit that records it."

which does not sound at all like what I'm trying to do.

All I want to do is copy an old commit to my working tree, nothing else=
=2E =20
I don't want to move my head pointer.  I don't want to muck with my=20
index.  I don't want to commit any changes or undo any history.  It's a=
=20
very simple thing.  It ought to be simple to do, but it doesn't seem to=
=20
be.

rg
