X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Patch to tutorial.txt
Date: Mon, 20 Nov 2006 10:10:36 +0100
Message-ID: <4d8e3fd30611200110y224b5b8dpf974d30d738455c9@mail.gmail.com>
References: <4d8e3fd30611191444r710f23e5uc488d35aa4abaf06@mail.gmail.com>
	 <ejqnh8$peb$1@sea.gmane.org>
	 <4d8e3fd30611200030p1d117445qd3f7d619c18a0633@mail.gmail.com>
	 <200611200949.32722.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 20 Nov 2006 09:10:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kDGYFgZ0xaERGbWPcuQFLIka0WBCxb2REW8T1HXpev8vMlO99u9izuPYq6ZQdc5Q0s5OBRjYcOdUmITsta07f35itiMoW/DA/BhLPQG1nk58BSFOneEskwnP+TF0FXTFcXQU1HJfgAC4ieacEGHdqHF4l+7keSzZlYgSu33/R3c=
In-Reply-To: <200611200949.32722.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31887>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm5Ao-0003Fu-Fc for gcvg-git@gmane.org; Mon, 20 Nov
 2006 10:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934015AbWKTJKj convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006 04:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934025AbWKTJKj
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 04:10:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:53491 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S934015AbWKTJKi
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006
 04:10:38 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1122038ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 01:10:37 -0800 (PST)
Received: by 10.78.58.11 with SMTP id g11mr4942125hua.1164013836633; Mon, 20
 Nov 2006 01:10:36 -0800 (PST)
Received: by 10.78.165.3 with HTTP; Mon, 20 Nov 2006 01:10:36 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/20/06, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 20 Nov 2006, Paolo Ciarrocchi wrote:
> > On 11/19/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >> Paolo Ciarrocchi wrote:
>
> >>> From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
> >>> Date: Sun, 19 Nov 2006 23:41:31 +0100
> >>> Subject: [PATCH] One of the comment was not really clear, rephras=
ed to
> >>> make it easier to be understood by the reader
> >>
> >> Wordwrap. Perhaps it would be better to split description into sho=
rt line,
> >> and two-line description.
>
> See http://git.or.cz/gitwiki/CommitMessageConventions

Thanks! I was not aware of that.

> In short, it is better to split description into short one-line
> description, for example
>   "Documentation: Make comment about merging in tutorial.txt more cle=
ar"
> followed by empty line, then longer description of changes (if any), =
for
> example
>
>   One of the comment was not really clear, rephrased to make it easie=
r
>   to be understood by the reader
>
> followed by empty line, then signoff line, for example
>
>   Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

Ok, but the Signed/off-by part should handled  by the -s option in
git-format-patch.

> > This is not clear to me, when I do a "git commit -a" I can add a te=
xt using vi,
> > should I manually split the text in multiple lines?
> > Only the first line will be part of the Subject?
>
> Yes. The rest will be in the email body.
>
> >> [...]
> >>>  ------------------------------------------------
> >>>
> >>>  at this point the two branches have diverged, with different cha=
nges
> >>> -made in each.  To merge the changes made in the two branches, ru=
n
> >>> +made in each.  To merge the changes made in experimental into ma=
ster run
> >>
> >> I would rather say:
> >>   To merge the changes made in the two branches into master, run
> >
> > Why Jakub? There are only two branches, master and experimental.
> > While sitting in master and doing git pull . experimental I would
> > expect to merge I did in experimental into master. Changes did in
> > master are alreay merged in master. Am I wrong?
>
> For me, "merge" in "to merge the changes" phrase is merge in common-s=
ense
> meaning of the world, not the SCM jargon. Merge the changes =3D=3D jo=
in the
> changes, so you have to give both sides, both changes you join.
>
> Merge the changes =3D=3D take changes in branch 'experimental' since =
forking,
> take changes in branch 'master' since forking, join those changes
> together (merge), and put the result of this joining (this merge) int=
o
> branch 'master'.
>
> On the contrary, in "merge branch 'experimenta' into 'master'" phrase
> "merge" is in the SCM meaning of this word.
>
>
> Just my 2 eurocoents of not native English speaker...

I'm not a native English speaker as well, furthemore I'm still not
confident with git so your comments are more then appreciated!

Ciao,
--=20
Paolo
http://docs.google.com/View?docid=3Ddhbdhs7d_4hsxqc8
http://www.linkedin.com/pub/0/132/9a3
Non credo nelle otto del mattino. Per=F2 esistono. Le otto del mattino
sono l'incontrovertibile prova della presenza del male nel mondo.
