From: Junio C Hamano <gitster@pobox.com>
Subject: Re: determine a linux kernel version of a patch file
Date: Fri, 15 May 2015 13:16:39 -0700
Message-ID: <xmqqvbftfvfc.fsf@gitster.dls.corp.google.com>
References: <CAJmOuExq3WF26Gufr5bAA7w3=EMxJ80NKMXf8Dgi0TK7kVXStA@mail.gmail.com>
	<vpqr3qicabd.fsf@anie.imag.fr> <1431709433.1401.9.camel@gmail.com>
	<c97f7591e4bf884ee810699f1e5278dd@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kelvin Li <ltwisabc@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Pawel Por <porparek@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 15 22:16:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtM2J-0004Vd-Fx
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 22:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934930AbbEOUQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 16:16:43 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34887 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934824AbbEOUQl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 16:16:41 -0400
Received: by iesa3 with SMTP id a3so41437284ies.2
        for <git@vger.kernel.org>; Fri, 15 May 2015 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Oc+qIPiVkWRIMwC+kLwEYrq8FwxTauAqGRpsGY4SmkM=;
        b=YAlh37WHKcSIReBQCmQXiWbvVb/BCInDYBg9617FMrS7ehDqSxLVk74fXfMFHwtW9t
         J5egzjwbGRiPtKbmR6judr9J/7S8Q67ZZCDLMZyqMLXQnbWQPwfYjllMTe4BArA0YAbX
         aY8xAZuUC0xB8rDkPaagR0wR+sUF6dTRLJQ2TOulw9sq5ICWJ60T2XFAKSmCHj2ZXfRw
         9z42VRONm4Vu6rnH2eXFFp1gs8VlJyiHfk94d+edGVFqg3/FcDIH/hICY3pBbiksSSda
         Ye+P2ZqukXg3yvFTPmjJl9n2hJpXfJ1n7sdJ1RUR4SFpxQef7LYbaTheLm42ryk8BoRZ
         VdwQ==
X-Received: by 10.42.238.14 with SMTP id kq14mr23285956icb.23.1431721001170;
        Fri, 15 May 2015 13:16:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id qh9sm2302017igb.20.2015.05.15.13.16.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 13:16:40 -0700 (PDT)
In-Reply-To: <c97f7591e4bf884ee810699f1e5278dd@www.dscho.org> (Johannes
	Schindelin's message of "Fri, 15 May 2015 19:41:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269176>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> By default, `git diff` works on the index, unless you force it to
> compare revisions or the working directory to a revision. I guess that
> is where the wording comes from.
>
> In any case, it is too late to change it now...

Those who are interested in the full answer can look at this thread.

  http://thread.gmane.org/gmane.comp.version-control.git/9694/focus=9795

;-)
