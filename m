From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [PATCH] builtin-merge: fix a typo in an error message
Date: Mon, 13 Apr 2009 17:41:15 -0400
Message-ID: <b2e43f8f0904131441j4d808431mc2c87531221c8f4d@mail.gmail.com>
References: <20090413181008.GA8273@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 23:42:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtTvX-0000lu-C1
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 23:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbZDMVlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 17:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbZDMVlR
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 17:41:17 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:42394 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbZDMVlQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 17:41:16 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2605876qwh.37
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=AoCjl8OZUoNXSHQcJK6avO/8/cxOqKEY23rNee7pjc8=;
        b=qHzrKshipMZDxffdzTWX9zwR3fxI837ui0Wx2egC3nrdtwHKeuO3z/EpF9+JwihIYR
         q1NK4pXCZ6ruqSLJjpz/Jxkto2JGv88OlfK3qj2RgEfrslJvyeZ+QlOn0Nd88RIb4Qwq
         HUepa/MpLrGMyk6LyoyK5yV79lFL3NDTRrSdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=pC3L9sC1AGiK0unJ1rKis5wOFXn08jBNdeKB10caS5/tIBpVg2zRD52ZL+imjuGFjZ
         dHlxBV7OlBRa7MiAzORmUJMA9qQvFCSf0vmJYj3zZiLs71KDr7efeKGTgtDajVAySDOj
         lTxlNBrumaqommUTLXbr3hIimJhfKg7E4wnac=
Received: by 10.220.90.140 with SMTP id i12mr7154642vcm.22.1239658875609; Mon, 
	13 Apr 2009 14:41:15 -0700 (PDT)
In-Reply-To: <20090413181008.GA8273@linux.vnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116490>

On Mon, Apr 13, 2009 at 2:10 PM, Allan Caffee <allan.caffee@gmail.com> =
wrote:
>
> Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
> ---
> =A0builtin-merge.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-merge.c b/builtin-merge.c
> index 6a51823..0b58e5e 100644
> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -764,7 +764,7 @@ static int suggest_conflicts(void)
>
> =A0 =A0 =A0 =A0fp =3D fopen(git_path("MERGE_MSG"), "a");
> =A0 =A0 =A0 =A0if (!fp)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Could open %s for writing", git_pa=
th("MERGE_MSG"));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Could not open %s for writing", gi=
t_path("MERGE_MSG"));

On second thought this commit message should probably read something mo=
re like:

builtin-merge.c: correct error message for failed open

Since the original message is actually wrong.
