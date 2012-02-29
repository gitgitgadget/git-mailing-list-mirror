From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v7 02/10] Stop starting pager recursively
Date: Wed, 29 Feb 2012 10:40:40 +0700
Message-ID: <CACsJy8BfBP9m8rdEY3mk6g4G7n5LyFPvvNgNK2bkwC6L7qTDCg@mail.gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com> <1330430331-19945-3-git-send-email-pclouds@gmail.com>
 <7v4nua25cz.fsf@alter.siamese.dyndns.org> <7vipiqzsd8.fsf@alter.siamese.dyndns.org>
 <CACsJy8DJM5hwWnTs2rkhCa7a=vKRRsLMjZGBotmDDpAaGG+Sxw@mail.gmail.com> <7vr4xewbrz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 04:41:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2aPk-0007or-KY
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 04:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030754Ab2B2DlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 22:41:12 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:53381 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030724Ab2B2DlL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 22:41:11 -0500
Received: by wejx9 with SMTP id x9so1417262wej.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 19:41:10 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.84.36 as permitted sender) client-ip=10.180.84.36;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.84.36 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.84.36])
        by 10.180.84.36 with SMTP id v4mr14249871wiy.0.1330486870436 (num_hops = 1);
        Tue, 28 Feb 2012 19:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kSQvPDAP0mn2rT2r1BXhmPy5Tlb+oXSlydxZMltbV8M=;
        b=H3PjbrmK6kWKZa3YkjYTTvwz+sWZs2Hy0Jq+Ej8NX0l9n/Ni379mOaNZ1OWiKa+PGv
         OzFZH7NoSYBd8J3wiFW6BcW7bF7EirIDqryvbZHJb9pFJzYEUzWp3pU2UUeKQoFKLdhr
         1Tf4dkRLX/fAxOQtbbvYN9+isVRLOpRrMGtzg=
Received: by 10.180.84.36 with SMTP id v4mr11375848wiy.0.1330486870361; Tue,
 28 Feb 2012 19:41:10 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 28 Feb 2012 19:40:40 -0800 (PST)
In-Reply-To: <7vr4xewbrz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191807>

On Wed, Feb 29, 2012 at 10:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> It does improve that situation, or at least it stops git from forking
>> frantically.
>
> That "at least" sounds suspicious ;-) Do you mean that there is other
> breakages in that mode of operation?

Well, "shortlog -p" did not run $PAGER (i.e. less). I haven't had time
to dig further.
-- 
Duy
