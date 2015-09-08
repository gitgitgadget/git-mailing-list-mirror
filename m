From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Standardization of messages - dot after the sentence
Date: Tue, 08 Sep 2015 11:16:04 -0700
Message-ID: <xmqqh9n493q3.fsf@gitster.mtv.corp.google.com>
References: <CALx9kCVwpOvBfTxBi8gn7MBajEbuMLGP_HAJ0TW3XGzmUE0=QA@mail.gmail.com>
	<55ED3973.2020304@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sigo <spam@sigo.pl>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 20:16:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZNRD-0004c0-MK
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbbIHSQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 14:16:08 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35100 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbbIHSQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 14:16:05 -0400
Received: by pacfv12 with SMTP id fv12so133599107pac.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7qltmU9Zu4nfhGnqk9axhP+Z5r1exNnra0szhc/wPzI=;
        b=uSnALVuNnjWB+AN5yAZT+ryyClgjKho8znJPanetE4BStnJTvNXZbFR9mqN4rmZW1T
         pAoNY3/bUWQm/F3no7iYwmmFJyR+s6dWUWbzJHCGcSdUZAlqocdqrKFUkwrt6mO4POlQ
         k0Pzp5ItzHHkDOWfdys00pJHIHnR6bQrgrr7dAgPqzNHVP/yHJpK5isq09beIlPvQXs0
         GDB4v+FP2K1MXJ4bcwH2bip2kAG7ceu3fna75IaQSxT6TM3WaLdvTMki4CWfElIPAJAi
         IvqlpqSddnjdtRGueHGaNLD3RbXF9PS5x38KTfugSbHgE34JVOru2m/isKEoeIgzKvhi
         aQIA==
X-Received: by 10.67.5.228 with SMTP id cp4mr52533184pad.120.1441736165565;
        Tue, 08 Sep 2015 11:16:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:40ca:ccb5:4636:e6d])
        by smtp.gmail.com with ESMTPSA id lq10sm4205960pab.18.2015.09.08.11.16.04
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 08 Sep 2015 11:16:04 -0700 (PDT)
In-Reply-To: <55ED3973.2020304@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 7 Sep 2015 09:14:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277511>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> sigo venit, vidit, dixit 05.09.2015 14:22:
>> I've found really "little bug" with dots in the git output.
>> 
>> $ git push
>> Everything up-to-date
>> 
>> git pull
>> Already up-to-date.
>> 
>> Could all phrases contain dots? :)
>> 
>
> In this case, also both messages mean the same but are phrased
> differently, which is suboptimal in more than one way.

I do not particularly care between these two commands, but I think
"git pull" says the same "Already up-to-date" in two situations that
are two quite different ones.  That ambiguity bothers me a lot more.
