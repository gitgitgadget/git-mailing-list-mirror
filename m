From: David Aguilar <davvid@gmail.com>
Subject: Re: Git in nutshell Inbox
Date: Fri, 12 Jul 2013 17:26:01 -0700
Message-ID: <CAJDDKr6=4XvO2kr_-H9LBojC1BJa-SQ9+JnaREvyw+n1-6fUPA@mail.gmail.com>
References: <CABpATRsi-Akyv_d4xHsa0AdOdw4_P5VBpoWgx=ViWpA2Q0itPw@mail.gmail.com>
	<vpq4nc3g5l5.fsf@anie.imag.fr>
	<CABpATRt1wffDN7tC3fQpqLcHgf1M6NdhANjx+jxLhN2oa2xEZQ@mail.gmail.com>
	<20130709170239.GC7038@paksenarrion.iveqy.com>
	<CABpATRsG=n1MzpPLc2u_gOmOM9G8Ym=O0j9bTuwwkUS6F6f1mQ@mail.gmail.com>
	<20130709173857.GF7038@paksenarrion.iveqy.com>
	<51DC76E7.2080003@gmail.com>
	<CABpATRsr=50r_xWTB1bf82mYTUkU9tGrz-YedsA9wrzMUPB0Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Muhammad Bashir Al-Noimi <mbnoimi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 02:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxnfO-0003T6-RF
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 02:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757945Ab3GMA0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 20:26:03 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:51822 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab3GMA0B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 20:26:01 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so9069165pdj.26
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 17:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=65fnGZbY50j9UrCvHOeVOxmDkJ4687tP74uilnQZycg=;
        b=A9wPtMdMrGyXo6GIc2650YitO4LFRzpy6pFeB37FDYQhsdz2KbZ77ok14MiY+Z5y1W
         qVmRTLU3WwI7YXFbrCR246X7ZSK8f9xKN+/WijjFt7UZsfG2j4JzaVww3tA4zLmlj8SD
         qnoveNLfGbvPm1BoUp3hTWlCay7AL0uf6K3ki/aRHJnUPzKbms1a8rxGEceDjhLRBYtk
         u9CLWqIBUMhgars0fty29CbztpeAGd1PNihL/+RWh9PxIAWgg5Yt55Z9bbOmSHoaBz3P
         83584amPSgMGyNt7BBXwnoKUOIGHCw+9myMpdYADOMV48O6Hdr14K5VwDY63KhY0s9bt
         N8OQ==
X-Received: by 10.66.249.202 with SMTP id yw10mr45271029pac.145.1373675161181;
 Fri, 12 Jul 2013 17:26:01 -0700 (PDT)
Received: by 10.70.15.69 with HTTP; Fri, 12 Jul 2013 17:26:01 -0700 (PDT)
In-Reply-To: <CABpATRsr=50r_xWTB1bf82mYTUkU9tGrz-YedsA9wrzMUPB0Jg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230267>

On Wed, Jul 10, 2013 at 3:10 AM, Muhammad Bashir Al-Noimi
<mbnoimi@gmail.com> wrote:
> On Tue, Jul 9, 2013 at 10:47 PM, Muhammad Bashir Al-Noimi
> <mbnoimi@gmail.com> wrote:
>> Now I've to make some tests because the new version is completely different
>> than the old one so I'll send a feedback soon.
>
> Thanks guys, the recent git-cola fabulous so I don't need to use the
> terminal anymore for git.

Thanks for the kind words :-)  I'm glad you like it. (I'm the git-cola author)

I noticed that you were asking about creating new repositories so I
recently added that feature to the File menu (FIle -> New
Repository...).  That feature was previously only available in the
startup dialog that is activated when the launcher icon is clicked (or
"git-cola --prompt") so you probably found it there.

I'll probably be doing an official release later this month; you won't
see it until the PPAs and packagers pickup the new release, though.

If you're interested in trying it out I often point people to its the
Git repository -- the project is setup such that it can run directly
out of its source tree without needing to "make" or install anything.
Your machine has all of git-cola's dependencies available since you've
already installed its deb package.  All it takes to run a development
version is to clone the repo and run e.g.
$HOME/src/git-cola/bin/git-cola (assuming you've cloned the project to
$HOME/src/git-cola).

I keep the "master" branch very stable so it's quite safe to run that
version, especially if you're interested in the latest/greatest.

Best,
--
David
