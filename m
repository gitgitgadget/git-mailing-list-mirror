From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 2/8] git_remote_helpers: fix input when running under
 Python 3
Date: Wed, 23 Jan 2013 12:14:46 -0800
Message-ID: <CAGdFq_jZDUxg7oTL7Z4v5ezYFPfJ8kZR6iHpESw6WnoDCeAy8w@mail.gmail.com>
References: <cover.1358686905.git.john@keeping.me.uk> <7cd489e5b1b2578b1509232196cd6b21fd684843.1358686905.git.john@keeping.me.uk>
 <CAGdFq_jp3BrS0zgDpmiXGduwu_m4E2CCL+X32P-7T=z9Qk-wuQ@mail.gmail.com> <20130123194757.GQ7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 21:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty6jg-00074L-RY
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 21:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab3AWUPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 15:15:31 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:44973 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab3AWUPa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 15:15:30 -0500
Received: by mail-qc0-f172.google.com with SMTP id b25so3703362qca.17
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 12:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=xXm4YPXrL2r1/U6t3Uvu7W2xx5QKPnVjYymTjelzz7g=;
        b=IXb2c8wK9KsBKOqWD2SZyIjYwM9M/pnNIrN5c/2n6T8W6pyXwbdNNGNrhCn0hvnQf6
         V7kt36RNRXaQuhL3Ib+o/s5lkeM4+JG3q/tXLgAoXUcjQJxWj5lIbowv7PNSnaE+9R8f
         0xBO/44avkPzdJFAuGW0aG+P9AFXuZgjDXp2aNtxhcIzY9ehcNax4hGdF+RGDTEM3X9b
         ar/f13VncEcmq7aNAf7C3iG+jGczCsqu8h1STSY0a+CsUEnfy44G8+vqvoBU/tlOnPja
         XSx0iGNghgPCuOIjly7dMYbJQEyKO4ueXI3iqJCqQ4zBF8p8HorwYN0/84bnexy3aofM
         aDEw==
X-Received: by 10.224.116.133 with SMTP id m5mr3168355qaq.32.1358972127148;
 Wed, 23 Jan 2013 12:15:27 -0800 (PST)
Received: by 10.49.51.227 with HTTP; Wed, 23 Jan 2013 12:14:46 -0800 (PST)
In-Reply-To: <20130123194757.GQ7498@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214356>

On Wed, Jan 23, 2013 at 11:47 AM, John Keeping <john@keeping.me.uk> wrote:
>> When did we last revisit what minimal python version we are ok with requiring?
>
> I was wondering if people would weigh in discussing that in response to
> [1] but no one has commented on that part of it.  As another datapoint,
> Brandon Casey was suggesting patching git-p4.py to support Python 2.4
> [2].
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/213920
> [2] http://article.gmane.org/gmane.comp.version-control.git/214048

I for one would be happy to kill off support for anything older than
2.6 (which had it's latest release on October 1st, 2008).

Junio, how have we decided in the past which version of x to support?

--
Cheers,

Sverre Rabbelier
