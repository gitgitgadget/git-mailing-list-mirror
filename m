From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [RFC PATCH] Makefile: Turn off the configure target by default
Date: Tue, 12 Oct 2010 11:10:18 +0200
Message-ID: <AANLkTikG1U7CztwcbyDcsqsmeO9QXC2sA3e60mT_pL-7@mail.gmail.com>
References: <36e21bdafd75e95f1e13437f81067c71c7390408.1286783121.git.git@drmicha.warpmail.net>
	<AANLkTikb2vDMXLa48QsDfK6grczmqC1uk1jYi0ZFq9QC@mail.gmail.com>
	<4CB2FEB8.3050705@drmicha.warpmail.net>
	<201010111718.39996.jnareb@gmail.com>
	<4CB32D15.4080204@drmicha.warpmail.net>
	<AANLkTimAj_sCquCixmTOEV5ZaQVbbv-yvm=Yw82har1t@mail.gmail.com>
	<20101011162638.GH25842@burratino>
	<4CB41D50.9020208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 12 11:10:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5asM-000071-0m
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 11:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756833Ab0JLJKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 05:10:20 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44094 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914Ab0JLJKT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 05:10:19 -0400
Received: by qyk5 with SMTP id 5so517491qyk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=150z86jyfJ77hKUMHbz/AmCj2Bm66REg1GF+t/hjguc=;
        b=RNPyfgIu43k8bJS+UqeHgABfHaFnXJ+IAxLdw+2m9qE9EfHwhn05F65i/Ovn2sLwaU
         N/jmDzV7G+zEM/Sx7fzSwBzhfVnKm2omYcLWQnbELf1ite1cy84sxrFF2MxHChUfu/Yg
         l1r9WcFaxIzPs3JDT3ZFxy9JwdAgJtHe18PLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=gW0Ini9iKW3hZ+OxdUJgOMV+EqREklQ2gN+3MXbj4VHeQPkzSyYo51twCwcOWG8vbc
         iwx0pDYOYsZpYI+TGWCwxfXk0BqB2m+EDcJ9ailwU6wBZMulTnb3YDUWr0T1H1r4QLf8
         NM8orsDj86coUCF23iZXtbdEUHV2hnXPzHRDg=
Received: by 10.229.70.204 with SMTP id e12mr6052045qcj.113.1286874618215;
 Tue, 12 Oct 2010 02:10:18 -0700 (PDT)
Received: by 10.229.66.157 with HTTP; Tue, 12 Oct 2010 02:10:18 -0700 (PDT)
In-Reply-To: <4CB41D50.9020208@drmicha.warpmail.net>
X-Google-Sender-Auth: yVltO1onksBlc7cTS7-KxGzcwhY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158825>

On Tue, Oct 12, 2010 at 10:33, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
[configure etc]
> That thread was just the hair-trigger, so to say, there were many others
> in the past. But it's very typical. We often have "Don't use configure -
> it's second class"-type answers to build problems. I don't really
> remember that many "I use configure, and it works here"-type answers.
>
> Given the vigorous defense showing up here against deprecating configure
> (in the sense of declaring it second class), we can all be confident
> that there will be many knowledgeable and helpful answers to build
> problems for configure users, right?

At the moment './configure; make' works better than just 'make' on
Tru64 and AIX platforms. I have patches somewhere to improve just
'make' on those platforms but I haven't gotten around to post them yet
(need some polishing, or at least re-check against current .git). One
reason I figured it's no hurry is that ./configure actually takes care
of things there for now.

(The series posted by Gary from The Written Word, and mostly included
by now I think, was mainly based on TWW using configure on all
platforms btw. IIRC.)

-Tor
