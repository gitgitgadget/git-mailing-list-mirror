From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] mailmap: Testing the single letter name case.
Date: Sun, 14 Jul 2013 22:31:50 -0400
Message-ID: <CAPig+cR8zhcZ9_Gjq9mv0kPMe7F=szeSANG1b3J3gitoWCZaxA@mail.gmail.com>
References: <1373665135-32484-2-git-send-email-gitster@pobox.com>
	<1373700020-30436-1-git-send-email-stefanbeller@googlemail.com>
	<7v8v1aicn5.fsf@alter.siamese.dyndns.org>
	<51E198FC.5080005@googlemail.com>
	<7vk3kugqkl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 04:32:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyYZz-0006uf-7r
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 04:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858Ab3GOCbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 22:31:53 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:53867 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab3GOCbx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 22:31:53 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so9085377lab.4
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 19:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=akX2LMPkyL1CxvOBKnuPRlSEx456eLY6L0//bs8mS3M=;
        b=OoTCWJQ2hnCQWXSeBuU2yhOMQmOrFqvhKJ8fpIb5dmGEm4qeA2J8Yw+Gk6jI2Bv1jd
         QqELQa5zsCIEczXwXLpH46MOcwq3Z/eRQiErT56A+bcTe3uiiKJcZGfNViXt2RmFs9Hp
         mNpHoU04VTTsQZHrVeokYH8xvN9thyuxTs50gyg45hLnIZ9cj9tcmh3SuBLIQFih1nSM
         tWamin8IZZgv4f3hZ9UhABrPUxFWSQgBpZYYIZ1pE8zOulbsIlaUyZpVsgkkQYyW837o
         NY613UerwNhsL4rnO5hfL8NkUkfFXeX/UAQjQjFTEtK+efCLDVbh9XgDlrm1xRMuPjNo
         CTLA==
X-Received: by 10.152.44.225 with SMTP id h1mr23196437lam.90.1373855511052;
 Sun, 14 Jul 2013 19:31:51 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Sun, 14 Jul 2013 19:31:50 -0700 (PDT)
In-Reply-To: <7vk3kugqkl.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: X5E5wWf-Udx7oUHjCFWf8-k8E6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230404>

On Sat, Jul 13, 2013 at 4:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>
>> Indeed the patch tests for both bugs unintentionally.
>
> I was puzzled because I do not think that is what is happening with
> the posted patch.
>
> The off-by-one fix seems to be correct from code inspection, but the
> new test does not seem to demonstrate a case where the code before
> the fix misbehaves.

I've written tests which check for the two bugs which Junio's patches
fix. I'll be sending them along with a re-roll of Junio's series along
with a few other fixes to mailmap's debug mode.
