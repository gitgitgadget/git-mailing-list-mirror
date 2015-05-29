From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] send-email: allow multiple emails using --cc --to and --bcc
Date: Fri, 29 May 2015 09:13:06 -0700
Message-ID: <xmqqa8wne50t.fsf@gitster.dls.corp.google.com>
References: <1432809733-4321-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<xmqq382giokd.fsf@gitster.dls.corp.google.com>
	<87oal32wuj.fsf@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 29 18:13:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyMuI-0006he-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 18:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbbE2QNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 12:13:11 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34605 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349AbbE2QNI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 12:13:08 -0400
Received: by ieczm2 with SMTP id zm2so66569085iec.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/NWQXLlfJdrEIBDU4IO9WMb4/aJbXcTsu0LmxwcSmbI=;
        b=fkVmQsyN9oO6OAr8qfVm4/dXfEaWhgSN3mNPO0fBDo9xo5eXZhr8zhraoTupSLWRhm
         J1HxudqAN3ZSw5YFt4BwkHPD46gVb1EpXWgZ2NnVYue1Npj23vjoj8TuMVHnZCerQVXy
         vrwtvKoebgoLV3MbzuOeZAL37bZG5aVvDgkW+CK3dQcYjEH6hMsdKoUrAQ8Km+r6XSH2
         dvb7Szd6nGMxbZEGv8asCQWhAHT1X6lHrZpc/kNhGXY50k6iKAGbjgZktKGFD9c/pltw
         4HVuKRps3NWie8oHXFe1K3Ik+sT1WVRONX7v1LEKgCtm0995UUChUzoVi8AaPbSij17C
         70xA==
X-Received: by 10.50.132.33 with SMTP id or1mr5049758igb.31.1432915988350;
        Fri, 29 May 2015 09:13:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id h128sm4463721ioh.38.2015.05.29.09.13.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 09:13:07 -0700 (PDT)
In-Reply-To: <87oal32wuj.fsf@ensimag.grenoble-inp.fr> (Remi LESPINET's message
	of "Fri, 29 May 2015 18:05:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270253>

Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> Yes, that works if Foo is in an alias file, so that's clearly a bad
> example, I added quotes:
>
> 	git send-email --to='"Foo, Bar" <foobar@example.com>'

I'd further suggest replacing ", Bar" with something a bit more
realistic that people use in real life, e.g. ", Esq." or ", PhD"
(e.g. "Jane Doe, Esq.")
