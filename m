From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Mon, 25 Apr 2016 10:33:20 +0200
Message-ID: <EDD0757C-2BD3-476F-B703-147D35BB1FAC@gmail.com>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com> <vpq37qeovu4.fsf@anie.imag.fr> <xmqqinz9pl3l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 10:33:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aubxQ-0002Y6-RZ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 10:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbcDYIdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 04:33:25 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38065 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbcDYIdY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 04:33:24 -0400
Received: by mail-wm0-f46.google.com with SMTP id u206so114740390wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SHj4UCGW+F6BOR5CKN3557cG2MqTAVyndfq2Gg5TrPM=;
        b=IukOxj/DbpOpEwy4iEYaYshnLup0pHZ8bIn8z0s77oqXiROQSQHpEhNyKUldSS1j2Z
         cIMXdKH6pYcNu0Ps5No5nw6588d87pcUykTO1LvUcEsBJWozqO5lnCNF0QeLaU6bL/0K
         FdtAwkwfr0aEID67RpSuQ4V+cNL2h4MLCHg2yZ4IJt+CNKXD7EIl7Ikj1ZORn2B11ejQ
         CftD+23KWvNHLXiOClK1RKEtkYcAKkcyeO1524YLFvY3U9uqDpM9WqE6BvK7Zro2tHEA
         BEdmlyTjK8+IPQQs7fdGFQIaHb2Mpq7w+5WYaX7z7zlmkI0Q0HVcFtqjDSLc9Mk+bI4d
         5nbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SHj4UCGW+F6BOR5CKN3557cG2MqTAVyndfq2Gg5TrPM=;
        b=b2DBCHJjdqOyZfRGvcO62UI3ttQm4SWnbXwFmOIiGdiPIDQQSS8AW3uwm4GmePZOb8
         vyYuJzguBD7uLwhpAetswPY45DhBe3NA9Lz0w9oOkcdq1/0aTeKjSrdSaE3gdZOYtUMn
         LHSwW5ixasPvJ6vmIGcDGZDXdSiNwjed3+nj+YVNlWQAzoctTK6axBoI3LgMsphv4cQl
         Ak/tLJstTW76LTsw7ZmFkEFnJqefAB+Sew4gcv1UkpQuizYPJmvPS8UjPrMqbI/j6XBg
         QneIq48epy9mbBl8rsn0Q4/hVUbtgFWMtSUEr8M+EYqy6lxMRPK/tZnGauJmROuSPgAs
         EeLw==
X-Gm-Message-State: AOPr4FXI+h454C7GPFyqF9asm48MeH5yqfOPCw4rvuZ1bhhOWZ9JLYNFFFN6xwuIjq+1HA==
X-Received: by 10.194.5.36 with SMTP id p4mr13241331wjp.167.1461573202475;
        Mon, 25 Apr 2016 01:33:22 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB4886.dip0.t-ipconnect.de. [93.219.72.134])
        by smtp.gmail.com with ESMTPSA id w77sm17469734wmw.10.2016.04.25.01.33.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 01:33:22 -0700 (PDT)
In-Reply-To: <xmqqinz9pl3l.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292458>


On 22 Apr 2016, at 20:14, Junio C Hamano <gitster@pobox.com> wrote:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> larsxschneider@gmail.com writes:
>> 
>>> +      if [[ "$TRAVIS_OS_NAME" = linux ]] && [[ "$CC" = gcc ]];
>> 
>> [[ is a bashism, and doesn't bring anything here compared to the POSIX
>> [ ... ], or "test" which is prefered in Git's source code.
>> 
>> The ; or the newline is not needed either.
> 
> Honestly, I didn't know that we were even trying to be pure POSIX,
> avoid bashism or GNUism, or in general to follow our shell scripting
> style in the scriptlet in the .travis.yml file.
> 
> While I feel fairly strongly about keeping the generic part generic,
> I am actually OK with things that are known to be used in a specific
> environment to be specific to that environment.
> 
> Having said all that, if we are not benefiting from using features
> beyond POSIX, then by all means we should strive to be writing our
> stuff in a portable way, as we do not have firm control over from
> where and to where people cut and paste code snippets.
> 
> And I do think bashism [[ ... ]] is *NOT* buying anything in this
> particular case, so I do agree with you that
> 
> 	if test "$TRAVIS_OS_NAME" = linux && test "$CC" = gcc
>        then
>        	...
> 
> or even
> 
> 	case "$TRAVIS_OS_NAME,$CC" in
>        linux,gcc)
>        	...
> 
> is what I would have written instead if I were writing this
> conditional.
Oh, thanks! I didn't know that "case" can process two variables :-)


> If we were to shoot for "be POSIX unless we can clearly benefit from
> being bash/gnu/linux specific in bash/gnu/linux specific parts", the
> existing scriptlets in .travis.yml file has a few things that may
> need to be cleaned up already.  There are "mkdir --parents" (POSIX
> spells it "-p"), "pushd/popd" and invocation of "tar" is very GNU
> specific in the part that appears in the case arm for "linux".
All code in the .travis.yml is quite Travis CI specific and therefore
I think portability is not really an issue. However, I agree that
the .travis.yml should follow the Git coding guidelines for 
consistency.


> There also are existing instances of "useless ;" that would want to
> be cleaned up regardless of portability issues.
Unfortunately it seems to be required. Travis CI generates a shell script
out of the yml file and I think they don't respect newlines or something...


> 
>>> +          then
>>> +          echo ""
>>> +          echo "------------------------------------------------------------------------" &&
>> 
>> I usualy avoid "echo <something-starting-with-dash>" as I'm not sure how
>> portable it is across variants of "echo". Maybe this one is portable
>> enough, I don't know. Perhaps printf, or cat << EOF ...?
> 
> Do you even need a long divider there?
I thought it is nice as it generates a visual distinctive separation
in the Travis CI output. However, Peff suggested a dedicated Documentation 
build job which makes this separation obsolete.


>> I think it makes sense to do some lightweight checks after "make doc",
>> rather than just check the return code. For example, check that a few
>> generated files exist and are non-empty, like
>> 
>> test -s Documentation/git.html &&
>> test -s Documentation/git.1
> 
> Yup, or the formatter does not give new/unknown warnings.
What do you mean by "formatter does not give new/unknown warnings"?
Can you give me a hint what I could test here in addition?


Thanks,
Lars
