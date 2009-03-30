From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv2 3/4] Documentation: branch.*.merge can also afect 
	'git-push'
Date: Tue, 31 Mar 2009 00:06:30 +0200
Message-ID: <adf1fd3d0903301506r65bd9b9bv6bf76c652a051400@mail.gmail.com>
References: <1238407903-28020-1-git-send-email-santi@agolina.net>
	 <1238407903-28020-4-git-send-email-santi@agolina.net>
	 <7vd4bzdkkq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 00:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoPeL-0002hx-A6
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 00:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbZC3WGh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 18:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbZC3WGg
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 18:06:36 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:62693 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbZC3WGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 18:06:35 -0400
Received: by fxm2 with SMTP id 2so2166440fxm.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 15:06:30 -0700 (PDT)
Received: by 10.103.173.5 with SMTP id a5mr1924521mup.57.1238450790605; Mon, 
	30 Mar 2009 15:06:30 -0700 (PDT)
In-Reply-To: <7vd4bzdkkq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115193>

2009/3/30 Junio C Hamano <gitster@pobox.com>:
> I'll take [1/4] and [2/4] with minor rewording, and I think [4/4] is =
not
> necessary (push.default is clear enough---and defaultMode won't make =
it
> any clearer to the first time readers anyway as it is unspecified wha=
t
> kind of "mode" it is talking about).

At least to me, mode in the context of 'push' suggest behavior. But
maybe only for second time readers...

>
> I do not understand this [3/4]. =A0I did look at push.default but it =
is
> unclear how this variable is involved.
>
> Perhaps it is because the word "tracking" in the description "push th=
e
> current branch to the branch it is tracking" is used without explaina=
tion.

Maybe the push.default description needs some enhancements, but this
[3/4] is true.

> I think the author meant to say if your local branch frotz by default
> merges changes made to the branch nitfol of the remote repository, "f=
rotz
> tracks nitfol", but the use of the word "track" for that meaning appe=
ars
> nowhere in Documentation/glossary-content.txt

So we can define:

push.default =3D "tracking" =3D "push the current branch to its upstrea=
m branch"

The "upstream branch" is defined in branch.name.merge and could also
be added to glossary-content.

Santi
