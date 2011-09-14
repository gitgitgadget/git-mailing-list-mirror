From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [Survey] Signed push
Date: Wed, 14 Sep 2011 21:58:42 +1000
Message-ID: <CACsJy8Dwu2U-7eEZU-VYmcrA7JwtvUkJS5SywXjZWoE1twchhQ@mail.gmail.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 13:59:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3o7a-0005fU-El
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 13:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338Ab1INL7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 07:59:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65363 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab1INL7N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 07:59:13 -0400
Received: by bkbzt4 with SMTP id zt4so1467961bkb.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AEATP1Da0/yetEXOn0/fdlfU9dG/Ac/cwjwtSRvu6gk=;
        b=OHFj99dz2dFyCdIeW3VuYi/3NZmAqXavGdMtni7xkydm6I+AANNWrWV77jlvOaGkmE
         C3HRkaugHPDvenPcOxc3N2cqCQjqMtVNpxLGoje0VDimL6X9To3W8EG8LreHKm9WFbKj
         jMkE4F9Jig9tasxivTicu2p3iSVGHaa1AwY28=
Received: by 10.204.139.6 with SMTP id c6mr1581970bku.391.1316001552252; Wed,
 14 Sep 2011 04:59:12 -0700 (PDT)
Received: by 10.204.7.4 with HTTP; Wed, 14 Sep 2011 04:58:42 -0700 (PDT)
In-Reply-To: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181354>

On Wed, Sep 14, 2011 at 2:45 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> 1. Improved pull requests.
>
> ...
>
> An alternative that I am considering is to let the requester say this
> instead:
>
> =C2=A0 =C2=A0are available in the git repository at:
> =C2=A0 =C2=A0 =C2=A0git://git.kernel.org/pub/flobar.git/ 5738c9c21e53=
356ab5020912116e7f82fd2d428f
>
> without adding the extra line.
>
> That is, to allow fetching the history up to an explicitly named comm=
it
> object. This would only involve a change to fetch-pack at the receivi=
ng
> end; just match the commit object name given from the command line ag=
ainst
> the ls-remote response and ask upload-pack to give the history leadin=
g to
> it. The released versions of Git already will happily oblige, as long=
 as
> the commit object named in the request message still sits at the tip =
of
> the intended branch.
>
> Do you think it is worthwhile to pursue this alternative?

Stupid question, if we agree to go with signed push, can we also sign
pull requests and verify them when we pull? I suppose most of the
time, pulling can be done automatically by extracting pull url from
the request. This would make pull/push both signed.

BTW, there's a third way (rsync is obsolete) to carry changes away in
human-unreadable way: bundles. Should we also sign the bundles too (I
guess we could just do the same as in signed push).
--=20
Duy
