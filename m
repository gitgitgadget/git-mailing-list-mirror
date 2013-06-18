From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 7/7] rebase -i: write better reflog messages
Date: Wed, 19 Jun 2013 02:08:16 +0530
Message-ID: <CALkWK0==+Zs-Ej92VsHnF60_=RTigkKo+3xLew3JdavC3fbzoA@mail.gmail.com>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
 <1371581737-10013-8-git-send-email-artagnon@gmail.com> <7v38sf40my.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 22:39:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up2g9-0006ls-F9
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 22:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933077Ab3FRUi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 16:38:57 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:47403 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235Ab3FRUi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 16:38:57 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so11444625ieb.30
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ihgob9AUeOAADcfsToQdeV5u8agQl4U2O3X4F5okzGY=;
        b=Gnnf8HwO1rTgIO8DwDGTASek20pR4MkpgJdRmP/hDAps5yqy2kXVu8SQ78eBhMSHYi
         C1JryoNya65Q7UnOIWdkChMh9REJKVSRrtYucbKOrEvGbhnvxnasu3xwz0nGCoz7bkQR
         6PCZODvmJ3ii1mdQ340NtVn6NbcHR9RXRUILVTNHIDXRB4rvLan8lV8r+iejs/dwr41X
         Z4PHjx1buN+92tnfD8FZGPfx3pcbgWd+09jS7Uof8cNnkQWzfZfmALXBdX6+YvXVVdQC
         zek4JVGHqcsXkGjyvyh7M1K1panOl82lYbcbr8LBU8M5CDlKPyF+rdZKvxtRxfJLAhDv
         wIng==
X-Received: by 10.50.79.231 with SMTP id m7mr8332666igx.40.1371587936639; Tue,
 18 Jun 2013 13:38:56 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 13:38:16 -0700 (PDT)
In-Reply-To: <7v38sf40my.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228314>

Junio C Hamano wrote:
> Why did this have to change back from branch-reflog-test to branch1
> (which I used by mistake in "how about this" patch, but fixed in the
> version queued on 'pu')?
>
> The reason I did not use 'branch1' in the version I queued on 'pu'
> is because rr/rebase-sha1-by-string-query, when merged on top of
> this, makes an assumption on where branch1 is in the test and
> fliping its tip here will break it.

Oh, okay.  Then just tweak before applying, if you don't mind?
