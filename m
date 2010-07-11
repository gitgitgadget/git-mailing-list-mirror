From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH] diff.c: fix a graph output bug
Date: Sun, 11 Jul 2010 14:10:20 +0800
Message-ID: <AANLkTimfQ3ZBCdz0aeDdpsWvcLrG-AxWoLYGCoa8zLi4@mail.gmail.com>
References: <4c35eb6c.21078e0a.1455.ffffe42d@mx.google.com>
	<7vhbk9o6ie.fsf@alter.siamese.dyndns.org>
	<7v1vbdo4j5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 08:10:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXpkO-0007xZ-7Y
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab0GKGK0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jul 2010 02:10:26 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:35761 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab0GKGKW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jul 2010 02:10:22 -0400
Received: by qyk35 with SMTP id 35so1031893qyk.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VZD5PBsm8pW5KsUAwadqJcIvh8IU0vtR8Dk1vdBs7Lg=;
        b=ZN1o9JvGs/uj2CQmuWar+1INx+VichGnUDbbZvrCm+wZXbG2pHVZRahAFP76TrIdCL
         vpj4lY/fWRPNZj5+v65K0lynfhejFIZYj0rJ5OUobO+7ouwb9H4haz2muUPhn9IXI1DM
         DzaLfAzhH7pVD58nAGwqdXxV97BUW2IDf5kEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fPU6RWBOC37XTGVddgvDEdau+zVoq+1pVyfkkBzIWvxJfphhDdaowDy+8G1qV6hVKU
         eu/aMxDVDwgP+cX9PV8pzjyNZRfendyNMwtGamsT3VBbZnQLUAnZngKWT+FPep4QNaOU
         BMbVZRVWAMFeSNQTkb3Ad6uWM3/4mVIKRozoY=
Received: by 10.229.79.80 with SMTP id o16mr7447381qck.282.1278828620332; Sat, 
	10 Jul 2010 23:10:20 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Sat, 10 Jul 2010 23:10:20 -0700 (PDT)
In-Reply-To: <7v1vbdo4j5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150743>

Hi Junio,

On Fri, Jul 9, 2010 at 8:57 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Perhaps something like this?
>
> From: Bo Yang <struggleyb.nku@gmail.com>
> Date: Thu, 8 Jul 2010 23:12:34 +0800
> Subject: [PATCH] diff.c: fix a graph output bug
>
> When --graph is in effect, the line-prefix typically has colored grap=
h
> line segments and ends with reset. =A0The color sequence "set" given =
to
> this function is for showing the metainfo part of the patch text and
> (1) it should not be applied to the graph lines, and (2) it will be
> reset at the end of line_prefix so it won't be effect anyway.
>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =A0diff.c | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
> =A0...
>

Hmm, your description is great, thanks a lot! And please apply this
patch, thanks!

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
