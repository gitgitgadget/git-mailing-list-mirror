From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 09/11] parse-options.h: add macros for '--contains' option
Date: Thu, 2 Jul 2015 22:52:50 +0530
Message-ID: <CAOLa=ZROvuNY8Qv53e+Zk-ayoHTsMmbx3WUGF+HKW2zEGfGBiA@mail.gmail.com>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
 <1435850470-5175-1-git-send-email-karthik.188@gmail.com> <1435850470-5175-9-git-send-email-karthik.188@gmail.com>
 <vpq1tgq8p36.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 02 19:23:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAiD4-0002vI-Nl
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 19:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbbGBRX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 13:23:29 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34734 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbbGBRXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 13:23:21 -0400
Received: by oigx81 with SMTP id x81so60935729oig.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=O6M+q55LRXNOb7nUpJGs1WFKP65IKxihhhbThISbnrU=;
        b=NQ1z81fkibuIAYZPdfEE3HOGSzKavPu93OqxNuKYCxquDFuuTA1WHAf68KcyoQzNfP
         SA9PtG7VrC1fibIsnElXdYa8M9c5xDwmemEREf/xZuWRhSLcmp/Kj8rn7CLvd7Qy/L0e
         /r+SRmsCC6jf4lA5sMYokUF7fXJzn8129KDZEtYorXG3dmjZG3cvIrCxWmCPhzQ4ZxQW
         XHXCrzuRl6TTuZrg58bJNuq/XG7Epobcg3siC5Wy8fdNmLVj5WrxSIym5uprxatZmagf
         p8gpoqFRmy4Gis5OW5M1xTmqpeLOVUpofVOM4SqhB9hUsCNydcl8iBKnl13bvJylXgzg
         7Dgw==
X-Received: by 10.60.62.105 with SMTP id x9mr28166647oer.1.1435857799958; Thu,
 02 Jul 2015 10:23:19 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Thu, 2 Jul 2015 10:22:50 -0700 (PDT)
In-Reply-To: <vpq1tgq8p36.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273252>

On Thu, Jul 2, 2015 at 10:38 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -246,5 +246,12 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
>>       OPT_COLOR_FLAG(0, "color", (var), (h))
>>  #define OPT_COLUMN(s, l, v, h) \
>>       { OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
>> +#define _OPT_CONTAINS_OR_WITH(name, variable, help, flag)                  \
>
> Same weird space as the other patch.
>

noted.

-- 
Regards,
Karthik Nayak
