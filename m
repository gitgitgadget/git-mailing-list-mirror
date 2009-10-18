From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Sun, 18 Oct 2009 14:40:21 +0200
Message-ID: <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
	 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
	 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 14:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzV3k-0001lx-OO
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 14:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408AbZJRMkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 08:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754305AbZJRMkS
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 08:40:18 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:51377 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbZJRMkS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2009 08:40:18 -0400
Received: by fxm18 with SMTP id 18so4032879fxm.37
        for <git@vger.kernel.org>; Sun, 18 Oct 2009 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A+WOiaoSiMq+C4aRqRMgbeE/nwEtnXJC+ecfl1FmCow=;
        b=OrgHQnwTZnPgB7Rl7HeY6rlhFzq89m3U2Npr8dN0diZLGChtYIFI8Oa2nABf1H04I5
         4WDOertQEoGLvKvVbkeo5CCLNNt+1BcOCs6iL2PxjQvt5dXyB2mqJgqmmIKV89He24mK
         rZZaAp7chJ3AE3+4QJF5CTOS1VlqgV4/ZEe6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oX31G6LJwEsyXZweNaS0u3ismn8NMKGQ/JufNfdVq/td3xbAw7zke9/AldPrF86K0p
         TA4On/HbLhd5MO5Tk/D/93nGnj/EcmbGTjLPhq65U/XDGI2q4/32wRIbY6KTSbiqUtG6
         Ol29HvpsJS9mSQ2YGmBSQ7QptPn/BcCMhWqIA=
Received: by 10.204.36.202 with SMTP id u10mr3588545bkd.196.1255869621779; 
	Sun, 18 Oct 2009 05:40:21 -0700 (PDT)
In-Reply-To: <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130594>

On Sun, Oct 18, 2009 at 10:01, Junio C Hamano <gitster@pobox.com> wrote=
:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_SET_INT(0, "no=
dwim", &dwim_new_local_branch,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "do not dwim local branch creation", 0),

Isn't there a special negation support for --no-something in parse-opti=
ons?
