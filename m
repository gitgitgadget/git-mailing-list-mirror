From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Mon, 12 Oct 2015 00:08:10 +0530
Message-ID: <CAOLa=ZTjuuO_TmdynQvJGVtQHZokwDpqZLUOWgCx-_UO=JKvvw@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <vpqr3l5zgst.fsf@grenoble-inp.fr> <CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
 <vpq8u7dp9qr.fsf@grenoble-inp.fr> <CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
 <xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com> <vpqpp0ojvs6.fsf@grenoble-inp.fr>
 <xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
 <vpq4mhx2x5z.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 11 20:39:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlLWT-0006Du-Dg
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 20:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbbJKSil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 14:38:41 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33470 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbbJKSik (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 14:38:40 -0400
Received: by vkaw128 with SMTP id w128so19742583vka.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AgYNevVC+0ndTOPiS/67dy+A2Nq7ybc4lRg1JYZtZLU=;
        b=GWqRf5hBnCw0Ev1uJ33Z7T4PMskYxqWWkUIJl+maithu5yEj4Xl4G7V4CSu+vdp29r
         qWYQ1zXsZTLbEDRqYCpUY1Ulg+idaWT5eHf5iHQGWaSAMNJrT3I7V+mzM+pfpg3lr144
         3anQKGH0bQMatYDDAoMOsPd7hZe74toiarixXLLRtBRGU/Kbas3Bn0ES8zE39hFkmjDv
         zhUIJN9izc+ckwG9OrZkuRZYqcwTVIdQdGviUZ5VP1K+6Cs+yU3dfBkvsrLlYVxjWWa8
         p2CcmdvlGiyCj3cF+aXHgHWrmBAXsvMb8AsO8dBCuIa7FaPR8N8Ow4fxnMYq+vVxUY6V
         WCew==
X-Received: by 10.31.21.149 with SMTP id 143mr15598892vkv.79.1444588719637;
 Sun, 11 Oct 2015 11:38:39 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sun, 11 Oct 2015 11:38:10 -0700 (PDT)
In-Reply-To: <vpq4mhx2x5z.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279352>

On Sun, Oct 11, 2015 at 9:51 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Also does it make sense to integrate these changes here? Or would you like to
>> have another series on this?
>
> To me, the important in this series is to avoid introducing duplicated
> and inconsistent code, because it would make further refactoring harder.
>

Would you suggest duplicating whats done with %(align) here?

> But this series starts getting close to finished, so you should not try
> to add to much to it (at least for me: I spend some time reviewing v2
> and I have an idea of what the interdiff should look like, I'd rather
> avoid having new distraction in the v2->v3 interdiff).
>

Yes! makes sense, thanks :)

-- 
Regards,
Karthik Nayak
