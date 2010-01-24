From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git push failed
Date: Sun, 24 Jan 2010 18:35:41 -0500
Organization: 
Message-ID: <76718491001241535n7c47e898mbade26caa312b9db@mail.gmail.com>
References: <6672d0161001240952s7f7629a6v48f5756c083b95b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 00:35:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZBze-0000n0-T5
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 00:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab0AXXfp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2010 18:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837Ab0AXXfp
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 18:35:45 -0500
Received: from mail-iw0-f183.google.com ([209.85.223.183]:40781 "EHLO
	mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab0AXXfn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2010 18:35:43 -0500
Received: by iwn13 with SMTP id 13so2463873iwn.20
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 15:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z9xa+/duKKbFMFSKv9KV1P/0dkVdnDcHR0r8dVOjdHw=;
        b=rfsBhuXg5Re8fLjpf8insuPPMgtw56nFEgf9ikLKtr7S+ss93ixOC5IIlV9bWRzpUv
         r6xaKmbCkSm91TFJPXWnQ0nf8EVZHNHfpBCg7OWNujhnnHDCVf/aiAvBMLhrhljS/IPg
         oOa9vidaPxqf/rpyVVbk3zPCLUxS6pHZK5g5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wNdbVklGwwQOLIqF8EtWKwyvSDD0ES2ckRt390SHEXSk+wnYlQ3w7fEESfICQnRcTp
         P7FE/l9wsmnyzMYhpP5ksQdBoi4LmzXsdejBjdraD1J1+obZENtva0z12iFfRfnOxl9f
         eBVp6DHfdYrxIu011MpE5wLGIeq3DF2/tP0DY=
Received: by 10.231.159.207 with SMTP id k15mr3022517ibx.75.1264376141152; 
	Sun, 24 Jan 2010 15:35:41 -0800 (PST)
In-Reply-To: <6672d0161001240952s7f7629a6v48f5756c083b95b5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137927>

2010/1/24 Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>:
> With git built from master (v1.6.6.1-436-gaba7dea),
> the following commands (run in a script):
>
> =C2=A0git commit --amend -m "Update index.html" index.html
> =C2=A0git push erlang +gh-pages
>
> failed like this:
>
> Counting objects: 4, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (3/3), 3.85 KiB, done.
> Total 3 (delta 0), reused 0 (delta 0)
> error: Ref refs/heads/gh-pages is at
> db10c045e068f12aa2f78377fab31e35a8443ca4 but expected
> 054136d96494979b42524a4dc08ef643bb54cc0e
> error: failed to lock refs/heads/gh-pages
> To git@erlang_github.com:erlang/otp.git
> =C2=A0! [remote rejected] gh-pages -> gh-pages (failed to lock)
> error: failed to push some refs to 'git@erlang_github.com:erlang/otp.=
git'
>
> Unfortunately (from the point of view of finding the bug), the
> problem is not reproducible. When I ran my script two more times,
> it worked fine.
>
> We all know how difficult it is to investigate non-reproducible bugs,
> but perhaps someone familiar with the code might have some idea
> about what it could be.
>
> Info about my system:
>
> Mac OS X 10.2.6 (8 cores)
> gcc-4.2.1

As another data point, I've noticed the same issue pushing from one
Mac OS X 10.6.2 system to another. However, the remote end is updated
properly (if you push again you'll see there's nothing to update), so
I've not bothered to dig into what the cause might be.

j.
