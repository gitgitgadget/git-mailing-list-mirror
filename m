From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] Introduce CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 18:13:45 +0700
Message-ID: <AANLkTim8m4uBjn_FJ-SWnARkv8rTiM1SrBTBFeg2R_hd@mail.gmail.com>
References: <1297850903-65038-1-git-send-email-jaysoffian@gmail.com> <1297850903-65038-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 12:14:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpfLC-0001DU-BY
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 12:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758746Ab1BPLOT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 06:14:19 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38790 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756808Ab1BPLOR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 06:14:17 -0500
Received: by wwa36 with SMTP id 36so1246740wwa.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 03:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=iXrw/oUi5Q0iHWOWr7L68orQxCvlqPEnYddxU0lFTxc=;
        b=wLx7XvDNz/j9LoP5Wv7a0ygCpngpPM/mT9nvxR4znZK4VjOpm/OGRtHlQTCk+prVZT
         2o+ZfGyn7J0cCqkznKSj6cSO85DrgzDJqVvR3irg2nnBrf/9Mokoo5/NOEUym7S1+Wx+
         wsFJA4MEABdLlqMqUyrYMhpuZ7CNDFkBd3VAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=laCNjSAWexeL8d4TtggPYnR87HUZIsVLQfunBDd9QfqdJyd+LrNYep74kcOJVNQ6Jx
         DYWpjPG1TqPYyzvq4X3RqSxlmeeYAdiO0Bu9QgHFeMvD85M/yNw1yOMTA8kWTeUGqqe1
         5W+0vZyCKFW1oUYAps0hvXpUBAY5ZqDuP9TUU=
Received: by 10.216.163.69 with SMTP id z47mr362246wek.43.1297854855757; Wed,
 16 Feb 2011 03:14:15 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Wed, 16 Feb 2011 03:13:45 -0800 (PST)
In-Reply-To: <1297850903-65038-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166960>

On Wed, Feb 16, 2011 at 5:08 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> When a cherry-pick conflicts git advises to use:
>
> =C2=A0$ git commit -c <original commit id>
>
> to preserve the original commit message and authorship. Instead, let'=
s
> record the original commit id in CHERRY_PICK_HEAD and advise to use:
>
> =C2=A0$ git commit -c CHERRY_PICK_HEAD

Wouldn't it be more convenient to do "git cherry-pick --continue"
instead of "git commit -c CHERRY_PICK_HEAD"?
--=20
Duy
