From: Richard Peterson <bigtheta@gmail.com>
Subject: Re: Is there a debug mode for git-clone https traffic?
Date: Tue, 17 May 2011 21:38:39 -0400
Message-ID: <-3808464152500901395@unknownmsgid>
References: <BANLkTi=-i063MqrboT1MHrQy-vM0yBTUGg@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 8C148)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 03:39:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMVjn-0003NV-Q3
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 03:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724Ab1ERBjn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2011 21:39:43 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44094 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932720Ab1ERBjm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 21:39:42 -0400
Received: by yxs7 with SMTP id 7so386198yxs.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 18:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:references:from:in-reply-to:mime-version:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Wr8zEtJKUm1wE493ZXDvTpL6KQA1UThiV6cOXZ4ZWvM=;
        b=ZlEDPhe9zfGrfWSV/3GGTHpr03XjjN8XxCp0Lm3mojbmkyKyzbvKwrjm2SyIjeuccO
         MZRSRPtn1vL7YlrgUBvqeBX1wINeDjPMZ1bwwit5W3hPFF/oZuLhTSrYBbSw+pba5vAD
         SL9R0ip7GgUgSReaBaIejLV71MiBpYvZS+xf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:from:in-reply-to:mime-version:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qYV7h+Ac2+J1zsC7AKDTs5QMPdXltqkQVAmKOCFK7AWI59XJr8Y3mE/WztRGamaItp
         B7Sd/r3+9OZMlleYRYRA4H0njjQiU1pCcs+26M5Qz2XH9Sa9hv+sOBW8gj8R768jzFnG
         IhTQedSBh5gtItqN7QTR+hEjYOFQGgPXYqd4c=
Received: by 10.150.13.7 with SMTP id 7mr967582ybm.201.1305682782123; Tue, 17
 May 2011 18:39:42 -0700 (PDT)
In-Reply-To: <BANLkTi=-i063MqrboT1MHrQy-vM0yBTUGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173837>

On May 17, 2011, at 19:08, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.=
com> wrote:

> I''m trying to debug a problem where over a https proxy I have
> "warning: remote HEAD refers to nonexistent ref, unable to checkout."
> when doing git-clone.

Last time I ran into that error, I was cloning from a bundle where the
remote head was simply not in the bundle. The branches I needed were
all there. Running "git branch -a" and then checking out one of the
existent branches worked fine.

Not sure if that's related to your situation at all.

Richard
