From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH] howto/maintain-git.txt: new version numbering scheme
Date: Mon, 3 Feb 2014 22:03:36 -0000
Organization: OPDS
Message-ID: <9E6F99D96D124571897121E4227508EF@PhilipOakley>
References: <xmqqfvo3hhhe.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 23:03:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WARcF-0005rd-2k
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 23:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbaBCWDi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Feb 2014 17:03:38 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:5525 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750AbaBCWDi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Feb 2014 17:03:38 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtU3ANMR8FICYJ+4/2dsb2JhbABZgww4EAOJA7VMAQECAQiBBxd0aQEBgR8BARQBBAEBBAEIAQEdCwEFFggBARYWAgMFAgEDFQELJRQBBBgCBgcXBgEHCwgCAQIDAQwEhSgHAYITGQwJzX2PPoJ2gRQEiRGGGYoykG+DLTw
X-IPAS-Result: AtU3ANMR8FICYJ+4/2dsb2JhbABZgww4EAOJA7VMAQECAQiBBxd0aQEBgR8BARQBBAEBBAEIAQEdCwEFFggBARYWAgMFAgEDFQELJRQBBBgCBgcXBgEHCwgCAQIDAQwEhSgHAYITGQwJzX2PPoJ2gRQEiRGGGYoykG+DLTw
X-IronPort-AV: E=Sophos;i="4.95,774,1384300800"; 
   d="scan'208";a="434750789"
Received: from host-2-96-159-184.as13285.net (HELO PhilipOakley) ([2.96.159.184])
  by out1.ip04ir2.opaltelecom.net with SMTP; 03 Feb 2014 22:03:34 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241480>

=46rom: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, January 31, 2014 11:14 PM
> We wanted to call the upcoming release "Git 1.9", with its
> maintenance track being "Git 1.9.1", "Git 1.9.2", etc., but various
> third-party tools are reported to assume that there are at least
> three dewey-decimal components in our version number.
>
> Adjust the plan so that vX.Y.0 are feature releases while vX.Y.Z
> (Z > 0) are maintenance releases.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> * Haven't committed to this outline, but I am raising a
>   weather-balloon to see reaction from the list.  Comments?

=46rom a familiarity viewpoint the (my) expectation would be that a
colloquial "V1.9" would be 1.9.0 under the hood (that is, the version
string would say that).

If we are progressing from V1.9 to V2.0 quickly (one cycle?), which I
understand is the plan, then mixing the minor development items (patch
series which progress to master) with the maintenance fixes over the
next few months, thus only having 1.9.x releases, sounds reasonable.

If there is going to be separate maintenance fixes from the patch serie=
s
developments then keeping to the previous 1.9.x.y for maintenance would
be better.

Will the new rapid counting continue after V2.0, such that we get to
V2.9 -> V3.0 rather more quickly than V1.0 -> V2.0 ?

The key discriminator would be to say when V2.0 will be out for decidin=
g
the V1.9 sequence.

My =A30.02p

Philip

>
> Documentation/howto/maintain-git.txt | 18 +++++++++++-------
> 1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/howto/maintain-git.txt
> b/Documentation/howto/maintain-git.txt
> index 33ae69c..ca43787 100644
> --- a/Documentation/howto/maintain-git.txt
> +++ b/Documentation/howto/maintain-git.txt
> @@ -39,26 +39,26 @@ The policy on Integration is informally mentioned
> in "A Note
> from the maintainer" message, which is periodically posted to
> this mailing list after each feature release is made.
>
> - - Feature releases are numbered as vX.Y.Z and are meant to
> + - Feature releases are numbered as vX.Y.0 and are meant to
>    contain bugfixes and enhancements in any area, including
>    functionality, performance and usability, without regression.
>
>  - One release cycle for a feature release is expected to last for
>    eight to ten weeks.
>
> - - Maintenance releases are numbered as vX.Y.Z.W and are meant
> -   to contain only bugfixes for the corresponding vX.Y.Z feature
> -   release and earlier maintenance releases vX.Y.Z.V (V < W).
> + - Maintenance releases are numbered as vX.Y.Z and are meant
> +   to contain only bugfixes for the corresponding vX.Y.0 feature
> +   release and earlier maintenance releases vX.Y.W (W < Z).
>
>  - 'master' branch is used to prepare for the next feature
>    release. In other words, at some point, the tip of 'master'
> -   branch is tagged with vX.Y.Z.
> +   branch is tagged with vX.Y.0.
>
>  - 'maint' branch is used to prepare for the next maintenance
> -   release.  After the feature release vX.Y.Z is made, the tip
> +   release.  After the feature release vX.Y.0 is made, the tip
>    of 'maint' branch is set to that release, and bugfixes will
>    accumulate on the branch, and at some point, the tip of the
> -   branch is tagged with vX.Y.Z.1, vX.Y.Z.2, and so on.
> +   branch is tagged with vX.Y.1, vX.Y.2, and so on.
>
>  - 'next' branch is used to publish changes (both enhancements
>    and fixes) that (1) have worthwhile goal, (2) are in a fairly
> @@ -86,6 +86,10 @@ this mailing list after each feature release is
> made.
>    users are encouraged to test it so that regressions and bugs
>    are found before new topics are merged to 'master'.
>
> +Note that before v1.9.0 release, the version numbers used to be
> +structured slightly differently.  vX.Y.Z were feature releases while
> +vX.Y.Z.W were maintenance releases for vX.Y.Z.
> +
>
> A Typical Git Day
> -----------------
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
