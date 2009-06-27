From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 8/8] gitweb: add avatar in signoff lines
Date: Sat, 27 Jun 2009 12:21:29 +0200
Message-ID: <cb7bb73a0906270321m6154e6a2l240723ffbd7b6e8f@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-8-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-9-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906271126.38757.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 12:23:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKV3w-0005C1-MG
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 12:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbZF0KVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jun 2009 06:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbZF0KVa
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 06:21:30 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:36401 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbZF0KV3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Jun 2009 06:21:29 -0400
Received: by fxm18 with SMTP id 18so134561fxm.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iIs74+jeDq3mhFabmc162uktDnrovls10ojLuGrP6p4=;
        b=U1MdnJDvg1cOt93j7xVqAYgB671mFnru9RhEvlUTPB725C3r3rCD+I+/QXdYbfXupA
         HqaLOKaTLWStCbo5aL03rrrQIlhCkSly5z7JnwB0BLPQwgSHio2AYme9/Tu4gOfd+Xx3
         ct13OR5o8iwwSHGJiP0Tdj7SPq2ZCM/b/Ura0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=euFc9S1s8SHcGgVI9kjlCWuJk+sHOLOdHmx/uYj6rkQbCc9G3lLQ6F2M/ivIi+WCP/
         sCmlMZRcPR94cC6TaZngvDtfP0vUYDd+aTUb6z6PKsvhzRdk7ZeMV2UvWMvdi9vJFHxi
         CZL6aXK2zVjKkJCWRIXVAIqjPop6M5UQatUaE=
Received: by 10.204.70.135 with SMTP id d7mr4670717bkj.87.1246098089511; Sat, 
	27 Jun 2009 03:21:29 -0700 (PDT)
In-Reply-To: <200906271126.38757.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122352>

2009/6/27 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 25 June 2009, Giuseppe Bilotta wrote:
>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>
> BTW. if it is an RFC, it should be marked as RFC in subject
> ("[RFC PATCHv6 8/8] gitweb: add avatar in signoff lines").
>
> And I guess this issue should be left for later.


You're right. My next patchset will not include this part (I'll send
it separately).

>> I can't say I'm really satisfied with the layout given by this patch=
=2E
>> A significant improvement could be obtained by turning the signoff
>> line block into a table with three/four columns (signoff, name,
>> email/avatar).
>
> First, I think adding (gr)avatars to signoff lines might be not worth
> it. =A0Neither GitHub nor Gitorious show gravatars for signoff lines
> (note that they use larger images, and therefore easier to view).

Well, just because the others don't do it, it doesn't mean we
shouldn't either ;-)

But yes, I have to confess I love toying around like this.

> Second, it is not the only possible layout. =A0Let's use one of exist=
ing
> commits (e1d3793) in git repository as example:
>
> =A0completion: add --thread=3Ddeep/shallow to format-patch
>
> =A0[1] Signed-off-by: Stephen Boyd <bebarino@gmail.com> [2] =A0 =A0 =A0=
 =A0 =A0[3] =A0 =A0 =A0 =A0 =A0 =A0[4]|
> =A0[1] Trivially-Acked-By: Shawn O. Pearce <spearce@spearce.org> [2] =
[3] =A0 =A0 =A0 =A0 =A0 =A0[4]|
> =A0[1] Signed-off-by: Junio C Hamano <gitster@pobox.com> [2] =A0 =A0 =
=A0 =A0 [3] =A0 =A0 =A0 =A0 =A0 =A0[4]|
>
> Even without changing layout of signoff lines (so they look exactly
> like they look in git-show or git-log output, modulo highlighting
> and (gr)avatars), there are more possibilities:
>
> =A01. On the left side of signoff lines
> =A02. Current version: on the right side of signoff lines, just after
> =A03. On the right hand side, aligned; would probably need table
> =A04. On the right hand side, flushed (floated) right

I have a table implementation running @ http://git.oblomov.eu/git/commi=
t/e1d3793

> There is also more complicated solution of having (gr)avatars appear
> only on mouseover, either all avatars on hover over signoff block,
> or single (and perhaps larger size) avatar on hover over signoff line=
=2E
> This can be done using pure CSS, without JavaScript[1]
>
> [1] http://meyerweb.com/eric/css/edge/popups/demo2.html

Oh, that'd be an interesting variant. Straightforward to implement in
the table case, too.

> And here is version with (gr)avatar on the left side of signoff lines
> (take a look if it is not better layout):
>
> diff --git c/gitweb/gitweb.perl w/gitweb/gitweb.perl
> index 301bdd8..7701bac 100755
> --- c/gitweb/gitweb.perl
> +++ w/gitweb/gitweb.perl
> @@ -3407,6 +3407,8 @@ sub git_print_log {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$signoff =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$empty =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (! $opts{'-remove_s=
ignoff'}) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my ($em=
ail) =3D $line =3D~ /<(\S+@\S+)>/;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print g=
it_get_avatar($email, 'pad_after' =3D> 1) if $email;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print =
"<span class=3D\"signoff\">" . esc_html($line) . "</span><br/>\n";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0next;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {

I think that putting them aligned on the right is somewhat better
because both in commit(diff) and in log view the author/committer
avatar is already on the right.

--=20
Giuseppe "Oblomov" Bilotta
