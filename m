From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2015, #04; Mon, 13)
Date: Tue, 14 Jul 2015 19:54:28 +0530
Message-ID: <CAOLa=ZQDvXrLBk11a5yS-EBOHNFXmR4o0yWDWS2SvgmRKC1Afg@mail.gmail.com>
References: <xmqqtwt7ybgi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 16:25:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF18v-0002Ey-Mh
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 16:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbbGNOY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 10:24:59 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35380 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbbGNOY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 10:24:58 -0400
Received: by oihq81 with SMTP id q81so7462325oih.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uUdZmXxgnJzkuqiR/ubVn102MNzPRmBTFHBiH2NeEq8=;
        b=HJEfnyBEzWWTZ3jyLQIWyCADyOfgYXB6G40CZMP2pAH1llLrD7KwkFP4V4qIE0oz+m
         gUhM91XEjswXwsvYAhmRWJSjbTmXU/W+w3oATL0Uo7Lbagzk8OIopWg53c548ESTGfv8
         umdaSZMoxA0XQxAWS3vXPkFZ8jrmrIZf0jdpeZYj8Hb7wZ7WOQ2lnAIVnXFOLJmhnema
         QvBcy4NL/F7WoZoDVo88MfEJ3PwnHSouiMNAhZyFsTm0qsccY0ieLpgZ6kgKUh5Qg98d
         wZad4QpGeIpsohhgHyrvkjgdZNXEHnzprSwpBTJ2xhsJVJC5+tdHTDaRa7UA/zNDK0Wq
         gojQ==
X-Received: by 10.202.180.133 with SMTP id d127mr34158889oif.104.1436883897761;
 Tue, 14 Jul 2015 07:24:57 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 14 Jul 2015 07:24:28 -0700 (PDT)
In-Reply-To: <xmqqtwt7ybgi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273962>

On Tue, Jul 14, 2015 at 3:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * kn/for-each-tag-branch (2015-07-13) 11 commits
>  - for-each-ref: add '--contains' option
>  - ref-filter: implement '--contains' option
>  - parse-options.h: add macros for '--contains' option
>  - parse-option: rename parse_opt_with_commit()
>  - for-each-ref: add '--merged' and '--no-merged' options
>  - ref-filter: implement '--merged' and '--no-merged' options
>  - ref-filter: add parse_opt_merge_filter()
>  - for-each-ref: add '--points-at' option
>  - ref-filter: implement '--points-at' option
>  - tag: libify parse_opt_points_at()
>  - t6302: for-each-ref tests for ref-filter APIs
>  (this branch uses kn/for-each-ref.)
>
>  Was the GPG prereq the only thing that needed fixing?
>

Yes! That was the only change required, unless someone has
something to add :)

-- 
Regards,
Karthik Nayak
