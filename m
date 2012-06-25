From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: Urgent: Issue with GIT ...
Date: Mon, 25 Jun 2012 18:35:46 +0530
Message-ID: <CAH-tXsBMtGJyWiWop1n26OWKei-yfojz9X20ZrnPYgru=F0TVg@mail.gmail.com>
References: <1340624980925-7562097.post@n2.nabble.com> <20120625160734.d8227e5d.kostix@domain007.com>
 <1340628925770-7562100.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: guruprasad <guruprasadkinI@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 15:06:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj900-0000hE-7y
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 15:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515Ab2FYNGc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 09:06:32 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39530 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090Ab2FYNGb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 09:06:31 -0400
Received: by wibhr14 with SMTP id hr14so1087500wib.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tX6MMYtJRe8IDfNTNCQpklgfLAaRx4FPsxDf4NfiYF4=;
        b=YfnX4aaZ7F8Eff7/DniuzBTNpdNnDFEjdFZ6jlIhlQOZVgCwvjJgGXzXLC19Rxnnvo
         Df4K73MiUl3dAbId5jKqinuPkWfB42VmzVVYP/MVoLc8HybzDNDMtI+uCfcWyZwgg9Lg
         EdoPOC/LB3Ll8ab5OYWhPw8UDHPbsPEIbnRmCF8WyOj5ThvSdrE2v4NoDwbb+vgHBIa8
         NpOYMOwR1rfnxtMadOvwO0NOKpCTYQEJTrnpWk+EqeAI8YBNImguwJ2e6PvLdzivnS2X
         ku4b2igiQ9qC6cmu10H5UMtstsQLvp2Na2CFAdBFOfVgP+9+fumMjCfW4qr27icepNAd
         /S/Q==
Received: by 10.180.103.4 with SMTP id fs4mr16718863wib.16.1340629587202; Mon,
 25 Jun 2012 06:06:27 -0700 (PDT)
Received: by 10.227.37.22 with HTTP; Mon, 25 Jun 2012 06:05:46 -0700 (PDT)
In-Reply-To: <1340628925770-7562100.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200577>

On Mon, Jun 25, 2012 at 6:25 PM, guruprasad <guruprasadkinI@gmail.com> =
wrote:
> Firstly, I apologize for staring subject with "Urgent" and thank you =
very
> much for your time and response.
>
> As i told in my post earlier i am very much new to GIT, I was bit con=
fused
> with the tests i went on. I am sorry for not describing it clearly in=
 my
> last post.
>
> 1) Pull command is working fine with both the Linux box. Comp A can p=
ull
> updates from comp B, vise versa.
>
> 2) Push command is not working with both Linux box, command given bel=
ow.
> =C2=A0 =C2=A0 =C2=A0 git push A master/git push B master
>
> 3) When i tried above command first time got an error saying
> remote: error: refusing to update checked out branch: refs/heads/mast=
er
> remote: error: By default, updating the current branch in a non-bare
> repository
> remote: error: is denied, because it will make the index and work tre=
e
> inconsistent
> remote: error: with what you pushed, and will require 'git reset --ha=
rd' to
> match
> remote: error: the work tree to HEAD.
> remote: error:
> remote: error: You can set 'receive.denyCurrentBranch' configuration
> variable to
> remote: error: 'ignore' or 'warn' in the remote repository to allow p=
ushing
> into
> remote: error: its current branch; however, this is not recommended u=
nless
> you
> remote: error: arranged to update its work tree to match what you pus=
hed in
> some
> remote: error: other way.
> remote: error:
> remote: error: To squelch this message and still keep the default beh=
aviour,
> set
> remote: error: 'receive.denyCurrentBranch' configuration variable to
> 'refuse'.
> To user@A:/home/user/workspace/TestProject/.git
> =C2=A0! [remote rejected] master -> master (branch is currently check=
ed out)
> error: failed to push some refs to
> 'user@A:/home/user/workspace/TestProject/.git'
>
> so i added receive.denyCurrentBranch =3D ignore into git config and t=
ried
> again. I dint get any error.
>
> 4) But, modified things in files did not get reflected. i tried to pu=
sh from
> A-->B and B-->A. both dint work.
> 5) Push command i tried after modifying file, staging and committing.
>
> Please let me know if more information is required.
>
> Yes, I posted the same question to the git-users ML. Sorry for not
> mentioning it in my post.

If you really need a quick answer, hit the #git IRC channel on
freenode. Its a zillion times faster than the mailing list.

--=20
Jaseem Abid
http://jaseemabid.github.com
