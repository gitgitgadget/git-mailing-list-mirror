From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] t1402: Ignore a few cases that must fail
 due to DOS path expansion
Date: Fri, 14 Oct 2011 22:36:38 -0700
Message-ID: <7vwrc6x1cp.fsf@alter.siamese.dyndns.org>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
 <1318632815-29945-3-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: msysgit+bncCO3J8-q3GhDpt-T0BBoE64weGA@googlegroups.com Sat Oct 15 07:37:12 2011
Return-path: <msysgit+bncCO3J8-q3GhDpt-T0BBoE64weGA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qw0-f58.google.com ([209.85.216.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCO3J8-q3GhDpt-T0BBoE64weGA@googlegroups.com>)
	id 1REwvn-00044v-LE
	for gcvm-msysgit@m.gmane.org; Sat, 15 Oct 2011 07:37:11 +0200
Received: by qadb40 with SMTP id b40sf1806103qad.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Oct 2011 22:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=kNDnmesDXuUoCUamd+ZNra9DY4vhfaxLhBTPeinSnwo=;
        b=XTZ4HYBAS/qHBQhqoqcXRi2M2XevpOEUS9UcHjOdj/oNXlbeyzmJGkV9VzXZjAv+jN
         a69IUkDvIyM95EFVp0IiToAyK3cqmTJQoVCuGIl/tdElkcRyMVDod1M2lFfBOpJ8P0qR
         uJLAmKJQYbYz5SCgLI/HMnFVN8Go4KJ8sgmYo=
Received: by 10.224.191.6 with SMTP id dk6mr2158021qab.9.1318657001658;
        Fri, 14 Oct 2011 22:36:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.188.201 with SMTP id db9ls8312092qab.7.gmail; Fri, 14 Oct
 2011 22:36:40 -0700 (PDT)
Received: by 10.224.189.201 with SMTP id df9mr7244176qab.7.1318657000977;
        Fri, 14 Oct 2011 22:36:40 -0700 (PDT)
Received: by 10.224.189.201 with SMTP id df9mr7244175qab.7.1318657000967;
        Fri, 14 Oct 2011 22:36:40 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id j6si3229630qct.1.2011.10.14.22.36.40;
        Fri, 14 Oct 2011 22:36:40 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5454332B8;
	Sat, 15 Oct 2011 01:36:40 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BEF232B7;
	Sat, 15 Oct 2011 01:36:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D074132B6; Sat, 15 Oct 2011
 01:36:39 -0400 (EDT)
In-Reply-To: <1318632815-29945-3-git-send-email-patthoyts@users.sourceforge.net> (Pat
 Thoyts's message of "Fri, 14 Oct 2011 23:53:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8148414-F6EF-11E0-949D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio@b-sasl-quonix.pobox.com designates
 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
 dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183640>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

>  t/t1402-check-ref-format.sh |   15 +++++++++------

Didn't we see a different patch that attempts to address the same issue
recently on the list from J6t, or is this a fix for a different problem?

>  1 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
> index 710fcca..1a5e343 100755
> --- a/t/t1402-check-ref-format.sh
> +++ b/t/t1402-check-ref-format.sh
> @@ -36,7 +36,7 @@ invalid_ref 'refs///heads/foo'
>  valid_ref 'refs///heads/foo' --normalize
>  invalid_ref 'heads/foo/'
>  invalid_ref '/heads/foo'
> -valid_ref '/heads/foo' --normalize
> +test_have_prereq MINGW || valid_ref '/heads/foo' --normalize
>  invalid_ref '///heads/foo'
>  valid_ref '///heads/foo' --normalize
>  invalid_ref './foo'
> @@ -120,9 +120,12 @@ invalid_ref "$ref" --allow-onelevel
>  invalid_ref "$ref" --refspec-pattern
>  invalid_ref "$ref" '--refspec-pattern --allow-onelevel'
>  invalid_ref "$ref" --normalize
> -valid_ref "$ref" '--allow-onelevel --normalize'
> -invalid_ref "$ref" '--refspec-pattern --normalize'
> -valid_ref "$ref" '--refspec-pattern --allow-onelevel --normalize'
> +if test_have_prereq NOT_MINGW
> +then
> +	valid_ref "$ref" '--allow-onelevel --normalize'
> +	invalid_ref "$ref" '--refspec-pattern --normalize'
> +	valid_ref "$ref" '--refspec-pattern --allow-onelevel --normalize'
> +fi
>  
>  test_expect_success "check-ref-format --branch @{-1}" '
>  	T=$(git write-tree) &&
> @@ -166,10 +169,10 @@ invalid_ref_normalized() {
>  
>  valid_ref_normalized 'heads/foo' 'heads/foo'
>  valid_ref_normalized 'refs///heads/foo' 'refs/heads/foo'
> -valid_ref_normalized '/heads/foo' 'heads/foo'
> +test_have_prereq MINGW || valid_ref_normalized '/heads/foo' 'heads/foo'
>  valid_ref_normalized '///heads/foo' 'heads/foo'
>  invalid_ref_normalized 'foo'
> -invalid_ref_normalized '/foo'
> +test_have_prereq MINGW || invalid_ref_normalized '/foo'
>  invalid_ref_normalized 'heads/foo/../bar'
>  invalid_ref_normalized 'heads/./foo'
>  invalid_ref_normalized 'heads\foo'
