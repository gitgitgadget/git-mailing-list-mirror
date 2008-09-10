From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH] git-svn: Fixes my() parameter list syntax error in pre-5.8
 Perl
Date: Wed, 10 Sep 2008 11:11:15 -0400
Message-ID: <48C7E393.2070006@griep.us>
References: <48C7745F.1070008@statsbiblioteket.dk> <1221059386-3972-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 17:12:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdRMs-0002mx-4m
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 17:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbYIJPLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2008 11:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbYIJPLW
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 11:11:22 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:32471 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYIJPLV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 11:11:21 -0400
Received: by py-out-1112.google.com with SMTP id p76so1664259pyb.10
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 08:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=f8FI06OkevDgCH/6/zYbQ86sXU5jE0kPJXY5xFdCtwY=;
        b=cob52XBMdWPX+38JaZI0tDykXmu8vBJLVjneTS8zYQF5O+1a3epxnhk6Br9o3WzMGZ
         K5Oa9R+UiwE0lVcGtOy6zFPoH4aviH4ty03S6orYGwzOtkx+aHvA+fIMuY69IzNLxGQ0
         3Djz2Rwb22hk2zuEIjHtYw2gmrUyiAt1W7utY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=cCGjYdTXV1uT/4S7Ku0i9EDtkEisynSnucILSif04D4ObOjIokOlsbzJcYpSlXGyV3
         MUZV2ILGQ8YTc7DXdSGcC+qtH2zFlqSkKl1YS8siYIiqwiCrIL/RJ6C4iYQXmQi+U7il
         Cf/h7oErefAGzEAQF0Fd2UwUGbrHFUliBOdQo=
Received: by 10.114.39.16 with SMTP id m16mr762721wam.98.1221059479812;
        Wed, 10 Sep 2008 08:11:19 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id h36sm19342392wxd.26.2008.09.10.08.11.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 08:11:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <1221059386-3972-1-git-send-email-marcus@griep.us>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95525>

Sorry:

Signed-off-by: Marcus Griep <marcus@griep.us>

Marcus Griep wrote:
> ---
>=20
>  Per Tom G. Christensen's commentary on a breaking test in git-svn.
>=20
>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-svn.perl b/git-svn.perl
> index ecacf74..a97e1ca 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -4425,7 +4425,7 @@ sub config_pager {
> =20
>  sub run_pager {
>  	return unless -t *STDOUT && defined $pager;
> -	pipe my $rfd, my $wfd or return;
> +	pipe my ($rfd, $wfd) or return;
>  	defined(my $pid =3D fork) or ::fatal "Can't fork: $!";
>  	if (!$pid) {
>  		open STDOUT, '>&', $wfd or

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
