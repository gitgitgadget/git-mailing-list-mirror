From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository boundaries
Date: Tue, 9 Apr 2013 23:47:40 +0530
Message-ID: <CALkWK0nF0aTLDZyPXfa=4kp=BnDPm3+_ZfMvP_6ZcimeJtzxvw@mail.gmail.com>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com> <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org> <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
 <CALkWK0k0YMWjhJQFWLv6b7kAHqRm8-Dq23gMVHYfatq1SLUDhQ@mail.gmail.com> <7vmwt7si6z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 20:18:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPd7i-00077p-Ht
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 20:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760209Ab3DISSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 14:18:22 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:54451 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3DISSV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 14:18:21 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so9070202ieb.9
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KPXtxpPYsAaCU3xDn70hzwVgaiqv0t6FEKKFGL9gxls=;
        b=JEiiOzZqDLIdGD+ZLjAG5Bb0o5nchqj9xzLLISuBdCSiVjR7Zu+tlCdG6vxr0OBOEd
         neYKSkOCS50H7tRFQcybNsgsFfgwDz3lpRumaFYRUMA+OL+qexxiZCql9RFYayxnuPlM
         cQj6WXnO7vY786wbcGeQp8hnE8wFfqcPG9R9CDZGZCIl6YyRyA9fttkuVYq4minfq2+l
         TyMhuCyVwThAS7enpASe5abKa2OtUMSo57sMC/qnQIyUF48UhZO/ga9VEFOa29Kt0qyD
         LX62XzoS5KG8oxLCjCbSQuoeUBVqN4e857C3LaaiMR6fswP5PZgKlbjQAQ8VMIfBZ7sK
         sDNQ==
X-Received: by 10.50.119.102 with SMTP id kt6mr11285423igb.12.1365531501088;
 Tue, 09 Apr 2013 11:18:21 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 9 Apr 2013 11:17:40 -0700 (PDT)
In-Reply-To: <7vmwt7si6z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220608>

Junio C Hamano wrote:
> But there are other cases to attempt to add a path that do not
> belong to our project, which do not have to involve a symbolic link
> in the leading path.

The reader is now wondering what this could possibly be, and why you
didn't send this patch earlier.  Perhaps clarify with: s/there are
cases/there may be cases/ and append "One such case that we currently
don't handle yet is a path inside another git repository in our
worktree, as demonstrated by test tXXXX.X."
