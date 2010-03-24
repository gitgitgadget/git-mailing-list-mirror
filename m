From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: color (red) for error messages on all git commands
Date: Wed, 24 Mar 2010 23:58:31 +0100
Message-ID: <fabb9a1e1003241558t4c4c5cf8t3a7d9b9856937c4f@mail.gmail.com>
References: <hoe4j3$2vg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 23:58:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuZXO-00069C-JK
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 23:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976Ab0CXW6x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 18:58:53 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:43682 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab0CXW6w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 18:58:52 -0400
Received: by bwz1 with SMTP id 1so406149bwz.21
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 15:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Jt4HGt2E3A5yp19jYZbrP/Cuhm0hvLLo3dokpZZHHGc=;
        b=OmYnSH/8Xx7FnYo60g7ERdfINvMLTZz8f1GdEeQMvOoTEGGi29Z/schNcTxz8hgT6t
         QJbonfv5oXYVSKVmgMjeVWc5OJopC41oASbArxHrP/TTQgqM6EjkCEadG3qxN3WA5KEo
         yqvLLSS5JFmb3v4xiIabyibtBuj6dvXgo3/kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NmkR5hPB/3Bijd0Q6NL2K/gBPzcFFZPCgljQ29KekmkFMSwB++RGJSWW9unui+tlBm
         cLD588gfFuDRZSjr0xCTZsqKu/zHY0cbHM/S1MhhlN6vvCTAmsNEmO11K88vTR2hO/yx
         wjuOEJDaOs4qW/ngQSG4kAkg7IeaK9c394R6A=
Received: by 10.204.36.71 with SMTP id s7mr6552955bkd.171.1269471531140; Wed, 
	24 Mar 2010 15:58:51 -0700 (PDT)
In-Reply-To: <hoe4j3$2vg$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143135>

Heya,

On Wed, Mar 24, 2010 at 23:44, Neal Kreitzinger <neal@rsss.com> wrote:
> Problem Scenario: =A0programmer doesn't pay attention to messages as =
he
> becomes more familiar with git and as a result doesn't notice error m=
essages
> until its too late. =A0Mistakes take longer to remediate because the =
original
> error message was not resolved at the time it occurred.
>
> Desired Solution: =A0configure git to display all error messages in c=
olor,
> e.g. red, so that the programmer does not overlook error messages.

That's actually something I run into as well, I am so used to git just
doing what I want that I don't notice the error messages when they
occur. If this is indeed desired (probably controlled by color.warning
and color.error?) it should be fairly easy to implement (see usage.c).

--=20
Cheers,

Sverre Rabbelier
