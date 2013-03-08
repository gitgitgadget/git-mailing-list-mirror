From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git svn: consistent spacing after "W:" in warnings
Date: Fri, 08 Mar 2013 08:06:44 -0800
Message-ID: <7vfw05ho4r.fsf@alter.siamese.dyndns.org>
References: <000e01ce1b26$dbb65570$93230050$@certicon.cz>
 <20130308095330.GA20205@dcvr.yhbt.net> <20130308100152.GA32643@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, 'Matthieu Moy' <Matthieu.Moy@grenoble-inp.fr>,
	'Sam Vilain' <sam@vilain.net>,
	Jan =?utf-8?Q?Pe=C5=A1ta?= <jan.pesta@certicon.cz>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Mar 08 17:07:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDzpE-0002Rp-8L
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 17:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759740Ab3CHQGu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 11:06:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758816Ab3CHQGt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Mar 2013 11:06:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E50DAF98;
	Fri,  8 Mar 2013 11:06:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aVupboMf1QYI
	Bzo5Qt+HxGSEt5s=; b=K+TITf7SOYglbdCHuNkmYIEKH1I9T/x7FNLikA34UqGs
	arWoDYlPLvZDgFNs3uNChC/1cmNuF0L1cI5d61cP4VrgXNYjA70E645qYgVq2yzd
	eR90/dpzkurq2NyNefMe8hFQRU07wx61g6A/phLJIwqEa5uv+S0b4iEBJDA0yQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=USj8Uk
	kQj3y1U4g0U5ADUj2OjjnIDiE0Rz/CRBniVYI61QxikzBdeh0O1y1VHF/cI1RC/J
	U3IwYs6QTJbraQmQgtgoU/0L/RuA/RWyE45upmHmmTsb0vhM8Nus77N6/zebvDSa
	7Yd0YvXxf4PW3Eo18tedOrXz/5x7/Ky+ef7Q8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03B51AF91;
	Fri,  8 Mar 2013 11:06:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CB3AAF8F; Fri,  8 Mar 2013
 11:06:47 -0500 (EST)
In-Reply-To: <20130308100152.GA32643@dcvr.yhbt.net> (Eric Wong's message of
 "Fri, 8 Mar 2013 10:01:52 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DC14A32-880A-11E2-8B8C-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217666>

Eric Wong <normalperson@yhbt.net> writes:

> Eric Wong <normalperson@yhbt.net> wrote:
>> will push another change for formatting existing warnings more
>> consistently.
>
>   Just pushed.  My master is sitting at git://git.bogomips.org/git-sv=
n.git
>   commit eae6cf5aa8ae2d8a90a99bbe4aeb01c29e01fd02

Thanks.

>
>   Eric Wong (1):
>         git svn: consistent spacing after "W:" in warnings
>
>   Jan Pe=C5=A1ta (1):
>         git svn: ignore partial svn:mergeinfo
>
>   I don't have further updates planned, maybe others do.
> ----------------------------8<------------------------------
> From eae6cf5aa8ae2d8a90a99bbe4aeb01c29e01fd02 Mon Sep 17 00:00:00 200=
1
> From: Eric Wong <normalperson@yhbt.net>
> Date: Fri, 8 Mar 2013 09:46:41 +0000
> Subject: [PATCH] git svn: consistent spacing after "W:" in warnings
>
> All other instances of "W:"-prefixed warning messages have a space af=
ter
> the "W:" to help with readability.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  perl/Git/SVN.pm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 46aeb85..5273ee8 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1504,7 +1504,7 @@ sub lookup_svn_merge {
>  		my $top_commit =3D $gs->find_rev_before( $top, 1, $bottom );
> =20
>  		unless ($top_commit and $bottom_commit) {
> -			warn "W:unknown path/rev in svn:mergeinfo "
> +			warn "W: unknown path/rev in svn:mergeinfo "
>  				."dirprop: $source:$range\n";
>  			next;
>  		}
