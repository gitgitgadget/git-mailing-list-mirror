From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v2 6/7] t5520: reduce commom lines of code
Date: Sun, 3 Apr 2016 11:54:36 +0530
Message-ID: <CA+DCAeT4rF2dqL9iU9WYQJuxiSYstY9AaT2Hc7OvhmFNyKEgAg@mail.gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
	<1459619912-5445-7-git-send-email-mehul.jain2029@gmail.com>
	<5700145E.4060308@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 03 08:24:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ambSq-0005V5-9T
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 08:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbcDCGYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 02:24:38 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:35119 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbcDCGYh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 02:24:37 -0400
Received: by mail-qg0-f67.google.com with SMTP id b32so14057973qgf.2
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 23:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=MoNnTYEMOeupehiLpR8q3KwGJgPhPK9y2KJoeXogr8E=;
        b=DG1Xxq/UjJXgMJRcb+pnyAukatoOWGVlni6zllMa8LiHkd+wrAu+/5uYn8JZJs22kK
         ysx9m7SAuEMqp9cp/Rc/027jvOTFA22KnLIcaE8dfgGYwSC1Pn1OKp23riATHzf0ZHkp
         y4pNRcipLZPKVdcpLl19lE6Lk54IS7ckCuGGadIHYQcILP8mYXp00R54KKVXaMRqtwa9
         OSOfkyKMiGthIsMCEkuVGQICFg5Ev+7kOyIbTPNv1zMqfz5NYKsuSAUHS2k1cMR/WIUM
         UD8FskRD68XS999n/1CCLvNJ3LBNl8F1UELEaLn7n6pRxE8J1D5KD9GTGqCxPQfeeira
         2Xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=MoNnTYEMOeupehiLpR8q3KwGJgPhPK9y2KJoeXogr8E=;
        b=FEF++x3NZTWwr04X/Agz4pqdLmViNrbnchcQLtYfhGQNfIRsHEQw2JD/hiSwhmCuvv
         OzSHhUxnd8oz9d9Y48HcA32VcpYgliDAJhrgBXQPmYii9P9fT7SDEYzOGjl8IZOTVXd8
         xUOV7ezhwtPC9HRMlZpbSTvWgjBuYhqyMcQdnAmaPxIby2FLYGpV+d5DARlCFN1kKGZK
         9WJ1gOmEu5KQd2ZIDPx1KEZjAYaZkfIEuntqhP2P6atNEvekwv/sKpFO3PTaSKXNR7/X
         Gc5eBjBOOuNw3SD5SrWh4MA1j5hUCHUy5E8ATr0fwtRCh2pE+pS03CNItHu6JQeuGZMl
         6eDg==
X-Gm-Message-State: AD7BkJILhaO9vvrcNdiPf/ivlOggsd4VZp8Q2bzl6idfaZESP7mfAR5cr9bMjPjV+QovIi1WdC+F5GxEsiyh/w==
X-Received: by 10.140.163.131 with SMTP id j125mr630517qhj.45.1459664676664;
 Sat, 02 Apr 2016 23:24:36 -0700 (PDT)
Received: by 10.55.10.135 with HTTP; Sat, 2 Apr 2016 23:24:36 -0700 (PDT)
In-Reply-To: <5700145E.4060308@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290630>

On Sun, Apr 3, 2016 at 12:20 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 02.04.2016 um 19:58 schrieb Mehul Jain:
>> +for i in --autostash --no-autostash
>> +do
>> +       test_expect_success "pull $i (without --rebase) is illegal" '
>> +               test_must_fail git pull $i . copy 2>err &&
>> +               test_i18ngrep "only valid with --rebase" err
>> +       '
>> +done
>
>
> Hm. If the implementation of test_expect_success uses the variable, too, its
> value is lost when the test snippet runs. Fortunately, it does not.
>
> You can make this code a bit more robust by using double-quotes around the
> test code so that $i is expanded before test_expect_success is evaluated.

I think that the current format is preferred over the one you suggest.
Here[1] Junio
has given a descriptive explanation.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/283350/focus=284769

Thanks,
Mehul
