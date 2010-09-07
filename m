From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Determining commit reachability
Date: Tue, 7 Sep 2010 23:07:07 +1000
Message-ID: <AANLkTimzSV-M_ed8-vK+P_3-QpC3THdEpMQZbuM1Q-Sp@mail.gmail.com>
References: <4C83FEC3.3040101@gmail.com>
	<7viq2jv05c.fsf@alter.siamese.dyndns.org>
	<AANLkTinDfCkkY_D6F7VepvuNAN1g1hC9UgnqRUjZn88y@mail.gmail.com>
	<AANLkTim4kxpQj_UFOBcwCaVmBFCHun4T9t3O9Zvq3w49@mail.gmail.com>
	<AANLkTinPDUeL2jaY3P17TiA959WH8eOQZ4=CeaHOYuq2@mail.gmail.com>
	<7v39tmtpci.fsf@alter.siamese.dyndns.org>
	<AANLkTimhucSrdQ6GKEDkWXuZkF+oCJbGkP_ZxgR3FdVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 15:13:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osxzl-0000iA-KF
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 15:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782Ab0IGNNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 09:13:46 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48655 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576Ab0IGNNp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 09:13:45 -0400
Received: by ewy23 with SMTP id 23so2303000ewy.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=jBnJ8PXE9/W4nJGLHPxGKjSfM6NSDL9NP9D5bH5nscU=;
        b=rYI+9SjWgGp19Qden/25JTGWyx93mTcce5N2N5xB3QEXqvBLMq9oJRsZYADrHYnyZV
         LlI0GODKEQHj83+iwgn5TRdwkiBc0aSzByy76p3zRs8EBBH86OObqV7kAwojAQ0jEfEU
         18aZuBD9lgQ8kV0TzmU5j7H4ooftWYQNLu/pE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HCwKDg7ZM8ML/Z182qvThQViknoxK+kVjJ96iTNakNtDohSEKu01bvoiLUE+0thZiK
         EtjIXOBMzyDOpKgf4LoyLwUx9j7N68bJwpkTaQf8Jtb1ImbzbRcypBzG1r7kvUDlWltF
         TEFzU7tt996zgOsYMCiFMBddmu75CtpzTDcFQ=
Received: by 10.216.23.129 with SMTP id v1mr47727wev.49.1283864828156; Tue, 07
 Sep 2010 06:07:08 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 7 Sep 2010 06:07:07 -0700 (PDT)
In-Reply-To: <AANLkTimhucSrdQ6GKEDkWXuZkF+oCJbGkP_ZxgR3FdVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155704>

On Tue, Sep 7, 2010 at 11:04 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Tue, Sep 7, 2010 at 9:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Somehow people wanted to see an option with a longer name, but by that
>> time my fingers were well trained, so I kept "--with" but didn't bother
>> advertising duplicated options.
>
> But do you object a document patch for that option? I ask because I
> found another undocumented option, --clear-resolve-undo in
> update-index and was wondering if it's worth a patch.

Hmm.. just saw Jonathan's patch. I guess I just go ahead and make a patch then.
-- 
Duy
