From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] dt/untracked-subdir
Date: Wed, 19 Aug 2015 10:47:54 -0700
Message-ID: <xmqq37zfb25x.fsf@gitster.dls.corp.google.com>
References: <1439702227-15453-1-git-send-email-dturner@twopensource.com>
	<1439989286-24355-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 19:48:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS7Sz-0004e7-NI
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 19:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbbHSRr5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2015 13:47:57 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33117 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbbHSRr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 13:47:56 -0400
Received: by padfo6 with SMTP id fo6so1667918pad.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=UhJrhpbjMcwNs7QxLuLw6K+celFm8E1FyFEbXFlexEk=;
        b=0UU2DO6ErU+Fcky+1Tfe0p0HZOPjtUjW/r9mgLKwN/II7L4qCjDwfojh2KZWcffbd/
         4UTgzFw1Um5bPzJ0J/qlE9/bG4qZB64Ppxtz3Vi73J7FD+sa+5jfsi+kf6pCkWM+Vggf
         4LLGF4yXWMOzyWl5QGpKRhUQ6zFuubhEADybzEUlws1tDyp9mhiLQzQD+ywbb9VbpCdY
         QoiqaS/gxivdgoWyH9fqLMR2KNEWZjQ56tmSqHIKonvUMHoA8taRea5Ll/x0r2N6X2mi
         Kg/pp4cdRS3ptBlouK9lZVVH7zPJx3ny94LbsJA8dlEMEPdiTkU/DForDXZDc9omSxZa
         77Ng==
X-Received: by 10.66.55.66 with SMTP id q2mr27093922pap.94.1440006476256;
        Wed, 19 Aug 2015 10:47:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a5d7:91a5:eac5:b635])
        by smtp.gmail.com with ESMTPSA id bu1sm1582429pdb.35.2015.08.19.10.47.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Aug 2015 10:47:55 -0700 (PDT)
In-Reply-To: <1439989286-24355-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 19
 Aug 2015 20:01:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276205>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The first patch is a split from David's v3 patch because it should
> belong to dt/untracked-sparse. The second is basically David's v3.
> The third patch fixes untracked_cache_invalidate_path(). David fixed
> it in v2, but there's another bug in this code.
>
> David Turner (1):
>   untracked-cache: fix subdirectory handling
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
>   t7063: use --force-untracked-cache to speed up a bit
>   untracked cache: fix entry invalidation
>
>  dir.c                             |  82 +++++++++++++++++++++++-----=
--
>  t/t7063-status-untracked-cache.sh | 102 ++++++++++++++++++++++++++++=
++++++++--
>  2 files changed, 163 insertions(+), 21 deletions(-)

They all look reasonable.  Will replace v3 with these and wait a bit
to give chance to David and others to comment.

Thanks.
