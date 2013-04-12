From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #04; Fri, 12)
Date: Sat, 13 Apr 2013 00:30:16 +0200
Message-ID: <51688AF8.3010200@gmail.com>
References: <7vehefctrf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 00:30:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQmUD-0008PG-Ms
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 00:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397Ab3DLWaW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 18:30:22 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:48804 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab3DLWaV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 18:30:21 -0400
Received: by mail-ea0-f180.google.com with SMTP id d10so1412194eaj.11
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=15PT/xmlM7kD8UbG6sM/2GPciss2pBKkK5yQBFEuAhQ=;
        b=sPCt/folgkGfxmvBJETenL+9QO4zfWQTpE4RhATvy5JqL+m2YnyxfA7dtnYQE/EOrd
         Q7KewIRLKJB5B5JmyBMdXL2D+1DriCn2kOQNaczM6T5kVsoNjXIftj2eMYhv3+W/LnW0
         y1ydVEV0NcSJ5v5BAfCN5aCoFd7BfVAkuerZWEUrH+UhI6JKJuY9yn1gOmDxd8ceKS0F
         dLgzt+4XlJxEdUxofZti3dN+eTMERISvagVBjPZFGvzxCeFfuRqM9HQDK4/ACQgnFt74
         ON0st+MNtEygsnd9fJwxrVl6F6zNVGqaqKh5MfKAyi2PnZTAmsSNy3duKMtpQf5VSOBe
         H9Mw==
X-Received: by 10.14.149.141 with SMTP id x13mr85162eej.31.1365805819388;
        Fri, 12 Apr 2013 15:30:19 -0700 (PDT)
Received: from [192.168.1.14] (aeed59.neoplus.adsl.tpnet.pl. [79.186.107.59])
        by mx.google.com with ESMTPS id t4sm13530010eel.0.2013.04.12.15.30.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 15:30:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vehefctrf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221034>

W dniu 12.04.2013 23:40, Junio C Hamano pisze:

> --------------------------------------------------
> [New Topics]
> * ap/strbuf-humanize (2013-04-10) 2 commits
>  - count-objects: add -H option to humanize sizes
>  - strbuf: create strbuf_humanise_bytes() to show byte sizes
>=20
>  Teach "--human-readable" aka "-H" option to "git count-objects" to
>  show various large numbers in Ki/Mi/GiB scaled as necessary.
>=20
>  Will merge to 'next'.
>=20
>  It may not be a bad idea to discard mc/count-objects-kibibytes,
>  which can introduce regression to scripted users that expect the
>  output to say "N kilobytes".  Opinions?

> --------------------------------------------------
> [Cooking]
> * mc/count-objects-kibibytes (2013-04-03) 1 commit
>   (merged to 'next' on 2013-04-05 at f4e50e8)
>  + count-objects: output "KiB" instead of "kilobytes"
>=20
>  The command reports the total diskspace used to store loose objects
>  in kibibytes, but it was labelled as "kilobytes".  The number now
>  is shown with "KiB", e.g. "6750 objects, 50928 KiB".
>=20
>  If you have scripts that decide when to run "git repack" by parsing
>  the output from "git count-objects", this release may break them.
>  Sorry about that.  One of the scripts shipped by git-core itself
>  also had to be adjusted.  You may want to consider updating such
>  scripts to always call "git gc --auto" to let it decide when to
>  repack for you.
>=20
>  Will merge to 'master'.

So mc/count-objects-kibibytes is to be discarded, or merged to 'master'=
?
--=20
Jakub Nar=C4=99bski
