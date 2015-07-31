From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] add notes.merge configuration variable
Date: Fri, 31 Jul 2015 13:00:10 -0700
Message-ID: <xmqqvbd03xo5.fsf@gitster.dls.corp.google.com>
References: <1438370496-26433-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Johan Herland <johan@herland.net>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 22:00:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLGTh-0000z4-VH
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 22:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbbGaUAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2015 16:00:15 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34437 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbbGaUAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 16:00:13 -0400
Received: by pacan13 with SMTP id an13so46517405pac.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=OvZpTx/L7BhL1ErlTUswEVn67NXRpyd0AldZ+PEPu/4=;
        b=xZSOhokNkdvQrhJzLH/RSYwJy57dQKWmHfRzrnn/DkMdpA7ITC37TBROYwr5jsJYny
         dGrVxYTPMZDkQI78RfMk1LZ1NM1FTYEhbHInp2VL4s7HzEzp0g/mgPhj1EXaIYLbyIKo
         7HMNC5JaCBb88ofa4lzSnoN6w+SYge2I22gUd1VwY4RUYwcvJ0WX0ruVJLDBOz9vh2B5
         c2YKOMpiHlcQ3EaABQFb52yP4mEMfJEqHZuDz98RX2cZmzD9nAHKCnq7wEj4RnTtwsya
         r+muh/u3tx7v5N2p/0RBFJS3cK2xsBsE1BEw6q3VfGmTsZoco11bk9fNL1lQfuWC6uwH
         Ae/w==
X-Received: by 10.66.62.163 with SMTP id z3mr10577800par.12.1438372812796;
        Fri, 31 Jul 2015 13:00:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1b0:46e8:ba02:35e3])
        by smtp.gmail.com with ESMTPSA id oq10sm9150043pdb.75.2015.07.31.13.00.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 13:00:11 -0700 (PDT)
In-Reply-To: <1438370496-26433-1-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Fri, 31 Jul 2015 12:21:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275073>

CC'ing yourself is ok, but please do not forget to ask reviews from
people who have touched the area of the code you are touching (they
are hopefully the ones who are more knowledgeable and can help you).

Old timers like I know Johan is the go-to person on things around
notes, but new people can ask their copy of Git:

$ git shortlog -n -s --no-merges master builtin/notes.c notes.c | head =
-n 5
    46	Johan Herland
    11	Junio C Hamano
    11	Michael Haggerty
     5	Jeff King
     5	Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy

The changes to the code looked reasonable from a cursory read,
though.

Thanks.
