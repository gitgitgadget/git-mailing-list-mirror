From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 03:08:28 -0700 (PDT)
Message-ID: <m38w9jjqqd.fsf@localhost.localdomain>
References: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	<41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
	<4BA61CF9.7040104@gmail.com>
	<41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
	<7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
	<41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
	<7vhbo8syyf.fsf@alter.siamese.dyndns.org>
	<41f08ee11003220031p6fda651eycff2641df10864da@mail.gmail.com>
	<7v7hp4n6qn.fsf@alter.siamese.dyndns.org>
	<20100322081003.GA26535@progeny.tock>
	<41f08ee11003222301y569a5972q3c67d10c77abe27a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 11:09:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu12O-000069-4u
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 11:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab0CWKIe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 06:08:34 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42802 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358Ab0CWKId convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 06:08:33 -0400
Received: by fxm5 with SMTP id 5so2640971fxm.29
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 03:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=ssoiGG1YfFpLNUfvdtTbteJuWSP8elyZe8TrJn1VmoE=;
        b=B2nE9MINbdICjXBXwRfMhrWunyLPI7fOu8ZUUX2msGj8vicHcZIq2TMEJyVKN8sa+I
         dHzeVQ/ZcORpcpbKLPEy+StoDnWiNyygw2lKdMVpd/TIZs/yPoX7+BYvZPQpR0IVZCis
         SInOhCFtSFxl2Jrt+Q5HTFHWlGU25UKQnjycM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=mvJhKuzEqxPqFfGNMs/kglxeyGQhlJVagzX2B/Bpb7IsGhgaRynys0s9Zx4LBaPlcj
         RY91WYCK2omlIoBZs3PdIpi+azjM33D8oxsI6AmL3eyhweXw6hv69qNMcSUu00wpGgqf
         TRMrVJIYWSuws9RTT5UAqtkLmZmzqpAkiRlpk=
Received: by 10.204.146.148 with SMTP id h20mr3255589bkv.185.1269338910742;
        Tue, 23 Mar 2010 03:08:30 -0700 (PDT)
Received: from localhost.localdomain (absh220.neoplus.adsl.tpnet.pl [83.8.127.220])
        by mx.google.com with ESMTPS id s17sm24673191bkd.16.2010.03.23.03.08.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 03:08:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2NA7tCF022765;
	Tue, 23 Mar 2010 11:08:00 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2NA7dei022761;
	Tue, 23 Mar 2010 11:07:39 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <41f08ee11003222301y569a5972q3c67d10c77abe27a@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143002>

Bo Yang <struggleyb.nku@gmail.com> writes:
> Jonathan Nieder <jrnieder@gmail.com> writes:

> > Hmm, I can imagine some (mutually inconsistent) heuristics:
> >
> > =A0- Suppose in the blamed commit a single isolated line changed. =A0=
Then
> > =A0 it is clear where to look next.
> >
> > =A0- If the mystery code is at the beginning of the file (resp.
> > =A0 beginning of a diff -C0 hunk), maybe it was based on the line a=
t the
> > =A0 same position within the previous commit.
> >
> > =A0- Take the line with the lowest Levenshtein distance from the my=
stery
> > =A0 code.
> >
> > =A0- Expect certain common patterns of change: substituted words,
> > =A0 whitespace changes, added arguments for a function, things like=
 that.
> >
> > That said, I still don=C2=92t have a clear picture of a basic strat=
egy.
>=20
> I can't understand fully about your above strategy. I think we can
> category the code change into two cases:
>
> 1. The diff looks like this:
>=20
> @@ -1008,29 +1000,29 @@ int cmd_format_patch(int argc, const char
> **argv, const char *prefix)
>                 add_signoff =3D xmemdupz(committer, endpos - committe=
r + 1);
>         }
>=20
> -       for (i =3D 0; i < extra_hdr_nr; i++) {
> -               strbuf_addstr(&buf, extra_hdr[i]);
> +       for (i =3D 0; i < extra_hdr.nr; i++) {
> +               strbuf_addstr(&buf, extra_hdr.items[i].string);
>                 strbuf_addch(&buf, '\n');
>         }

Errr... how the first line in preimage differs from first line in
postimage?  The look as if they are the same:

  -       for (i =3D 0; i < extra_hdr_nr; i++) {
  +       for (i =3D 0; i < extra_hdr.nr; i++) {

>=20
> i.e. there is both deletion and addition in a change. And this means =
we
> modify some lines of the code. So, what we do will be tracing the two
> 'minus' lines and then find another diff. Start trace from that diff
> recursively.
>
> Yes, the new added code may also be moved or copied from other place.
> But, I think here, we should focus on the lines before this changeset=
=2E

The problem is when you are asking about tracking a subset of lines
that appear in postimage of a patch.  For example if we ask for
history of

                  strbuf_addstr(&buf, extra_hdr.items[i].string);

line, should we track history of

          for (i =3D 0; i < extra_hdr.nr; i++) {

line which appears in relevant diff chunk?  If not, how we should
detect which line in preimage (if any) corresponds to given line in
postimage?

> 2. The diff looks like:
>=20
> @@ -879,9 +885,12 @@ int cmd_grep(int argc, const char **argv, const
> char *prefix)
>         opt.regflags =3D REG_NEWLINE;
>         opt.max_depth =3D -1;
>=20
> +       strcpy(opt.color_context, "");
>         strcpy(opt.color_filename, "");
> +       strcpy(opt.color_function, "");
>         strcpy(opt.color_lineno, "");
>         strcpy(opt.color_match, GIT_COLOR_BOLD_RED);
>=20
> This means, the code here is added from scratch. Here, I think we hav=
e
> three options.
> 1. Find if the new code is moved here from other place.
> 2. Find if the new code is copied from other place.
> 3. We find the end of the history, so stop here.
>=20
> The problems remain how do we find the copied/moved code. The new
> added code may be copied/moved from multiple place with little
> changes.

I guess that you could take a look at how git-blame does handle
this... but I think you would get something like generalization of
ordinary patch, where preimage of chunk can come from different place
/ different file.


P.S. I like it that you provide real-life examples.  They really help
     with understanding what are you talking about.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
