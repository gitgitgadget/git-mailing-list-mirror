From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH 1/3] test-lib: Document short options in t/README
Date: Thu, 27 Mar 2014 02:39:50 -0700
Message-ID: <5333F1E6.5060009@gmail.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>	<1395650987-5960-2-git-send-email-ilya.bobyr@gmail.com>	<5330196A.3030101@ramsay1.demon.co.uk> <53306910.3090807@gmail.com> <xmqqior2mbtx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 10:40:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT6nG-0006gj-9N
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 10:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbaC0JkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 05:40:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42736 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbaC0JkC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 05:40:02 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so3234714pbb.33
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 02:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=896RSuJQnV455nCdwwilgWGUk/sfkt8fB2BwmYp6Iz8=;
        b=xFIHyCQiLEeu8sASpgX2QHnUrv7RcXzxo0oAKaGeCvAdEL2yPCxJ3ixtS/1V03JB9B
         57TA5abO2UF0k6slRgANJxkeFAL6cziThOH3FdgAPdEuJAP9kxf7HrTCQkkEdFVPRbt8
         g/n9QiQi1W8DO1AFc3MDKr6WKji4veTu9404qfP3iCLP3aZEPv+bX/N3uRZxXCBE9Y0z
         jD5j5R0DFVqu5JnjzIqqVGSyRoN6bdOyRz1TPO6UYjZE6GWnLnPz55YPlBQmVNlGe3Cd
         zFcij3T5RH41FSvMIzHK9SyEisLGjorgAmfB9ecpRM9QDJLEC6RhFaRGtqIg5zwefpmd
         xyAQ==
X-Received: by 10.66.141.144 with SMTP id ro16mr657972pab.131.1395913201690;
        Thu, 27 Mar 2014 02:40:01 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id x9sm6518591pbu.1.2014.03.27.02.40.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Mar 2014 02:40:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <xmqqior2mbtx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245269>

On 3/25/2014 10:23 AM, Junio C Hamano wrote:
> Ilya Bobyr <ilya.bobyr@gmail.com> writes:
>
>> On 3/24/2014 4:39 AM, Ramsay Jones wrote:
>>> On 24/03/14 08:49, Ilya Bobyr wrote:
>>> [...]
>>>> [...]
>>>>  
>>>> ---valgrind=<tool>::
>>>> +-v,--valgrind=<tool>::
>>> The -v short option is taken, above ... :-P
>> Right %)
>> Thanks :)
>> This one starts only with "--va", will fix it.
> Please don't.
>
> In general, when option names can be shortened by taking a unique
> prefix, it is better not to give short form in the documentation at
> all.  There is no guarantee that the short form you happen to pick
> when you document it will continue to be unique forever.  When we
> add another --vasomething option, --va will become ambiguous and one
> of these two things must happen:
>
>  (1) --valgrind and --vasomething are equally useful and often used.
>      Neither will get --va and either --val or --vas needs to be
>      given.
>
>  (2) Because we documented --va as --valgrind, people feel that they
>      are entitled to expect --va will stay forever to be a shorthand
>      for --valgrind and nothing else.  The shortened forms will be
>      between --va (or longer prefix of --valgrind) and --vas (or
>      longer prefix of --vasomething).
>
> We would rather want to see (1), as people new to the system do not
> have to learn that --valgrind can be spelled --va merely by being
> the first to appear, and --vasomething must be spelled --vas because
> it happened to come later.  Longer term, nobody should care how the
> system evolved into the current shape, but (2) will require that to
> understand and remember why one is --va and the other has to be --vas.
>
> We already have this suboptimal (2) situation between "--valgrind"
> and "--verbose" options, but a shorter form "v" that is used for
> "verbose" is so widely understood and used that I think it is an
> acceptable exception.  So
>
>          --verbose::
>         +-v::
>                 Give verbose output from the test
>
> is OK, but "--valgrind can be shortened to --va" is not.

Sure, this is exactly what I meant, but I guess, I was too short
so it created ambiguity =)
I was going to just remove the '-v' from '--valgrind'.

Shortening is a separate issue.  I did not look at it.
I can see that it is also not documented.   At the same time
shortening is entirely consistent at the moment, and does not
work for options that take arguments.

My main intent was to document '-r' :)
As no other short form were documented, I had to fix that issue
first.

If there is decision on how shortening should work for all the
options, maybe I could add a paragraph on that and make existing
options more consistent.

I guess the questions would be, should it possible to use short
forms for options that take arguments?

If so, '--valgrind' becomes impossible to shorten because there
is '--valgrind-only' that is a separate option.  Same for
'--verbose'  and '--verbose-only'.

For convenience here is the relevant switch in the way it is
right now:

    case "$1" in
    -d|--d|--de|--deb|--debu|--debug)
        debug=t; shift ;;
   
-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
        immediate=t; shift ;;
   
-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
        GIT_TEST_LONG=t; export GIT_TEST_LONG; shift ;;
    -r)
        shift; test "$#" -ne 0 || {
            echo 'error: -r requires an argument' >&2;
            exit 1;
        }
        run_list=$1; shift ;;
    --run=*)
        run_list=$(expr "z$1" : 'z[^=]*=\(.*\)'); shift ;;
    -h|--h|--he|--hel|--help)
        help=t; shift ;;
    -v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
        verbose=t; shift ;;
    --verbose-only=*)
        verbose_only=$(expr "z$1" : 'z[^=]*=\(.*\)')
        shift ;;
    -q|--q|--qu|--qui|--quie|--quiet)
        # Ignore --quiet under a TAP::Harness. Saying how many tests
        # passed without the ok/not ok details is always an error.
        test -z "$HARNESS_ACTIVE" && quiet=t; shift ;;
    --with-dashes)
        with_dashes=t; shift ;;
    --no-color)
        color=; shift ;;
    --va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
        valgrind=memcheck
        shift ;;
    --valgrind=*)
        valgrind=$(expr "z$1" : 'z[^=]*=\(.*\)')
        shift ;;
    --valgrind-only=*)
        valgrind_only=$(expr "z$1" : 'z[^=]*=\(.*\)')
        shift ;;
    --tee)
        shift ;; # was handled already
    --root=*)
        root=$(expr "z$1" : 'z[^=]*=\(.*\)')
        shift ;;
    *)
        echo "error: unknown test option '$1'" >&2; exit 1 ;;
    esac


P.S.  Sorry it takes me this long to reply.  I will try to be
more responsive, should there will be a discussion :)
