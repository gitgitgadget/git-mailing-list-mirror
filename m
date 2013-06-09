From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 42/45] add tests for rebasing merged history
Date: Sun, 9 Jun 2013 12:31:45 -0500
Message-ID: <CAMP44s30YkE5i7B==pyB8zkNxu=YoGvP1=V_2LqOe_frXV+cfQ@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-43-git-send-email-felipe.contreras@gmail.com>
	<87wqq3ci1n.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:31:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljT5-0005KO-4V
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab3FIRbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:31:47 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:61396 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab3FIRbq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:31:46 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so3270952lbi.11
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5nxO3T5Cxd3z2QaKlkI83gvQL/GXaomfddUkU7NwCJ0=;
        b=sYPEJK/0wiHpBPhC6TI2iZGfMPmYWYUnnXWG2jka+vWdCYq/Bo+TnvxtxKO3KoQFso
         Nw8w+TQNIz4h+gcRpqSHms8jzMNy9eyHrL/7cHGnaIT8Q4xSion90hfkZ9oGef06YKzs
         6rpaNJ+8FYddwbFO0mb/+qzPi1p38gNG7kcGHl56KIm8QpP9rZQ3lIneonOm+IoPurJJ
         V4E7CMLEJ2+DoxdtTQfc6xRWFYQ164fQPNZJ9PMdy3hqfGXQgu5evlIdKQIM95kcDGaF
         hrMt5rK7YIjprj+/q0dfBV5fvhe1I27cRiORCEE4xjAZUnvby0NEFv8/T5xblxioWSzp
         rFqw==
X-Received: by 10.112.166.67 with SMTP id ze3mr5009577lbb.25.1370799105194;
 Sun, 09 Jun 2013 10:31:45 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 10:31:45 -0700 (PDT)
In-Reply-To: <87wqq3ci1n.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227039>

On Sun, Jun 9, 2013 at 12:25 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +#TODO: make order consistent across all flavors of rebase
>> +test_run_rebase success 'd e n o' ''
>> +test_run_rebase success 'd e n o' -m
>> +test_run_rebase success 'd n o e' -i
>
> [45/45] would seem to imply that these tests fail as of this patch.  Is
> that correct?
>
> If so, please either squash that change or move the test further up
> marked as 'failure'.

I won't. The whole purpose of the last patch is to show these tests are fixed.

Martin von Zweigbergk's patch series is independent of this one, I
merely added it to show the above.

Eventually Martin's patch series will be merged, while mine probably won't.

-- 
Felipe Contreras
