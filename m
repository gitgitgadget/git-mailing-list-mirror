From: Yann Dirson <ydirson@linagora.com>
Subject: Re: [BUG] Bad msysgit/egit interaction over dotfiles
Date: Tue, 8 Dec 2009 15:37:00 +0100
Message-ID: <20091208143700.GC5425@linagora.com>
References: <20091208132857.GB5425@linagora.com>
 <40aa078e0912080534x32fe9724xcda47ad46dbdb7c0@mail.gmail.com>
 <4B1E57BF.1000500@pelagic.nl>
 <40aa078e0912080623q108b2affk80534ccd5fd7ace3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>,
	GIT ml <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 08 15:37:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI1Bn-0005aM-SU
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656AbZLHOg5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 09:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755475AbZLHOg5
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:36:57 -0500
Received: from [194.206.158.221] ([194.206.158.221]:36184 "EHLO
	cyann.linagora.lan" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755310AbZLHOg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 09:36:56 -0500
Received: from yann by cyann.linagora.lan with local (Exim 4.69)
	(envelope-from <yann@linagora.com>)
	id 1NI1BU-0002DB-A7; Tue, 08 Dec 2009 15:37:00 +0100
Content-Disposition: inline
In-Reply-To: <40aa078e0912080623q108b2affk80534ccd5fd7ace3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134880>

On Tue, Dec 08, 2009 at 03:23:55PM +0100, Erik Faye-Lund wrote:
> On Tue, Dec 8, 2009 at 2:42 PM, Ferry Huberts <ferry.huberts@pelagic.=
nl> wrote:
> > On 12/08/2009 02:34 PM, Erik Faye-Lund wrote:
> >> On Tue, Dec 8, 2009 at 2:28 PM, Yann Dirson <ydirson@linagora.com>=
 wrote:
> >>> I'm not sure who's at fault here - namely, I can't see any valid
> >>> reason for eclipse to refuse such writes, but I am not sure it is=
 a
> >>> good reason for msysgit would set the hidden bit either. =A0In ei=
ther
> >>> case, even if only for the short term, I think msysgit should ens=
ure
> >>> that this bit does not get set (possibly circumventing any magic =
msys
> >>> would do behind its back).
> >>
> >> Setting the config option "core.hidedotfiles" to "false" should
> >> prevent this from happening.

Right, it works much better this way.


> > why isn't this the default?
> >
> > I also experienced this change in behaviour and I thought we would
> > strive to keep the experience the same.
> >
>=20
> You can follow the discussion here:
> http://code.google.com/p/msysgit/issues/detail?id=3D288
>=20
> I believe the reason is something like "because someone suggested it,
> and no one disagreed". Do you have a good argument why it shouldn't b=
e
> the default (other than "it's a change", because changing it back now
> would also be a change)?

Depending on the opinion of the Eclipse guys on this issue about
"writing to hidden files only says 'could not write'", which arguably
could be seen as a bug on their side, we can see changing this
behaviour back to the default on the msysgit side as either a
(possibly temporary) workaround for a known eclipse bug, or as getting
again interoperable with egit.

Note that I did not get time yet to fully investigate the eclipse
status on the issue.

Best regards,
--=20
Yann
