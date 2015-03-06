From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH][GSoC] revision: forbid --graph and --no-walk usage
Date: Fri, 6 Mar 2015 10:37:50 +0200
Message-ID: <CAF7_NFRKetzHEB5tfENA=A-wwStwJG7yCbUKYLZos+0WSekeig@mail.gmail.com>
References: <1425582632-28273-1-git-send-email-akshayaurora@yahoo.com>
	<CAPGnZZ=WJcd=GWkMqq93RXpJz8jvqnaZctcF2Tni3qkO2vhSOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Akshay Aurora <akshayaurora@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 09:37:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTnlc-0004EY-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 09:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbbCFIhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 03:37:51 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34053 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932387AbbCFIhv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 03:37:51 -0500
Received: by igal13 with SMTP id l13so2097755iga.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 00:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=T/K5LUqtMZyaVqtdJtHQqWf7JSSnvM+1TD1rIbsqpKQ=;
        b=TDavNKNxZycgwLypKpkC8xMnW0o8D+qiDllbZFRN30n0Z4uKLr4CYXzXufb2yIwqnw
         V3AyL88QTQGIJyshZbs5JaFErPto9AMYlRJMWLW0VHZOWjodL0LxKyzpPL+enH+X3yJk
         9UH0zbCUCGL796V2fBbWI2m0I6GRFR9pOkRkIQtiAJMf7gpglD1D800JTmUNNReDkQvO
         fif07hM73iq5PxGGJ3PgDZyigcCSZ+AawRrxJ9hIV3QkcCVbcMsydvPfzcR7XUfMdN6k
         LFNTIHINuIfXwCLC43ppFFRA9J1EVNEPwsLtzx/dWkkUdbLDRe+i0i7gJc08jGuHPltj
         /6wA==
X-Received: by 10.42.44.132 with SMTP id b4mr8565872icf.73.1425631070628; Fri,
 06 Mar 2015 00:37:50 -0800 (PST)
Received: by 10.64.252.132 with HTTP; Fri, 6 Mar 2015 00:37:50 -0800 (PST)
In-Reply-To: <CAPGnZZ=WJcd=GWkMqq93RXpJz8jvqnaZctcF2Tni3qkO2vhSOw@mail.gmail.com>
X-Google-Sender-Auth: 3hvTWElQHVQP5d9FNVgWnkoGAZE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264896>

On Fri, Mar 6, 2015 at 7:08 AM, Akshay Aurora <akshayaurora@yahoo.com> wrote:
> Not sure, why this mail is not showing on Gmane.
> I used git to send the email, and tested it by sending the patch to
> myself before sending it to the list.

Gmail knows: "Why is this message in Spam? It has a from address in
yahoo.com but has failed yahoo.com's required tests for
authentication.  Learn more" Probably filtering settings are less
strict.

I guess you should use authenticated SMTP thought your email hoster,
yahoo here in git-send-email (something like --smtp-server and
--smtp-user options, it will ask for password interactively) to avoid
it.
