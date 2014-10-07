From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 0/5] add "unset.variable" for unsetting previously
 set variables
Date: Tue, 07 Oct 2014 13:17:23 +0200
Message-ID: <5433CBC3.5010202@gmail.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com> <xmqqvbo2meg5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>,
	Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 13:17:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbSlq-0002eC-B1
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 13:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbaJGLRa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Oct 2014 07:17:30 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:36518 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbaJGLR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 07:17:29 -0400
Received: by mail-la0-f50.google.com with SMTP id s18so6070515lam.23
        for <git@vger.kernel.org>; Tue, 07 Oct 2014 04:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=rqTuIPg2zsZ2q9Pm7tBGPaRycRDSuNjyJFwAmlJY8Lk=;
        b=ZHFVOamDgjuFwF5ajHrCEKsA6qWc0F0cbUEzIrSSBHIjw1nTwuP0+Q/d+B8ONqd/0c
         LDUaFDfOlBtoewid/zAW3BXEJxUmAmYtpa4sMxcd29SD076m8ZyV7E0btOersrfF0mkz
         xkRD0w9/Xq2Rob+rig1cm7y/T7Q++k0cqw6F+F+v4JgqEZ3bt7IwuORspjT0LSUQCH67
         g+WcVai43nUZMQPktCIYeBw/dhevchbxygs/EAWRRiakqzpu9GvVW2DLhpIsv5hj4ic5
         EvutIyfIOLSVr2XkYQZY5EFTD+RmjpBjZVpyI1HNSwj45cN0TBE6UEKW1ffYrH5Lnf6Q
         /IYg==
X-Received: by 10.112.130.41 with SMTP id ob9mr3201356lbb.12.1412680647286;
        Tue, 07 Oct 2014 04:17:27 -0700 (PDT)
Received: from [192.168.130.235] ([158.75.2.130])
        by mx.google.com with ESMTPSA id 1sm6620060lao.36.2014.10.07.04.17.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 Oct 2014 04:17:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqvbo2meg5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257921>

Junio C Hamano wrote:

>   - "[config] safe =3D section.variable" will list variables that can
>     be included with the config.safeInclude mechanism.  Any variable
>     that is not marked as config.safe that appears in the file
>     included by the config.safeInclude mechanism will be ignored.

Why user must know which variables are safe, why it cannot be left to=20
Git to know which configuration variables can call external scripts?

--=20
Jakub Nar=C4=99bski
