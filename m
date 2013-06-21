From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [HELP] Corrupted repository
Date: Sat, 22 Jun 2013 00:45:47 +0530
Message-ID: <CALkWK0kLmdbooWUw-x+TBk-fB_XDFQzyu6Q8yb1Prsgi3FD67A@mail.gmail.com>
References: <CALkWK0mQj+x3bxbxWKuwpeMj8E8bfvyK-c2bAWna6a9Xe=nBOQ@mail.gmail.com>
 <7v7ghno2lz.fsf@alter.siamese.dyndns.org> <CALkWK0mTZqtGFp-BW9XBjX4Cm2hCZ1=P5M0a4cMBuE0v__LpZw@mail.gmail.com>
 <7vzjujl267.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 21:16:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq6oz-0005Uo-RH
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 21:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423711Ab3FUTQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 15:16:29 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:35326 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423707Ab3FUTQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 15:16:28 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk13so3575990bkc.29
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 12:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Xqa0Q0gK4cCZ8BXS/XWx+RJIQBF44qU0CVCYjS1QI14=;
        b=WyGF/IBjT9YMnm+F6DRcjrnVrp5RFeawQJm9Xrm05OwsaB1/0ulkf+oLWpjxA5a1sj
         tyzodgPKsVsjyzIIbqjZEkKRhchuMqyc/5RaSJ5hPXAl+iEpAgIbcvqxjNg15N2mWpr5
         QVlUdDhWSS9ih4Dojex3e38fa0ErYu1p3gyevS/AIsUZZuZXxi1lxfG7OzeICEFMkKNA
         C+k1crHc6sjeHALv6LQU6pakO9EH4/+Qv4P04MLnLfp6qDJccS71jWby91VtIFdKdG6r
         oMNQNksemY176KZF8HkjlmXMc4irE63B0RExNlxtJukvKUurTU/scVh/pmb+Z8ZlAgv4
         HAQA==
X-Received: by 10.204.235.197 with SMTP id kh5mr2014679bkb.172.1371842187280;
 Fri, 21 Jun 2013 12:16:27 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Fri, 21 Jun 2013 12:15:47 -0700 (PDT)
In-Reply-To: <7vzjujl267.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228655>

Junio C Hamano wrote:
> A tl;dr is that we _trust_ our refs and everything reachable from
> them has to be complete.  If that is not the case, things will not
> work, and it is not a priority to add workarounds in the normal
> codepath to slow things down.

Makes sense.

> That does not forbid an addition of "git recover-corrupted-repo"
> command, whose "assume everything might be broken" code is not
> shared with the fastpath of other commands.

I'm not looking for a kitchen-sink command: I'm looking for a
well-documented toolset to precisely fix corruptions.  We have some
corruption tests in our testsuite already: I think I'll start digging
there.

Thanks.
