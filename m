From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Mon, 10 Dec 2007 17:28:19 +0100
Message-ID: <87r6huldjw.fsf@mid.deneb.enyo.de>
References: <200712101357.49325.jnareb@gmail.com>
	<87ve76mwos.fsf@mid.deneb.enyo.de> <m34peqtuuj.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Shlomi Fish <shlomif@iglu.org.il>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 17:28:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1lUv-00025x-CO
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 17:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbXLJQ21 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Dec 2007 11:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbXLJQ21
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 11:28:27 -0500
Received: from mail.enyo.de ([212.9.189.167]:1949 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbXLJQ20 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2007 11:28:26 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1J1lUU-0007v1-Ha; Mon, 10 Dec 2007 17:28:22 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.68)
	(envelope-from <fw@deneb.enyo.de>)
	id 1J1lUR-0004Rj-Vz; Mon, 10 Dec 2007 17:28:19 +0100
In-Reply-To: <m34peqtuuj.fsf@roke.D-201> (Jakub Narebski's message of "Mon, 10
	Dec 2007 07:47:49 -0800 (PST)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67730>

* Jakub Narebski:

> Florian Weimer <fw@deneb.enyo.de> writes:
>
>> * Jakub Narebski:
>> > @@ -214,6 +225,13 @@ <title>File and Directories Copies</title>
> [...]
>> > +                <s id=3D"git">
>> > +                    Yes (or no depending on interpretation). Git
>>=20
>> This should be "No." (same for copies below).
>
> I would agree to "N/A" or "Partial", but with 'git log --follow'
> implemented at least for single file I wouldn't say that that git
> doesn't support file and directories renames (copies).  It does, in
> it's own fashion, using rename (copy) detection instead of rename
> (copy) tracking.

It's undoubtly a difficult question.  In my experience, developers tend
to not mark renames properly, so rename detection in log/diff/annotate
is still helpful even if renames are encoded explicitly.  But this was =
a
learning process; I used to think that explicit rename support was
essential.

>> > +                <s id=3D"git">
>> > +                    Partial (?). It is possible to lock down repo=
sitory
>> > +                    (access to branches and tags) using hooks.
>> > +                </s>
>>=20
>> I doubt this works reliably.  You still can access data once you've =
got
>> its SHA1 hash, for instance.
>
> So what? The data is not visible, so it is as if it didn't
> exist.

Uhm, I'd commit something that references some SHA-1, and voil=E0, I ca=
n
read the object with that SHA-1.

>> > +                <s id=3D"git">
>> > +                    Yes. Changesets are supported.<br />
>> > +                    Actually Git is snapshot based which means Gi=
t records
>> > +                    the full state in every commit.  This means t=
hat any two
>> > +                    commits can be compared directly very quickly=
, although the
>> > +                    repository is typically browsed as a series o=
f changesets.
>> > +                </s>
>>=20
>> I don't think this explanation is necessary.  What does Subversion s=
ay?
>
> Subversion has the following currently:
>
>   Partial support. There are implicit changeset that are generated on
>   each commit.

Hmm.

> Well, we could follow Mercurial, Monotone and Darcs and simply write
>
> +                <s id=3D"git">
> +                    Yes. Changesets are supported.
> +                </s>

Makes sense, especially since there's "git bundle" nowadays.

>> I don't think this is true.  Is there any command that closely match=
es
>> what CVS does?
>
> Yes: init, add, annotate (alias to blame), checkout, commit, diff,
> status, log, version. At least in principle, if not in output format.

I think we disagree on the meaning of "close" here. 8-/

In my experience, it's hard to see the parallels between GIT and CVS
because the semantics are so different.  This is, to some extent,
unavoidable.  But I'm not sure if knowing your way around CVS actually
helps learning GIT (the old sayings about BASIC come to my mind).
