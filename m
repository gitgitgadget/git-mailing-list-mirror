From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (Jun 2014, #02; Fri, 6)
Date: Tue, 10 Jun 2014 13:03:39 +0200
Message-ID: <CALKQrgdc+52JA1XX3TQfc4=6AJ5QWXOxQ-zxux+Eh=x=jrHxBQ@mail.gmail.com>
References: <xmqqfvjhpsn9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 13:03:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuJqI-00073X-BF
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 13:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbaFJLDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 07:03:46 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:63395 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaFJLDp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 07:03:45 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WuJqB-000H7r-FF
	for git@vger.kernel.org; Tue, 10 Jun 2014 13:03:43 +0200
Received: by mail-ob0-f178.google.com with SMTP id wn1so409177obc.23
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 04:03:39 -0700 (PDT)
X-Received: by 10.60.178.243 with SMTP id db19mr31785051oec.11.1402398219687;
 Tue, 10 Jun 2014 04:03:39 -0700 (PDT)
Received: by 10.182.245.41 with HTTP; Tue, 10 Jun 2014 04:03:39 -0700 (PDT)
In-Reply-To: <xmqqfvjhpsn9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251177>

On Sat, Jun 7, 2014 at 12:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * jh/submodule-tests (2014-04-17) 1 commit
>  - t7410: 210 tests for various 'git submodule update' scenarios
>
>  What's the status of this one?

More or less abandoned. It was an experiment to try to understand the
interaction of the many variables that affect the behavior of 'git
submodule update'. The experiment raised some questions which were
discussed in the ensuing thread [1]. There is AFAIK ongoing work by
Jens to develop a more substantial test framework for submodules [2].
That work will certainly overlap (and preferably supersede) my tests.
I have not found the time to look more at that effort.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/246312
[2]: http://thread.gmane.org/gmane.comp.version-control.git/245048/focus=245046


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
