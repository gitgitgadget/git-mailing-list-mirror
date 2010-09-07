From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Determining commit reachability
Date: Tue, 7 Sep 2010 23:04:56 +1000
Message-ID: <AANLkTimhucSrdQ6GKEDkWXuZkF+oCJbGkP_ZxgR3FdVg@mail.gmail.com>
References: <4C83FEC3.3040101@gmail.com>
	<7viq2jv05c.fsf@alter.siamese.dyndns.org>
	<AANLkTinDfCkkY_D6F7VepvuNAN1g1hC9UgnqRUjZn88y@mail.gmail.com>
	<AANLkTim4kxpQj_UFOBcwCaVmBFCHun4T9t3O9Zvq3w49@mail.gmail.com>
	<AANLkTinPDUeL2jaY3P17TiA959WH8eOQZ4=CeaHOYuq2@mail.gmail.com>
	<7v39tmtpci.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 15:11:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osxwx-0007dG-VK
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 15:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555Ab0IGNKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 09:10:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64743 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085Ab0IGNKw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 09:10:52 -0400
Received: by wwj40 with SMTP id 40so8137373wwj.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=2VMdH5HLNUfGXdymTj/aoQKx59wCnvVzQkwasRQ1Gas=;
        b=tjyxWZ898lSA+vtadujONbPF7m513c4GTLNdNG/JQ8Qt60OVomcMjzIvWW3Weoym24
         gcwLC8M4SOZZBQIYlwEDkU/AjEYSJDhdsjVjIgdvZEgJpN/9ZEL655wL8yuDqK97uVrs
         b0WBM5IU5l0Auz2D3+Agsn2Hvn4snB0AH0RIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jxkCxH8q31LclrPDAImgXJQ61yfc4lXc1Gft+dWSk0XgUAfq7Qn8NZE0t7wi5unugI
         imiorva6An7AmNl4vXQgyUvHFbnR4F/n/bkOywLdeUotnoRI/n83WfX2fhEuBM7y8q9T
         5fcwdyJiofXbXFETJSNvii83VEv3Wi40Cjbx4=
Received: by 10.216.5.21 with SMTP id 21mr8621wek.20.1283864697113; Tue, 07
 Sep 2010 06:04:57 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 7 Sep 2010 06:04:56 -0700 (PDT)
In-Reply-To: <7v39tmtpci.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155703>

On Tue, Sep 7, 2010 at 9:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Somehow people wanted to see an option with a longer name, but by that
> time my fingers were well trained, so I kept "--with" but didn't bother
> advertising duplicated options.

But do you object a document patch for that option? I ask because I
found another undocumented option, --clear-resolve-undo in
update-index and was wondering if it's worth a patch.
-- 
Duy
