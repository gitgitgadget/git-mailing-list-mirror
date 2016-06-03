From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Fri, 03 Jun 2016 08:41:53 +0200
Message-ID: <vpqr3ce6afi.fsf@anie.imag.fr>
References: <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160602224809.5167-1-william.duclot@ensimag.grenoble-inp.fr>
	<57511B2D.7040501@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 08:42:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8io3-0007pN-FQ
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 08:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbcFCGl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 02:41:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36495 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbcFCGl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 02:41:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id a20so9608973wma.3
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 23:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=c7RXOHSo7TtfAREqvSQ8k48mN2kMvB3Bre1sfqEQZsg=;
        b=NxR+HNKFzMAl2DvOmyGNQ5HKCnNyhlcWPOT1mVxxyEljbarPsi2uk4z85tmt2l+X0i
         jo8+XzzFaOyn+RsK6yXIsCu9BvbsibxVXAeJDdioe/frTl7YsCxgZC5NJF0cUlinfCS3
         D1OsjleR20MjtxW6xCGCwmQA3HndT2rGAProuV9ZYc9lNC7umDPkEMGZKVnHdOqsJmDz
         2DW27KDgwhox902HbZ/VkZJGIvV+THEyKZ1BSjhHKQY2EVBJ7bnHGJRGHOyb1LSKMX+c
         IJ8Wd8WenntnhzRQWE8PdxI5e8wPzQhd1lhIEHrhhB5ngrWtD0aI1bFa2wrbyldlsf2V
         MdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=c7RXOHSo7TtfAREqvSQ8k48mN2kMvB3Bre1sfqEQZsg=;
        b=TXLhX9KU9i3AYInqZ6hBBgYgEj7mnaPEjWyyExoDgD7K0oEUEWsTsTOl+onxzf+pfI
         RyR/IkC4hcQJWAv5u7hxoBPbq1aYsC8AeZyD8lQOpnEPGwuJTKOWyWp7svqnKeUhonPB
         dnjSU/GLR3Fc7W1lFD++3Vj760RZFYnUmKUIyMeTS3gjpied2VIb/uiTtRFK4oj01Vru
         eraaqpjbixm6H7XdiIqwupqDu/8qsymRiN75vZlAmZujdVdSiTM3U58odHBLFRjVQiCZ
         8WwlWRtEf7ew1NnhjwQewSCFuBQcM7RFhnr7KGYM1B8qEcp1150YBAQcHVf5EIMcxNB5
         cWdg==
X-Gm-Message-State: ALyK8tLrlMhBc9+fEoklJiUonZrBn7qIj/SnURztNhbUo8Ma2gD6EdYxcgI3TnSemRRftA==
X-Received: by 10.28.52.75 with SMTP id b72mr2277430wma.98.1464936115727;
        Thu, 02 Jun 2016 23:41:55 -0700 (PDT)
Received: from anie (anie.imag.fr. [129.88.42.32])
        by smtp.gmail.com with ESMTPSA id q194sm44289228wme.18.2016.06.02.23.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jun 2016 23:41:54 -0700 (PDT)
In-Reply-To: <57511B2D.7040501@kdbg.org> (Johannes Sixt's message of "Fri, 3
	Jun 2016 07:52:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296269>

Johannes Sixt <j6t@kdbg.org> writes:

>> +IPATTERN("css",
>> +	 "!^.*;\n"
>
> Is there a difference between this and "!;\n"? Is it necessary to
> anchor the pattern at the beginning of the line?

Also, you don't want to force the end of line right after ;. I know
trailing whitespaces are evil, but users may not deserve to be punished
so hard when they have some ;-).

> In the commit message you talk about colon (':'), but you actually use
> a semicolon (';'). Thinking a bit more about it, rejecting lines with
> either one would be even better. Consider this case (without the
> indentation):

Rejecting colon anywhere in the line would also reject valid patterns
like this:

a:hover {

Rejecting it at end of line is probably a good trade-off.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
