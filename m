From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH try2 09/14] apply: add --stage option
Date: Sun, 13 Oct 2013 19:19:21 +0900
Message-ID: <CADCnXoaeF9Avjy08C_eJN3YJAMbGZXh6mkKjj4sgfaED=b_GnA@mail.gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
 <1381561488-20294-7-git-send-email-felipe.contreras@gmail.com> <CAPig+cSmVKK_onR8NtLkdahkFci77SCsU6PagyJEBYLo4xZBUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Oct 13 12:20:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVImQ-00077H-Ri
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 12:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab3JMKUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 06:20:05 -0400
Received: from mail-qe0-f45.google.com ([209.85.128.45]:43809 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113Ab3JMKUD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 06:20:03 -0400
Received: by mail-qe0-f45.google.com with SMTP id 8so4576196qea.32
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 03:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=M1QBFP+sLfijxOZ/tRYRUeo91Jk1B83OKjh/uMrGXEI=;
        b=CjtEDg8vaG11J1Aj3ANPcvdeCrN3I2S0W7GvGXRu/ko8X24u2l9AP2RrZMhU14a20J
         sEJIMEwcKBVIWQPi2lYQhjBtHTS+bT+1ojkXv3gwX2pKMt5I82V9uPq0PVAL/THZQ3Od
         TQym2Ycn274fRA1yXEx3PE1HuoG5i2hv1Ft+EkpRd08Q5rfd5d1/VjiIzcASO9hbTNR5
         IEC92Gf1r0Ro1XJlmODGXWQ/sslGZ8UgHo+EqInuaHVJVxhQCsTWeR7/EOQiad9T6fTM
         O3k16HZ874Vru5b9k5+8Mf8/UeQlaJRPmunD/c2zVGFHJfqPGKXvA4jmj/kxM9AbjxSw
         f74w==
X-Received: by 10.229.219.199 with SMTP id hv7mr31088435qcb.15.1381659601843;
 Sun, 13 Oct 2013 03:20:01 -0700 (PDT)
Received: by 10.49.99.10 with HTTP; Sun, 13 Oct 2013 03:19:21 -0700 (PDT)
In-Reply-To: <CAPig+cSmVKK_onR8NtLkdahkFci77SCsU6PagyJEBYLo4xZBUQ@mail.gmail.com>
X-Google-Sender-Auth: JmReljeVVXY6qZJ544ndWAXwO3o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236073>

2013/10/13 Eric Sunshine <sunshine@sunshineco.com>:
> Here "staged".
...
> But here "stage".

The inconsistency is weird, but isn't the term "staged" a bit odd with
something that affects the future...?

"Apply to the stage" seems a reasonable english phrasing, but "staged"
seems more awkward...

-miles

-- 
Cat is power.  Cat is peace.
