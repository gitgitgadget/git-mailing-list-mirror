From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Fri, 24 Dec 2010 08:39:41 +0700
Message-ID: <AANLkTikaBfVw-4eD9qeGSdM5xKxq-gJ-3oAe4B2qt4od@mail.gmail.com>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org> <AANLkTinH0h5euL=_wMpGirVEEYgoA9hXGhKGja9oPa2j@mail.gmail.com>
 <7vfwto2ytb.fsf@alter.siamese.dyndns.org> <4D13DCDD.3050300@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Dec 24 02:40:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVwdp-00059s-0G
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 02:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab0LXBkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Dec 2010 20:40:14 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44640 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab0LXBkM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Dec 2010 20:40:12 -0500
Received: by wwa36 with SMTP id 36so6976497wwa.1
        for <git@vger.kernel.org>; Thu, 23 Dec 2010 17:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jNYNxVYRjouJjXu0c+VE1XiiAR1vAl189R0/vg/1Sq0=;
        b=Ch/cmVqbQtHT/54HiV/pbwP+0XNKIAFq8bNEhrKyzo6Cj5JawPEk1PhnxjcLqueIQL
         eGqvOFCEqjJZVNdyzqRrzp8xsr2/Gt+qCX69OVE0jvUBUKaGswodwUc5ZC6PhMgP6sN6
         aCIkuaRrq6Ve6s2+soN5GPtqwW0lBtGdO4L5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Z/ppYStd2YknfkaX+wz2vz3thtPwnnkoQbSw4T17bVDDFQqgbAXf8PAccn1IIYeLgL
         ft36JerpkW8JHx57XWv52BDTpdYTSoHqw5DHauvyCuDMP2BFFJi+27Ml4/RqMIx5VGgw
         IRZwmtkgoKX3W6NKFOwMqe/b4oNWYg1w5cUp8=
Received: by 10.216.46.19 with SMTP id q19mr2501653web.0.1293154811530; Thu,
 23 Dec 2010 17:40:11 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Thu, 23 Dec 2010 17:39:41 -0800 (PST)
In-Reply-To: <4D13DCDD.3050300@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164145>

On Fri, Dec 24, 2010 at 6:35 AM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> Having said that, I have had 100 people using the jj/icase-directory =
series
> on Windows daily for 4 months now without issue. =C2=A0Prior to that,=
 a majority
> of the series had been used for a full year by a dozen people. =C2=A0=
In any case,
> the improvement on non-case sensitive file systems is the difference =
between
> night and day, and the series has helped prevent a number of messes t=
hat
> occurred without it (git add readme.txt and git add Readme.txt, for
> example... ugh...).
>
> More than Windows, this series also affects Mac OS X in a positive ma=
nner,
> though the case sensitivity problems can be considered worse. =C2=A0W=
hen you
> change directories at the command line, the command line retains the =
case
> you used to change directory, and then Git uses that case as the rela=
tive
> path into the repository. =C2=A0Ugh... this is different than on Wind=
ows where
> the file system's directory case is retained at the Command Prompt as=
 you
> change directories. =C2=A0(Cygwin actually appears to have the proble=
m, too, but
> MinGW, what msysGit is built upon, does not.)
>
> The Mac OS X issue listed above is not a reason not to publish the se=
ries,
> though, as the fixes necessary to make that work are in completely di=
fferent
> areas in Git than the current jj/icase-directory series.
>
> Finally, I'm sitting on a bunch of other case sensitivity refinements=
, but
> I'd like to get one series published before evolving this more. =C2=A0=
I'd like to
> get the other ones out there for discussion, but they build on the cu=
rrent
> series.

If you have not known already, path in "git log ref -- path" must be
case sensitive. Solving that is not hard: ce_path_match() and
tree_entry_interesting() are the ones that do path matching. Those
functions are nearly replaced in this series. I'll add
case-insensitive support to them, so you can worry about other places.

> In reference to above, where is match_pathspec_depth()? =C2=A0I can o=
nly find
> match_pathspec().

 Introduced in this series, nd/setup.
--=20
Duy
