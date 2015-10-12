From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Sun, 11 Oct 2015 17:36:07 -0700
Message-ID: <xmqqbnc4ord4.fsf@gitster.mtv.corp.google.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3l5zgst.fsf@grenoble-inp.fr>
	<CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
	<vpq8u7dp9qr.fsf@grenoble-inp.fr>
	<CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
	<xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com>
	<vpqpp0ojvs6.fsf@grenoble-inp.fr>
	<xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 02:36:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlR67-00022I-Oa
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 02:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbbJLAgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 20:36:10 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35351 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbbJLAgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 20:36:09 -0400
Received: by pabve7 with SMTP id ve7so80035725pab.2
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 17:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cEdO3TJmqosUDpT18l03w5wkNSPDXBsCxdq/r85EYIw=;
        b=rhH62b33/rzNsCfV5qxOSTE5SZIVwcDlBpKAItuy3EuebhTyUMxm7nEs3+IIokD2f3
         UY/IrodGBbSEvxjlnGx+0tEVGiN6rY2jpb35idLwoZLh0XOemyLI+RiRiWC6MBL72KVj
         0xe2F9E+ZN/5FJzljSSmw45LjI5ogMqavePQVrhLrM5fwCbO6C5NpEHWMAcQrH7Gz728
         Uobk5ZalFVPD0yCl55s4e8dsekUJUDjafwdSDZlSEA9NkSnSwcv6HObNXX1CMUWBPsMA
         2TIJtRm8gOorzASfIyclKrEfG8hOVyh95VdelbXxSsSyYENW95C31EBHcBSF0cnn9yyn
         CbTA==
X-Received: by 10.66.235.194 with SMTP id uo2mr24299259pac.41.1444610169088;
        Sun, 11 Oct 2015 17:36:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id xa4sm14752412pac.28.2015.10.11.17.36.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 11 Oct 2015 17:36:08 -0700 (PDT)
In-Reply-To: <CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 11 Oct 2015 18:18:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279359>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Fri, Oct 9, 2015 at 11:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
> Also does it make sense to integrate these changes here? Or would you like to
> have another series on this?

I do not think you would want to ask that question, as my answer
would most likely be "The most preferable would be a series to clean
up the existing codepath that deals with %(align) first, on top of
which everything in flight that is not yet in 'next' is rebased."
