From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [feature request] gitweb: tags in history
Date: Sat, 21 Aug 2010 20:07:07 +0200
Message-ID: <20100821200707.6cca565e@hyperion.delvare>
References: <20100821092616.5e57135b@hyperion.delvare>
	<20100821111555.11879d02@hyperion.delvare>
	<AANLkTi=JHzQm4hm-nuTyZq2CL_2z785KtMvVcmaqtgyF@mail.gmail.com>
	<201008211921.22495.jnareb@gmail.com>
	<AANLkTik+NBvdVkN-TvC_F5MWGZrtgEZMPOXr=Tsr1eA_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 20:07:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmsTc-000291-2P
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 20:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955Ab0HUSHT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Aug 2010 14:07:19 -0400
Received: from zone0.gcu-squad.org ([212.85.147.21]:1098 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab0HUSHS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Aug 2010 14:07:18 -0400
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1OmsSK-0004RN-4s
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Sat, 21 Aug 2010 20:06:12 +0200
In-Reply-To: <AANLkTik+NBvdVkN-TvC_F5MWGZrtgEZMPOXr=Tsr1eA_@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154148>

On Sat, 21 Aug 2010 19:47:12 +0200, Lars Hjemli wrote:
> On Sat, Aug 21, 2010 at 19:21, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> > Lars Hjemli wrote:
> >> <shameless plug>
> >> With cgit, you can answer such questions by combining path limitin=
g
> >> and range queries, e.g.
> >> http://hjemli.net/git/cgit/log/scan-tree.c?qt=3Drange&q=3Dv0.8.2..=
v0.8.3
> >> shows all commits affecting scan-tree.c between v0.8.2 and v0.8.3.
> >> Maybe gitweb could implement something similar?
> >> </shameless plug>
> >
> > Gitweb also supports range limiting in log-like views from some tim=
e,
> > but currently there is no UI for that, and you have to handcraft th=
e URL,
> > e.g.:
> >
> > =C2=A0http://gitweb.example.com/repo.git?a=3Dhistory;f=3Dfoo.c;hpb=3D=
v0.8.2;hb=3Dv0.8.3
> >
> > or (in the path_info form)
> >
> > =C2=A0 =C2=A0http://gitweb.example.com/repo.git/history/v0.8.2..v0.=
8.3:/foo.c
>=20
> Nice, I didn't know gitweb supported this - maybe it's all Jean needs=
?

Well, as long as there is no UI for it, it's not too useful: I'm can
run git on the command line for the same result (with git log.)

Also, it doesn't exactly suits my needs. I don't necessarily know in
advance the range in which the change happened. Quite often, the
question I have to answer is the other way around, that is: when did a
given change happen? Sometimes I know the commit ID and I can just call
"git name-rev" (although it's somewhat slow and the output isn't
friendly), but sometimes I don't know even that, and this is when I'd
like to be able to just browse the history for a given file with
all relevant tags printed. This also gives a more general picture
of what happened to the file over time immediately, which is sometimes
useful.

Thanks,
--=20
Jean Delvare
