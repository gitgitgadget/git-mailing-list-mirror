From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Support empty blob in fsck --lost-found
Date: Sun, 11 Sep 2011 18:21:31 +0200
Message-ID: <CAGdFq_iLnCtXWJsiYLatzyi3bjz1drv1kmM54y8mMkNaU8b33A@mail.gmail.com>
References: <A3964281-B24B-46C0-AE73-0CCB4C12556F@bjhargrave.com>
 <CAGdFq_hqfqdFyLY=KdA_QW5kH8Kjhx8Y18mHEga_Pdv8yzB2wg@mail.gmail.com> <E6A02216-CA67-4B66-AA8F-6DDE8AF7DF3A@bjhargrave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: BJ Hargrave <bj@bjhargrave.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 18:22:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2mnQ-0001Tq-BP
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 18:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab1IKQWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 12:22:12 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34175 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962Ab1IKQWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 12:22:11 -0400
Received: by pzk37 with SMTP id 37so5494740pzk.1
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oqwc03LToQgtna7qA5ovJ1MBJFZxiC82Zsat9WOiLHQ=;
        b=WWRQTKTyo8oKan8U1TkjX1BtYyt6aOWf1YyFZeJWFWva/xT9uEcs8YhN2TSCBrw1/B
         /SnPRnFBnD8DCSfeCZSANLZNBi2TOmzlhn3K7qfKR6WNN0AURMqEUhaud7NMdv94Y2nL
         W8Qv3S/bJ6qA1qkVM4hPfQEccx1kMm2wKBpso=
Received: by 10.68.22.201 with SMTP id g9mr697892pbf.433.1315758131059; Sun,
 11 Sep 2011 09:22:11 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Sun, 11 Sep 2011 09:21:31 -0700 (PDT)
In-Reply-To: <E6A02216-CA67-4B66-AA8F-6DDE8AF7DF3A@bjhargrave.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181179>

Heya,

On Sun, Sep 11, 2011 at 18:20, BJ Hargrave <bj@bjhargrave.com> wrote:
> You don't need to write anything to the 0-byte file. Just create it and
>  close it and there are checks already that verify the fopen and fclose
> do not fail. So I don't think we are missing any error conditions here.

Works for me :).

-- 
Cheers,

Sverre Rabbelier
