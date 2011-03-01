From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #07; Mon, 28)
Date: Tue, 1 Mar 2011 09:39:07 +0100
Message-ID: <AANLkTiksROE_dQTUn3Y_1Op6NDpGzEsSJ70JNYyYrufS@mail.gmail.com>
References: <7vbp1vfy5f.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 09:39:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuL7K-0007j9-BR
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 09:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab1CAIjc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 03:39:32 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38576 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab1CAIjb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 03:39:31 -0500
Received: by fxm17 with SMTP id 17so4571693fxm.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 00:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=l9sMDO5i+YRasimZQtSgppATaTLzZFp3Yhk0uKMYv/A=;
        b=H+E6DXv+zfY72dqOyepkSAv+AWSm7IcftZ92drJ4s2rsT6FeXcZr+Nj4OUw0M6jiQa
         gG5wFhTBEWYLS0CcUakuyDfgHcbapmaN4jRBIVQ8UY9wdOpm0JnZsSXk5Reld4FtXWse
         Uo/BkuNsliP9BzHVvjP4jYcMyTNpY3VbhKpkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=SwAG+GrS4ILNoMsB6O87vDb5lL7MATMUTynJbbcNRCVe6h7QEOUI6+66J8EMZRWzB/
         o9enEuL30OKMBOMS5BtPprrw6rA8148HO7wqr7Xp/CXMJ/42MgDdqlNX1UDcNqwW1o3z
         7+ORVP2m6OrKf/Qi5WGDX5sST3LT3eAjrsYjM=
Received: by 10.223.85.208 with SMTP id p16mr2482361fal.107.1298968768205;
 Tue, 01 Mar 2011 00:39:28 -0800 (PST)
Received: by 10.223.95.206 with HTTP; Tue, 1 Mar 2011 00:39:07 -0800 (PST)
In-Reply-To: <7vbp1vfy5f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168190>

On Tue, Mar 1, 2011 at 2:05 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Here are the topics that have been cooking. =A0Commits prefixed with =
'-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.
>
> I started draft release notes for 1.7.5 on 'master' branch.
>
> --------------------------------------------------
> [New Topics]
>
> * jc/diff-irreversible-delete (2011-02-28) 1 commit
> =A0- git diff -D: omit the preimage of deletes
>
> Just a POC.
>
> * jc/index-pack (2011-02-25) 5 commits
> =A0- index-pack --verify: read anomalous offsets from v2 idx file
> =A0- write_idx_file: need_large_offset() helper function
> =A0- index-pack: --verify
> =A0- write_idx_file: introduce a struct to hold idx customization opt=
ions
> =A0- index-pack: group the delta-base array entries also by type
>
> Still a WIP.
>
> * mm/push-default-advice (2011-02-28) 2 commits
> =A0- push: better error messages for detached HEAD and "no destinatio=
n"
> =A0- push: better error message when push.default =3D tracking
>
> There were some rewording discussion I didn't roll into this, not bec=
ause
> I had objections to, but because I was handling other topics. =A0I ex=
pect
> I'll see a reroll soonish so that we can merge this down soonish.
>
> * sp/maint-fd-limit (2011-02-28) 2 commits
> =A0- mingw: add minimum getrlimit() compatibility stub
> =A0- Limit file descriptors used by packs
>
> Erik, please check the made-up commit log message and sign it off.
> Will merge to 'next' after that.

Do you have any hint on how I can create a repo with more than 2048
packs so I can test that the patch works?

It builds just fine, perhaps that's enough? I guess Shawn already
tested the other part...

The reason I'm a bit in doubt is the following comment (from MSDN):

"Note   This upper limit may be beyond what is supported by a
particular Win32 platform and configuration."

But searching a bit more, it seems that the rest of the world seems to
think 2048 is the correct maximum. I especially take comfort in
reading that mysql (who keep a lot of open files) had their
OS_FILE_LIMIT define set to 2048, and it seemed to work (apart from
the times they needed even more open files!). I also find that there's
a registry key called "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows
NT\CurrentVersion\Windows\USERProcessHandleQuota", and this is
probably what they mean to warn about. I think consulting that would
be completely overkill, and probably not even practically possible
(because the relationship between the maximum number of open files and
the maximum used handles isn't trivial).

There's also the added complication that _open_osfhandle also seems to
be limited by this 2048 limit (see the third comment here:
http://bugs.mysql.com/bug.php?id=3D24509). We use this function for
pipes and sockets as well. This alone might be a reason to corner-case
test the resulting binary on Windows properly.
