From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add column layout skeleton and git-column
Date: Fri, 20 Apr 2012 21:18:12 -0700
Message-ID: <xmqqlilpzpiz.fsf@junio.mtv.corp.google.com>
References: <7v4nsjy85r.fsf@alter.siamese.dyndns.org>
	<1334977648-872-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 06:18:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLRmY-0001C5-Ka
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 06:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821Ab2DUESO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Apr 2012 00:18:14 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:65319 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab2DUESN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2012 00:18:13 -0400
Received: by qabg24 with SMTP id g24so134966qab.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 21:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=8K1wcxCZ3Eu+QiJ+Ax92iMeIU+yeIiitAmXUvRck5Go=;
        b=bo1r8ZAc62OiNyMIBWWf01m02Gf0D0Vb81nU91DRTPThXTmpj6Sk3uwu6NxLnOL4XD
         h+dufMTbO2J5aQVBmmvREue0uZyzptqMAouUgLib4JxF51xi2crqtPZTZmVEK6L/AtYl
         f9KPu6KGeRoGQf1bfBormu0/GSPlaPU3f3HWxEUDQjmjmgnmfR6XHnqaNcUEtd9FUjfK
         Q38doJA1r+n54ZIJfgRxk6lYcxMSO886YsJJ6RJ7O+IfJ01b+Lh3Fs+s3mJ2G7HmDadL
         HrNc1fJqzSB+6H9OhgIaKHZ5oXd0QKmAD38JC3hOpMopQFTlN3dS5QIUbn/suQinfZe2
         GBrQ==
Received: by 10.101.151.23 with SMTP id d23mr3155914ano.11.1334981892931;
        Fri, 20 Apr 2012 21:18:12 -0700 (PDT)
Received: by 10.101.151.23 with SMTP id d23mr3155903ano.11.1334981892820;
        Fri, 20 Apr 2012 21:18:12 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id k54si7392944yhh.5.2012.04.20.21.18.12
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 20 Apr 2012 21:18:12 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id B400C1E004D;
	Fri, 20 Apr 2012 21:18:12 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 5D9ABE120A; Fri, 20 Apr 2012 21:18:12 -0700 (PDT)
In-Reply-To: <1334977648-872-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpCU5n4buNYw==?= Duy"'s message of "Sat, 21
 Apr 2012 10:07:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmCTAjwWJ52Zv2C67hofuTMWSWe7GsJFar2ZvXX0ZBZH+KT/wK7bo6z5CFPt28YLq+YrXXas0zsb5MGR/8EDGwzITeK85ITizAfigk1uIcgoEdwQaML/BXSOiFl0iCsMlFOsOSDU4vTRuEDyBcTKJzyOJ4PVuDr3E8YTL6bvG4f0p1IxxY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196038>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  Thanks. I'll go with the simple way: error out.

OK.

> diff --git a/column.c b/column.c
> new file mode 100644
> index 0000000..416a440
> --- /dev/null
> +++ b/column.c
> @@ -0,0 +1,169 @@
> +#include "cache.h"
> +#include "column.h"
> +#include "string-list.h"
> +#include "parse-options.h"
> +
> +/* Display without layout when not enabled */
> +static void display_plain(const struct string_list *list,
> +			  const char *indent, const char *nl)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < list->nr; i++)
> +		printf("%s%s%s", indent, list->items[i].string, nl);
> +}
> +
> +void print_columns(const struct string_list *list, unsigned int colo=
pts,
> +		   const struct column_options *opts)
> +{
> +	struct column_options nopts;
> +
> +	if (!list->nr)
> +		return;
> +	assert(COL_ENABLE(colopts) !=3D COL_AUTO);

Am I looking at the correct version?  Somehow I thought you eliminated
this confusingly named macro in the previous round.  Two steps forward,
one step backward???
