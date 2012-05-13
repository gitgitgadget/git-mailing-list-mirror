From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: Some help on gitweb project.
Date: Sun, 13 May 2012 23:41:02 +0530
Message-ID: <CAH-tXsB06e9BfzxjFhbwMSx3Xb9TAy=qekSstqWcqkWt_PGWbg@mail.gmail.com>
References: <CAH-tXsAFMyrkAD1FWZKimbJt-gzmcyyXqt7gymtKozwfFt_aSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 13 20:11:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STdGp-0001rl-VU
	for gcvg-git-2@plane.gmane.org; Sun, 13 May 2012 20:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab2EMSLr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 May 2012 14:11:47 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:49399 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab2EMSLq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2012 14:11:46 -0400
Received: by weyu7 with SMTP id u7so1340204wey.19
        for <git@vger.kernel.org>; Sun, 13 May 2012 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oRaDWMuhKtJ+rYkPLN3ov0emqBfsSa+I/8JU1FPlXsU=;
        b=PFDg3kZVQJMx6/+ZDX107wgWQb5/xYm0P5Pv4Mut6iRUf5eabRwKcVK19X6yigoN2l
         XW6PleMUwyTi7Eti9UfuLNmQQ1BoUCYtUvrbI21kNr48XPkdiqFgpWg7/QhQ3K+zrLDR
         6o1qmA6RP9oyhr3ItP7w6HiGhwlKvL4TNf6vz30dUdV1tAPH6puhFgW076nPPNEmEl0v
         B3vnrjeuWI0FRrlRB74Dr/oj5AcgeSAQqDrJ4z28ssEUAuZhVcXy72vJt4uDPnPQ+e+t
         BOnsp4TAgx5GqqWdcagMWg+4k1ASaG6MMYg3v90BmNiAj1C99B0tNKhGQVrmnOMyNFJu
         18AA==
Received: by 10.180.80.104 with SMTP id q8mr6026438wix.14.1336932702691; Sun,
 13 May 2012 11:11:42 -0700 (PDT)
Received: by 10.227.39.96 with HTTP; Sun, 13 May 2012 11:11:02 -0700 (PDT)
In-Reply-To: <CAH-tXsAFMyrkAD1FWZKimbJt-gzmcyyXqt7gymtKozwfFt_aSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197751>

On Sun, May 13, 2012 at 11:11 PM, jaseem abid <jaseemabid@gmail.com> wr=
ote:
>
> Dear all,
>
> CC : Andrew Sayers, Jakub Nar=C4=99bski
>
> I have been working on gitweb for a couple of days as part of a
> rejected GSoC proposal. I would love to get some help on this and if
> somebody can, that would be thankful.
>
> 1. How is code tested after some change? I am not talking about unit
> testing but about making sure that application is doing what it is
> actually intended to do. Do you have to re - install git/gitweb with
> every version of code you commit and make sure that it works well and
> as expected? Or, is there some other way? Sorry but I am a newbie whe=
n
> it comes to FOSS contribution and as well working on a project of thi=
s
> magnitude.
>
> As far as I understand, gitweb by default is looking for files from
> `/usr/share/gitweb/` (I work on Debian Sid if that helps). If I edit
> the perl or some JavaScript code, how should I test it? *Install* my
> version from source as mentioned in "gitweb/INSTALL" ?


Adding a bit more to the last mail. In the specific case of gitweb, I
can sym link files from `/usr/share/giweb` or any installation folder
to the working directory for testing. Then all I have to do is to
rebuild the files and forget about moving the files to right place. Is
it ok to develop this way? I am looking for some good practices here
on this.

--
Jaseem Abid
http://jaseemabid.github.com
