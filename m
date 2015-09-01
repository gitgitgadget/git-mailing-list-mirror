From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-p4: add "--path-encoding" option
Date: Tue, 01 Sep 2015 10:19:05 -0700
Message-ID: <xmqqr3mirrau.fsf@gitster.mtv.corp.google.com>
References: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com>
	<1441059026-66814-2-git-send-email-larsxschneider@gmail.com>
	<xmqqk2sbt5kv.fsf@gitster.mtv.corp.google.com>
	<523D2C52-893E-4A54-9DD1-2DDBCEA29960@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, tboegi@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 19:19:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWpDH-00042h-90
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 19:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbbIARTJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 13:19:09 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36731 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbIARTI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 13:19:08 -0400
Received: by pacwi10 with SMTP id wi10so1948455pac.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=QpX3tvmMDACuk8mOG1MmBOpCbbtwRTa1YQoLyeGRZAU=;
        b=A7EuPaEjQPjZbtTclkUPkjIvOOmo2Kph5qZgSVvV0E9aclgZQTRRWKGJDOYEo0zxts
         E1hqzikdY7UPpqXSTQj8VoYoY86Z5wQSil7zefZJBKoOEbEDLgkTn0z9QDAmD42g44gb
         jXCzD1qpjE1VcFuLGiW0g2yqko8WMGAsJy8RmU0Yc4rHoNH1rUHWrvVyTLD/5lpK5zGt
         aAJEvVsPocf+0er53h0075/P0vJ2YpaMOCyuJO+aByM08rcT/D4lzCsz2Zc857RHCuhh
         2cFf4ZJ/VIGO9o8mxMJJvhrnnREiJo94OtBSjGe2DFAfQGASgIC4Jj+u29uaX3UczYYC
         2aIA==
X-Received: by 10.68.103.132 with SMTP id fw4mr48869185pbb.62.1441127947668;
        Tue, 01 Sep 2015 10:19:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id s17sm18830198pdl.2.2015.09.01.10.19.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 10:19:06 -0700 (PDT)
In-Reply-To: <523D2C52-893E-4A54-9DD1-2DDBCEA29960@gmail.com> (Lars
	Schneider's message of "Tue, 1 Sep 2015 15:42:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276996>

Lars Schneider <larsxschneider@gmail.com> writes:

>> I'll move this to 9822, as 9821 is taken by another git-p4 test,
>> while queuing.
> OK. I wasn=E2=80=99t sure how this is handled. Just for my understand=
ing: As
> soon as a TC number is occupied in one of the official branches
> (master/next/pu/maint) then the next number should be used, right?

That would help me great deal (as I'd be doing that if you didn't).

> Two general questions:
>
> (1) I saw that the path encoding fix is already on =E2=80=9Cpu=E2=80=9D=
=2E What is
> more convenient for you? Do you want to get a [PATCH v4] with one
> commit including the changes mentioned above or do you want me to kee=
p
> the v3 commit and add a v4 commit on top?

The convention is to do [PATCH v$n+1] (i.e. reroll) before the topic
is merged to 'next' (i.e. while in 'pu').

When further improvements are needed after the topic is merged to
'next', we switch to incremental improvements.

> (2) Is there a CI setup for Git somewhere accessible on the Internet?
> How about building and testing Git on Travis
> (https://travis-ci.org/git/git)?

Sorry but you are asking the right question to a wrong guy ;-)

There may be people who have already arranged something like that,
who can speak up.
