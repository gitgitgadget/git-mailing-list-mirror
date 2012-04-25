From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] i18n: bundle: mark strings for translation
Date: Wed, 25 Apr 2012 15:43:41 -0700
Message-ID: <xmqqipgnbffm.fsf@junio.mtv.corp.google.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
	<1335184230-8870-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 00:43:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNAw8-0006es-Cy
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 00:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354Ab2DYWnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 18:43:43 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:60832 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274Ab2DYWnn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2012 18:43:43 -0400
Received: by qcsp5 with SMTP id p5so83894qcs.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 15:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=J8VVukRyppvpfgl/gfaVKGQcfqKPNMy39fsviCA+aD4=;
        b=EtgvEI3fiIAq/1SEigS2PSYHAbOfxUMGFjLJyXFI5VIPqTrPbO/FO6Wa99SZSwzXaE
         AmvBIRzy+WOXTwLqyyfZlxuSGLgYnU+gp8XedD2RS2n20/o3ESEkGkWNcc0ah7Y6XtSz
         cTEb2HanOg8eyi8ewOXAbofZEPSjZEWqZbZspoVGQdQid4DvhaKI4DYK+LQmo5usEBFL
         1J6Lim4EPNOjp5TxAwR6ChXnQLWsMOCorck1yBB/jlB4tBYPFkQ4zFPFLEJ8IBlG+g15
         TbcigDPvPMZgEyfA08tiT7EIkcGNzXp6B2+C4d509TX2Kv3kQWV+Xjou8rTINxwq+SEW
         kGaA==
Received: by 10.236.153.5 with SMTP id e5mr5524937yhk.5.1335393822251;
        Wed, 25 Apr 2012 15:43:42 -0700 (PDT)
Received: by 10.236.153.5 with SMTP id e5mr5524907yhk.5.1335393822164;
        Wed, 25 Apr 2012 15:43:42 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id b69si1056336yhe.0.2012.04.25.15.43.42
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 15:43:42 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 12BE21E077E;
	Wed, 25 Apr 2012 15:43:42 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id B5C93E125C; Wed, 25 Apr 2012 15:43:41 -0700 (PDT)
In-Reply-To: <1335184230-8870-11-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 23
 Apr 2012 19:30:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQn9AkAmyJvpSqTnYmFYb372ZigQEPYXiobp7qYGvPfBN9Kez2/32fIFDJrFCiyW1c+/oz2L+HxAhcFBtwxYrmhXds4uanFb/DUqw1gyYanUnNXu3F8+lf3RVt5OYhqwLf4jRd339RN/dwCaQ7B9AMuf21kEtBF20FOCCUhSl67oDFovVrs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196343>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -283,13 +287,13 @@ int create_bundle(struct bundle_header *header,=
 const char *path,
>  	strbuf_release(&buf);
>  	fclose(rls_fout);
>  	if (finish_command(&rls))
> -		return error("rev-list died");
> +		return error(_("rev-list died"));
> =20
>  	/* write references */
>  	argc =3D setup_revisions(argc, argv, &revs, NULL);
> =20
>  	if (argc > 1)
> -		return error("unrecognized argument: %s'", argv[1]);
> +		return error(_("unrecognized argument: %s'"), argv[1]);

This is a problem in the original but we see an unmatched sq here.
