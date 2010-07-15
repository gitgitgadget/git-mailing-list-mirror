From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/2] non-incremental mode for fast-export
Date: Wed, 14 Jul 2010 21:44:36 -0500
Message-ID: <AANLkTilpIlOaupzzSdLWxjE3PAsZg9J9UB9_pM12H8wE@mail.gmail.com>
References: <1278535562-14875-1-git-send-email-newren@gmail.com> 
	<AANLkTim9CU-2CNz8lUbKiKXHHICugMhts_1aIDP2_81g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 04:45:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZERd-00022d-0d
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 04:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175Ab0GOCo5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 22:44:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60552 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128Ab0GOCo5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 22:44:57 -0400
Received: by gyh4 with SMTP id 4so351202gyh.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 19:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dUKzSU0hIJkWHvf8263HPZc3Wsy3LSfTCTrkSMRoopw=;
        b=W4rE+fKBjghrhJi8UXLivnceVs1wT0ISRM/cEb2x7RF4i7VMuYI3LSNNcGSu3h0kjW
         Dg67AhiyE92cXXtbttOeAsZ3Li2OEaDJSpWoXozro38moEEZvPT+cB27E4y3O90N+eVB
         VTUQqEY9J0FZD09oi75uN7nxqg0M4hx+3pUOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SxkaeKlGTLZf1HicAJWICCWl2w9Aj47ugZhRVVJtdnUUx+1m41o4Go/05yGZqH6E9g
         55coduxcCCRc6iL97YvKM1/Z9IyhUeDCcVCfyN4mTehS9N+OSvpSbyXxlbvN+gj8ob3v
         VLCWCNfSoR0lTnCpqWnZ6kg4xLbED9gM3KGdc=
Received: by 10.151.24.12 with SMTP id b12mr273732ybj.180.1279161896086; Wed, 
	14 Jul 2010 19:44:56 -0700 (PDT)
Received: by 10.150.93.19 with HTTP; Wed, 14 Jul 2010 19:44:36 -0700 (PDT)
In-Reply-To: <AANLkTim9CU-2CNz8lUbKiKXHHICugMhts_1aIDP2_81g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151046>

Heya,

On Wed, Jul 14, 2010 at 20:03, Elijah Newren <newren@gmail.com> wrote:
> Hmm..no comments. =C2=A0Am I (and others at my $dayjob) unique enough=
 in
> our combination of options we use that no one else ever runs into thi=
s
> mangling of exported repositories?

The first patch makes sense to me and should probably go into maint.
The second one is so trivial that even if you are the only user of it
I can see no reason _not_ to include it. So even if I'm not exactly an
expert on fast-export, I think I know enough of fast-import to be able
to say this should be merged :).

--=20
Cheers,

Sverre Rabbelier
