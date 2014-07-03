From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: t5150-request-pull.sh fails on newest master in Debian
Date: Fri, 4 Jul 2014 01:02:14 +0200
Message-ID: <CAA787rkrZ8o=oN3VmvwLR89KfjAY95qwjJdMbbUUM4+fYfQdow@mail.gmail.com>
References: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
	<1404425782.3109.12.camel@stross>
	<CAA787rmroFsjk9=ar0e_4o3hUpfDBi+9J4nrNyHHMZq-5q4skw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 01:02:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2q1F-0002BF-MJ
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 01:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759718AbaGCXCR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2014 19:02:17 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:51321 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767AbaGCXCR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2014 19:02:17 -0400
Received: by mail-la0-f42.google.com with SMTP id pn19so654079lab.29
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 16:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=7Mk3eDKGs/RvseTXrW/VootPRwq4WlXgkX390h2vwVU=;
        b=EXpr/Ybwd8vN2mx00hrKd2R82Czfqtm6mnNROn2fGcYaIkQ3cvpGrfIzudhXxUnEJ1
         FJe5DFcxAnNF4StNUvAzErTnOuwPqdWyQcIK7NDBjX9iFb4TAeaz9wa+c8iKB9xEHU0Y
         efZ24eBoPc1OgAF5wXbyjFUOZgWpOKyWqPzi4+QYKAgaIsfZQVtYnrDveiN+IP7i/9+g
         D9MJFZMSLw7jfrAnEqop2ACsvf/80KG4cBofkqrMJsJJkrnv2w+542Z/sHRCPwu1bfcx
         +ZA2SjY0uhrgsq1rQnZ0vlU+HH8TAcXZsQPtdBGgLqS56x9Viy9alWFnWTzeGlWqT45P
         PabA==
X-Received: by 10.152.179.131 with SMTP id dg3mr5431406lac.21.1404428534934;
 Thu, 03 Jul 2014 16:02:14 -0700 (PDT)
Received: by 10.112.142.7 with HTTP; Thu, 3 Jul 2014 16:02:14 -0700 (PDT)
In-Reply-To: <CAA787rmroFsjk9=ar0e_4o3hUpfDBi+9J4nrNyHHMZq-5q4skw@mail.gmail.com>
X-Google-Sender-Auth: fzRebAwQ3evGi5T66hiXU2-6NZ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252889>

On 4 July 2014 00:34, =C3=98yvind A. Holm <sunny@sunbase.org> wrote:
> On 4 July 2014 00:16, David Turner <dturner@twopensource.com> wrote:
> > On Thu, 2014-07-03 at 23:55 +0200, =C3=98yvind A. Holm wrote:
> > > When compiling newest master (v2.0.1-472-g6f92e5f) on Debian 7.5
> > > (64-bit), t5150-request-pull.sh fails when compiling with
> > > [...]
> >
> > Interesting!  I wonder if the problem is with the compiler or with
> > my code.  I don't happen to have a Debian box handy; would it be
> > possible for you to compile refs.c to assembly language (gcc -S) an=
d
> > send me the output?  That would help me track down the problem.
> >
> Sure! I have attached refs.s from v2.0.1-472-g6f92e5f .

If someone else is interested in the assembly output, it's available
from <http://sunbase.org/t5150-fail/refs.s.gz>. Didn't send it to the
list, it's 128KB.

Cheers again,
=C3=98yvind
