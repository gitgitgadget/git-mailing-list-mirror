From: David Michael Barr <davidbarr@google.com>
Subject: Re: [linux.conf.au] VCS Interoperability
Date: Sun, 22 Jan 2012 14:39:07 +1100
Message-ID: <CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
	<CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 04:39:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RooGy-0000MQ-Qn
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 04:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab2AVDjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Jan 2012 22:39:10 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44637 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab2AVDjJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2012 22:39:09 -0500
Received: by ggnb1 with SMTP id b1so923031ggn.19
        for <git@vger.kernel.org>; Sat, 21 Jan 2012 19:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-system-of-record:x-gm-message-state:content-type
         :content-transfer-encoding;
        bh=Uz5lcSBFKFHbsC/zBhYP0sNlWZPfG9xnlJ6e2RrPJJ4=;
        b=v3+Hd61Hv/7Mqa8PG8Rup0H6HbpcXtKrAl3n97S+QW4rCytgtKt9VBE/CnedBiAtcn
         x2UzrxSgMYuOP3cgitARVCatp/HVjA51RYjrkWYZQtUYJGdINbvUH4cjk1FyajXDYj83
         7d/rfpaxD+3qvwUpk4W6+QkRgE2zmMlcSC4I4=
Received: by 10.236.124.206 with SMTP id x54mr4931389yhh.112.1327203548074;
        Sat, 21 Jan 2012 19:39:08 -0800 (PST)
Received: by 10.236.124.206 with SMTP id x54mr4931376yhh.112.1327203547947;
 Sat, 21 Jan 2012 19:39:07 -0800 (PST)
Received: by 10.101.144.22 with HTTP; Sat, 21 Jan 2012 19:39:07 -0800 (PST)
In-Reply-To: <CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQnIYbOZlKCsB58rjTWIOnGSD9SUSPoZikzUIyYQGSrAVX3WgS7jUurSehnmJUMLTqTpULKD+4TJd0FUM4WYNmMt+dAF6TJMWeNDkxX9gqDiTD3Ir/o8k2L2U0jNffg9hPtwxrLpbo10+ptjRK8VxlotTizk/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188943>

Hi all,

>> Next week, I'll be presenting =A0a summary of the past 2 years work
>> on improving svn interoperability for git.
>> I'm requesting feedback from anyone who cares with regard to
>> what they'd like to hear about.
>
> Nice. =A0As a lay person attending the conference, here are a few thi=
ngs
> I think I'd like to hear:
> - Why this project is so challenging compared to say, a git-hg bridge
> or a git-darcs bridge. =A0What makes Subversion especially hard to de=
al
> with?
> - What is the biggest motivation for developing the svnrdump/ svnrloa=
d
> combination? =A0Are there any other usecases for the tools?
> - How has this project contributed to the development of the
> fast-import infrastructure? =A0Can these changes be used to improve
> other/ future remote helpers?
> - You've spoken about exporting Subversion history to Git so far, but
> what about the reverse? =A0Which parts of the picture are still missi=
ng?

Thank you for the feedback, it helped a lot with picking a trajectory.

Video is now available: http://youtu.be/0hVuv-wv4Dw
Slides: http://barrbrain.github.com/vcs-interoperability.html

It was my first conference presentation so the usual caveats apply.
I was fortunate to have a small but interested audience.

I look forward to constructive criticism so that I can better represent
our community to the folk Down Under.

--
David Barr
