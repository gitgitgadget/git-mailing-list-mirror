From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a commit
Date: Wed, 27 May 2015 12:21:41 -0700
Message-ID: <xmqqsiahltbu.fsf@gitster.dls.corp.google.com>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<c78cd2ac17333a2e70d1113d95495c41@www.dscho.org>
	<1506177855.44397.1432738386768.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq1ti23vva.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 27 21:22:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxgu3-00046q-Fi
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 21:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbbE0TVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 15:21:46 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37504 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbbE0TVn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 15:21:43 -0400
Received: by igbsb11 with SMTP id sb11so22123164igb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 12:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ga9+AnteqCBuP/k6kXAaXqTx+TJwIBpiSREy25S/lh8=;
        b=g+Fe6nvedDvfth9UNcL1Wi4lnW8H2Eh5Ig5pPjXcvCvG2lvQifpGkofX+cxyVWzEBz
         ypLLZPeacgUhyuMeFyu3+o8dpdzX98d5GDSja8CsF9PDFTOoDpvzc0sAPWYMpaJhDqmi
         X2G2WDsZQml+gsZdPiOe5CifF3YyV0qEURZ1LpaEbZpE166U7thK6gXkbY5dioDukhLX
         yc9VAFVylX4+AeUCF/JjUCqDC00nVKgCtB6v3ROXNxHF64Vc2cRxUB3ulsKm3AEFUiJe
         go/aRr7CjIIag9VSuaL7m65Kq2iWSOvsynZTKkpRVxUHjrzn+DnZgj9pJJTegNGvayIi
         Sq9g==
X-Received: by 10.42.67.80 with SMTP id s16mr5294910ici.25.1432754502570;
        Wed, 27 May 2015 12:21:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id 137sm14153518ioo.29.2015.05.27.12.21.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 12:21:41 -0700 (PDT)
In-Reply-To: <vpq1ti23vva.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	27 May 2015 17:04:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270070>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I find it weird to write
>
> noop <sha1> <title>

True, but then it can be spelled

    # <sha1> <title>

too, so do we still want 'drop'?  Unless we have a strong reason to
believe migrants from Hg cannot be (re)trained, personally, I'd feel
that we do not need this 'drop' thing.
