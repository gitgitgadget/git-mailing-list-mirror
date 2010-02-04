From: Ron Garret <ron1@flownet.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 03 Feb 2010 16:10:38 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-1F86D7.16103803022010@news.gmane.org>
References: <ron1-32BD5F.10255403022010@news.gmane.org> <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com> <ron1-5F71CB.11234903022010@news.gmane.org> <alpine.LFD.2.00.1002031436490.1681@xanadu.home> <ron1-34F9C6.12273203022010@news.gmane.org> <32541b131002031240p6b67536ame6b69c6d662a7968@mail.gmail.com> <ron1-9FA846.14332803022010@news.gmane.org> <32541b131002031518t1017d351xcf9071f0a937474e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 01:15:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcpNK-0006N7-PA
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 01:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985Ab0BDAPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 19:15:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:57531 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757974Ab0BDAPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 19:15:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NcpNB-0006Hy-Fw
	for git@vger.kernel.org; Thu, 04 Feb 2010 01:15:05 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 01:15:05 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 01:15:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138919>

In article=20
<32541b131002031518t1017d351xcf9071f0a937474e@mail.gmail.com>,
 Avery Pennarun <apenwarr@gmail.com> wrote:

> On Wed, Feb 3, 2010 at 5:33 PM, Ron Garret <ron1@flownet.com> wrote:
> > Here's a realistic case where keeping explicit track of renames cou=
ld be
> > useful.
> >
> > A and B start with a file named config. =C2=A0A and B both make edi=
ts. =C2=A0In
> > addition, B renames config to be config1 and creates a new, very si=
milar
> > file called config2. =C2=A0B then merges from A with the expectatio=
n that B's
> > edits to config would end up in config1 and not config2. =C2=A0It s=
eems to me
> > that without tracking renames, it would be luck of the draw which f=
ile
> > the patch got applied to.
>=20
> The problem is that this single "realistic case" is not actually very
> common, and it's dwarfed by the other realistic cases: developer
> forgets to use 'git mv' to rename the file; developer accidentally
> deletes a file, commits, and then readds it later; etc.

Makes sense.

> Have I been bitten by exactly your example?  Yup.  But I've been
> bitten by lots of other related things too, and explicit rename
> tracking (at least in svn) has quite frequently made the problems
> *worse*.  In my personal experience, git screws up less often.  The
> fact that it's also elegant is a nice bonus too :)
>=20
> More about this: http://marc.info/?l=3Dgit&m=3D114123702826251

Thanks, that's a great read!

rg
