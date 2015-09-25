From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5561: get rid of racy appending to logfile
Date: Fri, 25 Sep 2015 10:44:03 -0700
Message-ID: <xmqqoagq4cnw.fsf@gitster.mtv.corp.google.com>
References: <1443137493-2648-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 19:44:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfX2a-0006OR-6C
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 19:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932851AbbIYRoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 13:44:07 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35477 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932766AbbIYRoF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 13:44:05 -0400
Received: by pacfv12 with SMTP id fv12so113634066pac.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=G4i6wHP0hG4fkUBfSS7al/nolnBO3KhMFVsSo51rUCQ=;
        b=lFJ0JAOAmDpHxgd6Ja4+KLOb72Pxssi2EcEydkkLkOE0zm117T9kz9o5mey9n6vC5m
         eru+0KvtQ7h1C7rcNeK/hmYsf/v4rV3suBBpTRx6A5Or9dG0mUciOPsqQlUl+y99clpq
         8l5rtkMwB61M6nU+Czozauj5sTcJh8aj2hOfgrriD31D8RXVgm0HxyJMUWGEUqus6+S0
         FlSMqiyBi+zWy301Zo+hIGtr6cOgPc8dKLiGyx/5C5PfWBRbnZSO2lNrAMHYLrnTrlPz
         7/M4lmquKqFvNnBIggMQffOcNIdLP0Kf2WFinW6s1zn5yuVZjRCFU6EFqgZH0xyet2HV
         9tOQ==
X-Received: by 10.66.165.5 with SMTP id yu5mr8687812pab.109.1443203044507;
        Fri, 25 Sep 2015 10:44:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:913:2c8:148a:1d8e])
        by smtp.gmail.com with ESMTPSA id ql5sm5012757pac.46.2015.09.25.10.44.03
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 25 Sep 2015 10:44:03 -0700 (PDT)
In-Reply-To: <1443137493-2648-1-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Fri, 25 Sep 2015 01:31:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278669>

Stephan Beyer <s-beyer@gmx.net> writes:

>  SubmittingPatches says that when there is consensus the patch has to
>  be resent to Junio and cc'ed to the list. Here it is (although I
>  don't know if there is consensus, but, hey, it's a rather trivial patch,
>  so it should be okay).

Yup.

The patch text matches exactly what I already queued with
Reviewed-by from Peff earlier, which is good.  

Thanks.
