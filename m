From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/7] i18n: builtin/pull.c: mark strings for translation
Date: Tue, 12 Apr 2016 16:52:09 +0700
Message-ID: <CACsJy8BsxZTChST8Gb25LT1HwwR1AcAthjfOQmoAjxkF4qzvBw@mail.gmail.com>
References: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
 <1460234324-13506-4-git-send-email-vascomalmeida@sapo.pt> <xmqqinzptkaw.fsf@gitster.mtv.corp.google.com>
 <570B7FCD.5050809@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Tue Apr 12 11:52:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apv08-0002CM-3Y
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 11:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267AbcDLJwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 05:52:41 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35903 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbcDLJwk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 05:52:40 -0400
Received: by mail-lf0-f48.google.com with SMTP id g184so17445657lfb.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6G2kaPZcDBQ6+3cr2gx0u1V6DjOIGm/+NFifG7xa5B0=;
        b=EDbqEMnxlCOjlau58tYZ5DtzbFAZpVDQYs8ekFyRb+Q6isgLzG4frBLo6itl1Kc6/3
         IlWAkMdJpWfX8OIzkZ5O4u7jmdbQYjwVs1hoqsXL7/8jJ60BtXFDJ+lwumYkcumQGH/N
         VaxygrV2GkHS3WG3exdvl6OcnAISVAOjJ95a3Vaf6KQuHFLxd/O1KpwCN8GzQrrXn9cw
         vX6DxiP9lQ8cCgae6woS+cwagOvARayrMizvfy0YCdsFyoCkSi8UrUDTmX/6YBpfUyv9
         1s9aRp97fdeulz8dt0+waln42OvnoYYU41CX/RoiTNdbvTugZHDj3t7eRQbk309bjYoH
         8UbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6G2kaPZcDBQ6+3cr2gx0u1V6DjOIGm/+NFifG7xa5B0=;
        b=CETUnB8u/qWoJNUAFpyz1/+4+vdNoT1ENUFXlviYgolQ9T7NPe6GcCTFTTrGyRtRaU
         v3w9G7c7h5WVDmAXuu6ULyXLhbqGxbEk493BHz/e7ilVnXMktObL0mjO8Q71hzRZ4VFu
         VX0CJDy4PUHLVW6lL8cTKS2jq1GoPjcuOGWQnOKgU3nTFW5mEVJAyuyFd26Oh2MBNcnF
         girQ8YI6j4KssLxJtrKheGnyQSXxHzRxgj1dSE4mgQR2QYJKfs9Fe/Bijan1DEiPZTqB
         MTFoTzTDqjXG/m/O1+pVT9+4Eg5CfIXB3hg+4GRSgzaFjw2baCiSCmaHaAIafl5wgLma
         6T0w==
X-Gm-Message-State: AOPr4FUgFVMRStoVjeW/m2KX+meQjHbDiiz4wL7GFVD2fxKsgwC7Xu1La25VoZ5f8Db5k/JLZt/hfCXNDJSk6g==
X-Received: by 10.25.17.67 with SMTP id g64mr1060907lfi.112.1460454758811;
 Tue, 12 Apr 2016 02:52:38 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 12 Apr 2016 02:52:09 -0700 (PDT)
In-Reply-To: <570B7FCD.5050809@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291253>

On Mon, Apr 11, 2016 at 5:43 PM, Vasco Almeida <vascomalmeida@sapo.pt> wrote:
>>> @@ -458,13 +458,13 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
>>>                      fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
>>>              fprintf_ln(stderr, _("See git-pull(1) for details."));
>>>              fprintf(stderr, "\n");
>>> -            fprintf_ln(stderr, "    git pull <remote> <branch>");
>>> +            fprintf_ln(stderr, "    git pull <%s> <%s>", _("remote"), _("branch"));
>>
>> I know this hunk follows I suggested, i.e. "quotes around a
>> placeholder is universal and locale independent".  However, ...
>>
>>>              fprintf(stderr, "\n");
>>>      } else if (!curr_branch->merge_nr) {
>>>              const char *remote_name = NULL;
>>>
>>>              if (for_each_remote(get_only_remote, &remote_name) || !remote_name)
>>> -                    remote_name = "<remote>";
>>> +                    remote_name = _("<remote>");
>>>
>> ... this does not.  It allows to translate the "quote around a
>> placeholder".  And where this phony "remote_name" string is used,
>> there is also this reference to <branch>:
>>
>>     fprintf_ln(stderr, _("If you wish to set tracking information for ..."
>>                     "\n"
>>                     "    git branch --set-upstream-to=%s/<branch> %s\n"),
>>                     remote_name, curr_branch->name);
>>
>> which also does.
>>
>> Perhaps the first hunk at around ll.458 would want to do
>>
>>> +    fprintf_ln(stderr, "    git pull %s %s", _("<remote>"), _("<branch>"));
>>
>> to be consistent and more flexible for the translator's needs?  The
>> quoting convention may be locale dependent after all.
>>
> If we think placeholders quoting is important for localization,

Ex-translator speaking. Context is important. If it's me, I would even
go as far as marking the whole line translatable just to give more
context (it's mostly just copy and translate a few words then). But
then again, I was half developer half translator and may see things a
bit differently. Maybe _("<remote>") is a good balance.
-- 
Duy
