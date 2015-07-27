From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git branch command is incompatible with bash
Date: Mon, 27 Jul 2015 14:49:20 -0700
Message-ID: <xmqqh9opgtjz.fsf@gitster.dls.corp.google.com>
References: <20150727121253.GC17338@2vizcon.com> <55B69E68.90306@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Anatol Rudolph <a.rudolph@2vizcon.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jul 27 23:49:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJqH6-000771-Mk
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 23:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbbG0Vt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 17:49:28 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33076 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbbG0Vt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 17:49:27 -0400
Received: by pdbnt7 with SMTP id nt7so58330334pdb.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 14:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fHaQpiZjtAk+HqluqTjHmAD69ul9r37XtN7AanMGhwA=;
        b=L2nTIV5penXyIVuihBNxz7to0ZuHrKJucXBmxkaxMePzdsJgWdJzg6HQN8/nqeMHt5
         L1QvpcAwmByUkuumM29jJ573Xyt8Zz4hzB9vxWdILa8gBcMHH3gfv/ZqjhQy3p2+dHIf
         FmkFRBK0te2LBKd5gnbtBKT6Iyh/WoG7aMQkpPxJKIRyskSZvmxWIfD+eFOs2Kum3Zo5
         PqVcnbsYyi1ZGT9kj/uZ03NAMo/EAQRhwN1Yf3JaW4mXx24Xm3kMxSQse0OyOy5FfoZz
         sTpsiX6tnu7aMDvp9oApZj1wqbHjTCvYe4Sty4z/Z3tUHDGDsqf1g3Jg4fB5YFYNSzPS
         0uLg==
X-Received: by 10.70.134.163 with SMTP id pl3mr71811342pdb.142.1438033766939;
        Mon, 27 Jul 2015 14:49:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2496:725d:b368:d039])
        by smtp.gmail.com with ESMTPSA id z7sm30105127pas.39.2015.07.27.14.49.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 14:49:25 -0700 (PDT)
In-Reply-To: <55B69E68.90306@kdbg.org> (Johannes Sixt's message of "Mon, 27
	Jul 2015 23:11:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274715>

Johannes Sixt <j6t@kdbg.org> writes:

> Try
>
>   branchName=$(git rev-parse --abbrev-ref HEAD)

Hmm, interesting.

    $ git checkout --orphan notyet
    $ git rev-parse --abbrev-ref HEAD
    $ git symbolic-ref --short HEAD
