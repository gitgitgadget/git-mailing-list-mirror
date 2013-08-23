From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] git-commit: search author pattern against mailmap
Date: Fri, 23 Aug 2013 21:47:37 +0200
Message-ID: <CALWbr2x28wrzxJ=M6meCX8G0Bh4ObvHkYGqfGTNwPjWMxgJjQg@mail.gmail.com>
References: <1377265711-11492-1-git-send-email-apelisse@gmail.com>
	<xmqqbo4opajg.fsf@gitster.dls.corp.google.com>
	<20130823183541.GB30130@sigill.intra.peff.net>
	<xmqqwqncnsaz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 21:47:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCxKh-0002cV-CH
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 21:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067Ab3HWTrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 15:47:39 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:36882 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755952Ab3HWTri (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 15:47:38 -0400
Received: by mail-qc0-f175.google.com with SMTP id m4so570832qcy.34
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=omqCgDzyr0nkFLy4rnRsDCGZ3WLFPZMEtK95fhezovQ=;
        b=qxqTLdQT3VUf0A2+qBph68xAGC3XqmK54+DBDM0OoXExQ6wbPV7JfZyjFmA1gzev8d
         kTj61FvJpbfimC4khInLnoK2BdhtOUrk+9wCVKMzSgeJH6FOjAE9T7D/4sKx9or0LTHp
         EOo30ORgLe0U3L64QjWutaBQ6Ok/h38TXotUBWj9VMTJKTS5Bw/FvSKxT6oaJSULUXJQ
         aDcOCMnQj2Wy3cM2l/prnq/4rmsd2mXlz6/pBVPLBFwp3VJdsdBkLVzATxayIhQyRurB
         6I5Sfd4JWs21N7+p0jZOaW0dsTdSKjj3PqpmK25puPJEQpFbtKtLHC0Tj+3bAW06v9Se
         M5jg==
X-Received: by 10.224.126.196 with SMTP id d4mr746983qas.62.1377287257825;
 Fri, 23 Aug 2013 12:47:37 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Fri, 23 Aug 2013 12:47:37 -0700 (PDT)
In-Reply-To: <xmqqwqncnsaz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232830>

On Fri, Aug 23, 2013 at 9:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> OK, so how about labelling it as a bugfix, like this perhaps?  We
> obviously need a test or two, though.

OK,
I will resubmit tomorrow with some tests.
