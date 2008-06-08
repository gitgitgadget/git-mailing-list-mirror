From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Port to 12 other Platforms.
Date: Sun, 8 Jun 2008 19:19:03 +0200
Message-ID: <200806081919.05273.jnareb@gmail.com>
References: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com> <vpqve0j3nkd.fsf@bauges.imag.fr> <Pine.LNX.4.64.0806081028460.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 19:21:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5OZw-0007xM-67
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 19:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbYFHRTx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 13:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754836AbYFHRTX
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 13:19:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:5004 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbYFHRTK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 13:19:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1248061fgg.17
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iOStnJSKZ2Slhjx8opM1cBT5s3uJCgwhCaMwD0LeAq8=;
        b=O7kPWr+8Jwifw84yuL86eM5xCzbNH7G3OedErQ+nqwkewL6jTrB4DfJI+SxsQxAbss
         Mu/crXymBxu9foF+1AHxkiccadUtwWW5/tin0FErliYjO5PmDvkFHMwOoXU2KtwHF6FX
         cXHYyRs6sM0UG9zonpjm2g3pBaMPsV5gBu/M4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cBmMctZp/AOv+I+fcM7T4yu8mLkHDYzv/9ejF6AMUU0Fpnh1ejvaO+CTqN8YWUxW50
         Podf6yNnld50cJ6zfF53Af6oLTYA4J+R3D1UFKfmakQvTIsnWetHSboTTXw2nFR+tjaG
         +J4NZo7g2B8mvZteOtGji8MQwnA5j5SaztU2Y=
Received: by 10.78.201.10 with SMTP id y10mr1316971huf.59.1212945549085;
        Sun, 08 Jun 2008 10:19:09 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.161])
        by mx.google.com with ESMTPS id 40sm10138383hue.40.2008.06.08.10.19.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 10:19:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0806081028460.18454@xenau.zenez.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84296>

On Sun, 8 Jun 2008, Boyd Lynn Gerber wrote:
> On Sun, 8 Jun 2008, Matthieu Moy wrote:
>> Boyd Lynn Gerber <gerberb@zenez.com> writes:
>>>
>>> This was from my own copy of the master archive.  It is my proposal=
=2E  I=20
>>> thought you had to get an OK from this list before you do a push to=
 the=20
>>> main archive.
>>=20
>> You won't do a push, the maintainer will apply the patch if it seems
>> OK.
>=20
> Thanks, I understand better now.

By the way, if you want to send large series of patches, and you have
your git repository published somewhere (repo.or.cz, gitorious, github,
freedektop, kernel.org), sometimes pull request is used.  As you
usually use git-format-patch (perhaps together with git-send-email)
when sending patches, you can use output of git-request-pull there.

Just FYI, you can safely ignore above.

>>> What am I missing?
>>=20
>> The format used to send patches. git format-patch and git send-email
>> would do that for you, but in particular : what comes after =C2=AB=C2=
=A0---=C2=A0=C2=BB
>> and before the patch itself is ignored by the tools, just an
>> informative message for people reading your email. What comes before
>> this =C2=AB=C2=A0---=C2=A0=C2=BB is the commit message.
>=20
> I moved the message from above my commiter message because I was told=
 to=20
> add comments after the --- with the file being modified.  The reasons=
 for=20
> the modifications.  I used git format-patch -p -M -B origin to genera=
te=20
> this email.  All I did was read the contents into the email I create =
for=20
> posting.  This was the advice I was given on IRC as the best method t=
o=20
> create/send the patch.  When on IRC I was omitting the -p and was not=
=20
> getting the .patch file.  After reading the docs over and over I fina=
lly=20
> noticed I was missing the -p.  Once I added it I got the patch file a=
nd=20
> then I emailed it to the list.

Strange.  While in git-diff family of commands '-p' means generate
diff in patchset format:

       -p     Generate patch (see section on generating patches).

it has different meaning (oops) in git-format-patch:

       -p     Generate patches without diffstat.

(What is probably a bug in git-format-patch it doesn't add "---\n"
separator between commit message and patch itself).


Everything between "---\n" after commit message (usually ending in
Signed-off-by) and the diffstat and patch is a transient comment,
which won't get included in commit message, and wouldn't be anywhere
in the repository, neither in contents not in commits.

What you put there is information which shouldn't be in commit message,
like for example difference from previous version of patch, sometimes
explanation behind _why_ of this patch; you put there to which branch
this patch applies, if it is not 'master' (por example if it requires
material from 'next') or if given patch depends on earlier patch NOT
in the series.

IMVVVHO you should put verbatim copy of certificate of origin there,
but put the comment about which operating systems needs which defines,
or use which defines, and why either in commit message, in comment in
some file, or both.

HTH (Hope That Helps).
--=20
Jakub Narebski
Poland
