From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Thu, 20 Jun 2013 16:07:34 +0530
Message-ID: <CALkWK0mBYBeZ4cN203VP51RXW2=hwGGM=pXjLxuqXWu7R8M4yw@mail.gmail.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
 <1371607780-2966-3-git-send-email-rhansen@bbn.com> <7vhagu10ql.fsf@alter.siamese.dyndns.org>
 <51C203A1.4000404@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 12:38:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpcFv-0005Z7-LI
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 12:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544Ab3FTKiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 06:38:15 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35744 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756915Ab3FTKiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 06:38:15 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so15932819iet.37
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=czPhExWDkOqXrVidJ/n0aS0MAvPvcJbD99lY9SgCp5c=;
        b=PPGVcvukEOJ209WysiaA4DpBCSiac2pzjdBfmO4gw2w9Q3VrB1Q4/TfL48peFDDwZ3
         A1Tl4qhk/qulBLZ+rSd/k0+DTTPtX3e+pdXelv9VlOClzn8RVujs0Xu5ktwjEcVLd/5s
         UZBcLjdDaqrIeTz6upteUOfOg3YrjVmD641RRqJm1MEsMfhC4IgCL8mUWTwICcxV0S05
         1/nZMOLYQCm3fD4jEMBbTPsWGm7HdqogrS995cE3gPU4MJgAgRcmco1SrRI2DAaW7Jic
         wGQDNCNUXVBXya9tp8U+C+mMyMZD7Q1TcKyfCV4uDw1GV+t/dhNdFKPCrWOWMEwz+fN4
         quDQ==
X-Received: by 10.50.25.194 with SMTP id e2mr3389631igg.111.1371724694728;
 Thu, 20 Jun 2013 03:38:14 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 03:37:34 -0700 (PDT)
In-Reply-To: <51C203A1.4000404@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228477>

Richard Hansen wrote:
> In the meantime, I'll
> rework the patch series to avoid using the word "ref" when defining
> committish and tree-ish.

This is a good way forward.  I'm curious about what you're planning on
substituting it with though: the "extended SHA-1 expression" that
Jonathan hinted at?
