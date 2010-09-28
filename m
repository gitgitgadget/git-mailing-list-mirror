From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: implement help target
Date: Tue, 28 Sep 2010 16:04:12 +0000
Message-ID: <AANLkTikx2tL73gJQnqjG7yp3btcZJprKLf0z9QwcAUC1@mail.gmail.com>
References: <4CA1E10F.4080906@op5.se>
	<c16e8df7c8e9b562ce0e6cd6e543a83779cd2b25.1285684868.git.git@drmicha.warpmail.net>
	<7vpqvxubl5.fsf@alter.siamese.dyndns.org>
	<4CA20E24.90509@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 18:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0cfD-0007dt-VG
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 18:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406Ab0I1QEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 12:04:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64324 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab0I1QEN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 12:04:13 -0400
Received: by iwn5 with SMTP id 5so6135599iwn.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=pSGHDEFsktzyfTIKR93ktsbxEujP1A+5R6uR7EfFOMU=;
        b=E0KuVgBjEUXo//+bTlGGnTXpEW5gr6MAEJ4p5xHlfm2T49IOFqpzbSWKV7/s6C93XM
         wGkNzNWDamdUU6dd6+xhlGfdywvVLBZo1BfBilTNdAV1tV6NJz58wA4Tx17BpzAD7hu2
         i7t2UiQ31h7emInjMBNJ9JE8BhfZne+kgK2cA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NSCJxK0NlwoI7ziqXTJmSR2D8zueK5oT2jggKtuCWRp/dhQPlduLwh+pWaLIeoYzNb
         GeFdRxBTH31xw6C2eSvjKvhsLhXXIYu0LbKSX9kyNXlTFlbcgUbCSKiR96srt+M27YtJ
         PB6R8VlfnfkMAksnsawerYSet62KvQp3m5JSI=
Received: by 10.231.11.69 with SMTP id s5mr165878ibs.38.1285689852981; Tue, 28
 Sep 2010 09:04:12 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 28 Sep 2010 09:04:12 -0700 (PDT)
In-Reply-To: <4CA20E24.90509@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157439>

On Tue, Sep 28, 2010 at 15:47, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> If portability is an issue one can work around it - is "grep -A 1"
> portable? I'd also have to get rid of sort --key=2.

No says http://man.cx/grep(1posix)

On the other hand I don't think portability is that important here.

But if you want to make it portable using awk to do most of the work
is probably easiest.
