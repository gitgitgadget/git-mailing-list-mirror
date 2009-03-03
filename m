From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v3] send-email: add --confirm option and configuration 
	setting
Date: Tue, 3 Mar 2009 12:54:24 +0100
Message-ID: <36ca99e90903030354j33de0313n41d8a95ff898798b@mail.gmail.com>
References: <7v1vtfjpad.fsf@gitster.siamese.dyndns.org>
	 <1236055938-65407-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeTE1-0001GU-9M
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 12:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757986AbZCCLy2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 06:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbZCCLy2
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 06:54:28 -0500
Received: from mail-ew0-f177.google.com ([209.85.219.177]:59296 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbZCCLy1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 06:54:27 -0500
Received: by ewy25 with SMTP id 25so2293068ewy.37
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 03:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=53bnySFwhZ89FCJFDjybOK4CUtj8T8t7PsvTOHTmIns=;
        b=KMXVKUNsgTbHyPPzwzyWbr28pNuQGB/KJz4CVb1O2hyu6y3Fhhx80AraTtO6nLdO6M
         MnJPu7ggzr7ZQt0GySM5Xv3fSp2+avAOSq+MVXDmH2Rvcw6A9SZvo5p8a+JXyc/9Ef4Y
         CJLURtBtll7+IBQP+7XGXrnrG5j6GO/SdvOIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CAmRFAoIeKlv8s5ET82jcvIlCtNr6BckWLGCEh9mNVKfc8iQLVaR72bbTz+jRM0Xsa
         2J8taa63p4YYBi72M4Ckm0WwmrtLLP0i+J1RGkw2DlQd1hca5+WQi+JDwCHqNKiDcJNf
         gBuf0p4v23kPfwpiHECw73dlXyV7YEfziFeAk=
Received: by 10.210.37.16 with SMTP id k16mr4155162ebk.0.1236081264708; Tue, 
	03 Mar 2009 03:54:24 -0800 (PST)
In-Reply-To: <1236055938-65407-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112060>

On Tue, Mar 3, 2009 at 05:52, Jay Soffian <jaysoffian@gmail.com> wrote:
> diff --git a/git-send-email.perl b/git-send-email.perl
> index adf7ecb..57127aa 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -837,6 +837,37 @@ X-Mailer: git-send-email $gitversion
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unshift (@sendmail_parameters,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0'-f', $raw_from) if(defined $envelope_sender);
>
> + =C2=A0 =C2=A0 =C2=A0 if ($needs_confirm && !$dry_run) {
So, the output is now differnt with and without --dry-run?

Bert
