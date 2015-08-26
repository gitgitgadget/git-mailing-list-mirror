From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 04/12] ref-filter: implement an `align` atom
Date: Wed, 26 Aug 2015 12:11:21 +0530
Message-ID: <CAOLa=ZTAaRrq+4_A8fs76xFQ4KQZpJscSP3s+bK2q5Rw9JJ34g@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <1440214788-1309-5-git-send-email-Karthik.188@gmail.com> <xmqqmvxg2v3u.fsf@gitster.dls.corp.google.com>
 <vpqk2sj7tlb.fsf@anie.imag.fr> <CAOLa=ZS1EiU3FFLwR3QUUebCtVkrwUS=qP9xvc93LHanA5eh=A@mail.gmail.com>
 <xmqqlhczz1yz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 08:42:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUUPE-0001YU-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 08:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbbHZGlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 02:41:52 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36229 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118AbbHZGlv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 02:41:51 -0400
Received: by obkg7 with SMTP id g7so163114298obk.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 23:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eqrsjUG5+zM9vj/meGfOMnAchpgZ8mUv6/fV3Y80wU0=;
        b=cybZGV8teTS9LMRowWysbU8oWroVEqkDhUv7JbBMYe5VwqPp11Jed+mdvWkUZF4nUz
         VnfX6R3T0V3BB7YTC9+ttxedWqj/NDU0OVrRlFbIgdWgW3rwZb6thR37yp52WzxvjQQ+
         +ZJZby3l5fi7852sgSUassamj7wliRkIQby/hb045OO9ii06dI3esnQtFLV4H/5CYRf4
         kSU+BSiKZZ/FMn0GAzEFN/bGnJhnux2WYMp0pGUVhoaCtatWnrQ19bm/bgyssZMhCWRS
         zMUziM6r6WDHfcgoJgeGIa+YlZbIXdpvdAWsl6LLpqIaF6w5ok6zBRJtZEVb3SkPny2Q
         5n6Q==
X-Received: by 10.60.92.37 with SMTP id cj5mr30700526oeb.30.1440571310435;
 Tue, 25 Aug 2015 23:41:50 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 25 Aug 2015 23:41:21 -0700 (PDT)
In-Reply-To: <xmqqlhczz1yz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276601>

On Tue, Aug 25, 2015 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> I like the idea of using atomv->handler() a lot, mostly cause this
>> would eventually
>> help us clean up populate_atom() which currently seems like a huge dump of code.
>
> I think you already said that last time we had this discussion ;-)
>
> http://thread.gmane.org/gmane.comp.version-control.git/275537/focus=275778
>

Yes :) I really want to clean that up eventually, every since Duy
mentioned about it.

-- 
Regards,
Karthik Nayak
