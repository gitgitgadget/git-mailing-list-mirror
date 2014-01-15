From: "Jason St. John" <jstjohn@purdue.edu>
Subject: Re: [PATCH] Fix typesetting in Bugs section of 'git-rebase' man page
 (web version)
Date: Wed, 15 Jan 2014 00:36:48 -0500
Message-ID: <CAEjxke9NACjYWP+v1-ZB0epJk9Hwo4g15qBPZexxVNRaKPC3Nw@mail.gmail.com>
References: <1384906483-15260-1-git-send-email-jstjohn@purdue.edu>
 <xmqqwqk37kdy.fsf@gitster.dls.corp.google.com> <CAEjxke-fPwTctUt9x_o1YwTKK2fX5TOPA7LStXUh+ejUVxZtpg@mail.gmail.com>
 <xmqq8uuj7olt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 06:37:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3JAC-0000mc-0p
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 06:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbaAOFhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 00:37:12 -0500
Received: from mailhub246.itcs.purdue.edu ([128.210.5.246]:50251 "EHLO
	mailhub246.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750718AbaAOFhK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 00:37:10 -0500
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com [209.85.216.176])
	(authenticated bits=0)
	by mailhub246.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id s0F5b8jm030585
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 15 Jan 2014 00:37:09 -0500
Received: by mail-qc0-f176.google.com with SMTP id e16so575911qcx.21
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 21:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AZ6JjSzRuoxqU/aUiQ4aej9i9cjcTlveMHCEJOGt1AE=;
        b=AeThx92N5F4WxLo3lyyeNq2NY9KB9R4/NhtK/QjXV4BEA/pKXkiqJXBkYz2BliRE3l
         pehKezAkGBhYptz/qTaIVx9v5IVejY7h37pFfxOjsmt6LvzAT7tkynP4zBvjgz1oogXA
         kEzjmSMIoY70tXDLExCSZTV0hJVBMteugr4uLwt/ZM5vva11RvgTa+6KIX3s6M1ixRVL
         peKOIn6Zgel0/OuMRXLlUXzg24b115V9J9VbEsXq86qlE7fiWmhVHlNYtFP0B22rYoaK
         00ulaCeMg8RwA6EPnCyOGQARm/S5VeB5nEYhBg7ByxSejttx1gSBC7/FrA3KNrRVBHe3
         zIQA==
X-Received: by 10.224.111.195 with SMTP id t3mr712825qap.2.1389764228665; Tue,
 14 Jan 2014 21:37:08 -0800 (PST)
Received: by 10.224.59.134 with HTTP; Tue, 14 Jan 2014 21:36:48 -0800 (PST)
In-Reply-To: <xmqq8uuj7olt.fsf@gitster.dls.corp.google.com>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240432>

On Mon, Jan 13, 2014 at 12:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Jason St. John" <jstjohn@purdue.edu> writes:
>
>> What AsciiDoc formatter (and version) do you use?
>
>     $ asciidoc --version
>     asciidoc 8.6.8
>
> Checking with www.methods.co.nz/asciidoc, I am behind by about 2
> months, it seems, though.

I just went through git-scm.com's GitHub issue tracker, and I found
that git-scm.com is, in fact, using their own AsciiDoc parser[1].

This issue, along with the other formatting issues found in
git-svn.txt and gitweb.txt, will hopefully be resolved soon, as one of
the GitHub maintainers opened an issue to update their AsciiDoc
parser[2].

[1] https://github.com/git/git-scm.com/issues/134#issuecomment-27539970
[2] https://github.com/git/git-scm.com/issues/350

Jason
