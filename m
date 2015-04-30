From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] blame: add blame.showemail config option
Date: Thu, 30 Apr 2015 17:33:30 -0400
Message-ID: <CAPig+cQ1JNeg5eoJib07nc6UrREE80pssokbk+xthXTXDcQz1g@mail.gmail.com>
References: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
	<CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
	<CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
	<xmqqwq0xwige.fsf@gitster.dls.corp.google.com>
	<CAPig+cRTfB9aiinhSJp=jY7-__6dRvfAqhWZYVN3+Ut=Y79LcQ@mail.gmail.com>
	<xmqqmw1svigd.fsf@gitster.dls.corp.google.com>
	<CACfD1vtfO_rqr4wv4oHm7W7DSn-Gk-du6nCuJzYvpPXK_d=y=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Quentin Neill <quentin.neill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 23:33:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynw5Q-0003De-3i
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 23:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbbD3Vdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 17:33:31 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33060 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbbD3Vda (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 17:33:30 -0400
Received: by igbpi8 with SMTP id pi8so18914751igb.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/kDDHPKbmnswS3CaeqbJi/ucPd/5n/SFT62zIZrxrM8=;
        b=miUCPN05wGlJ5RolwzN6XFoeIfFdOsKTxR8RGZR1efSqP0OJK7NFQPMtQpHVRS/l91
         IfMzkSxrs/DueroxPiuLGJPZVZw+faFFyowe+ogEV6Ob3/BuQNEghH0CL0B7z7hH+mrI
         lAVCu0RNNgJHZCOCH/QZRlnmZ42Ao9lhSe+3nKHWLov9ELZUZy57KzfnZ+by73oA02Jw
         gph6StWNDNmiI+kyMWnJ08dRnWfOEHF5+7xBdqBKotYU8t8GiU5PJR5WA2UUVjk0V3Xo
         5c/X6A4y5JTpb2nnMtRVGodyyE3Oc5XIbXH1Kb2CnRaZ+/56hwUBRMbVQmxuIFkV1I7i
         UNWA==
X-Received: by 10.42.67.80 with SMTP id s16mr11365127ici.25.1430429610363;
 Thu, 30 Apr 2015 14:33:30 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 30 Apr 2015 14:33:30 -0700 (PDT)
In-Reply-To: <CACfD1vtfO_rqr4wv4oHm7W7DSn-Gk-du6nCuJzYvpPXK_d=y=g@mail.gmail.com>
X-Google-Sender-Auth: coUe8lIiitJ15IGsGjeyfgmSaoA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268107>

On Thu, Apr 30, 2015 at 10:03 AM, Quentin Neill <quentin.neill@gmail.com> wrote:
> I'm thinking of a test file that will test all the git blame options,
> but for this
> patch it will only test the new showEmail config.  I read t/README and
> tentatively named the new test file "t/8009-blame-config.sh".

I'm not sure that these new proposed tests warrant a new test script.
Moreover, the tests presumably will be testing combinations of
configuration options and command-line switches, so having "config" in
the script name doesn't seem quite correct.

t8002-blame.sh already contains a test for --show-email, so it may be
logical to add the new tests there, alongside the existing one. On the
other hand, if you do add a new test script, then perhaps the existing
--show-email test in t8002-blame.sh should be moved to the new script.
