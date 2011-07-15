From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add a 'generation' number to commits
Date: Fri, 15 Jul 2011 16:58:36 -0700
Message-ID: <CA+55aFw2_n2NkYpm9c1JiKaX_H4W89Ridq4qzBqyamuxpODejA@mail.gmail.com>
References: <alpine.LFD.2.02.1107141126300.4159@i5.linux-foundation.org> <7v8vrz1g02.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 16 01:59:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhsHn-0003pv-Q4
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 01:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968Ab1GOX7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 19:59:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40565 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750767Ab1GOX67 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2011 19:58:59 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6FNwvYO005470
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 15 Jul 2011 16:58:58 -0700
Received: by wwe5 with SMTP id 5so1708768wwe.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 16:58:56 -0700 (PDT)
Received: by 10.216.243.203 with SMTP id k53mr3217906wer.87.1310774336177;
 Fri, 15 Jul 2011 16:58:56 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Fri, 15 Jul 2011 16:58:36 -0700 (PDT)
In-Reply-To: <7v8vrz1g02.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-104.888 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177244>

On Fri, Jul 15, 2011 at 12:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I agree this is the way to go if we _were_ to use generation number
> associated with commit objects in the longer term,

I have to say, if the main issue was "git tag/branch --contains", and
if the time-based slop approach of the patch I sent out is acceptable,
I think that we can continue to ignore generation numbers.

                            Linus
