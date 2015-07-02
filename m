From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 10/11] ref-filter: implement '--contains' option
Date: Thu, 2 Jul 2015 22:54:16 +0530
Message-ID: <CAOLa=ZTDn3cQf4ax4kMA+g7zDJrsHicyXZuEc72am8An=6EuGg@mail.gmail.com>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
 <1435850470-5175-1-git-send-email-karthik.188@gmail.com> <1435850470-5175-10-git-send-email-karthik.188@gmail.com>
 <vpqr3oq7abs.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 02 19:24:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAiEF-0003To-TT
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 19:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbbGBRYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 13:24:47 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36638 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbbGBRYq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 13:24:46 -0400
Received: by obdbs4 with SMTP id bs4so54194885obd.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lSB7lsswwHCJj9uvOwd/L/mikvpOG0RGLtFgrNMAhBE=;
        b=gEE5c8dHREHuWXfeIPagYO8lkX3/QqIJS8Ax7QEnAr55AcuYxFFA8qJYIM1RPgSyJT
         ZuHQCuYfRSJDWRwck3nzQm/a2MebmLm9XFU8BW3GX8N+toDm271C71sns3zJxGNzbNeC
         +sQtH8QnSumuSXTuUYJkjfwjzojCMYIX2sAbyyjd2y+ICWiiIVOpVN5epLXXmPbAzBI9
         aS9Pvjt3KoLn6Dw+a6ZesiqBmxsG1W6nn+Vvasbxnw82+yeIp8tLbqRTA5UleUhTH2F/
         ZglvRDzaaLsoeQ64WzP6HaYbPbF2G5iBvn7CR8BW8PXkcqhChRvXoeFS+tZaTF9vWPTj
         fw1w==
X-Received: by 10.202.200.11 with SMTP id y11mr30108229oif.111.1435857885860;
 Thu, 02 Jul 2015 10:24:45 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Thu, 2 Jul 2015 10:24:16 -0700 (PDT)
In-Reply-To: <vpqr3oq7abs.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273253>

On Thu, Jul 2, 2015 at 10:42 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> 'tag -l' and 'branch -l' have two different ways of finding
>> out if a certain ref contains a commit. Implement both these
>> methods in ref-filter and give the caller of ref-filter API
>> the option to pick which implementation to be used.
>
> You are reusing some code, but unlike the other patches you are not
> marking the old code as duplicated. The "duplicate code" comment both
> acts as a reminder for later, and as an indication for reviewers of
> where the code comes from.
>

Ah! I didn't really mark it cause unlike the others this isn't a
single function but rather
a whole block of code, but what you're saying makes sense.
Thanks.
