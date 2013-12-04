From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Command-line git Vs IDE+plugin?
Date: Thu, 05 Dec 2013 00:10:39 +1300
Message-ID: <529F0DAF.7060800@gmail.com>
References: <vpqiovpfxd1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 04 12:10:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoALy-0007BD-Ij
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 12:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755692Ab3LDLKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 06:10:46 -0500
Received: from mail-qe0-f42.google.com ([209.85.128.42]:52493 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755506Ab3LDLKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 06:10:45 -0500
Received: by mail-qe0-f42.google.com with SMTP id b4so15169211qen.29
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 03:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=hty6EMFSQsrzoG09/mt+cB0vw0VcdfV28bZ81zCXRwI=;
        b=yVWAsWQVLYEKACuvXUO4RqcNA/JHW6OYI0z71aPi999N6ddoui/GbzA56tktwEPpJu
         a1LxUxOm+mTTHMS4bMpbbnYVie073d0x35PyThBUzTWtU3QO45gM3ySSwEjuRGlLsMia
         dWEs/w7exyQFAnoDoPc1vgnarFQixCmaHqRhNTRsWONROFgsoHSe4QQ2NI48aacPNPHQ
         JvX+2a0/9esEv9ZDddTD0y1yg1hT3L6Zaflc/nkvjPJIC6vBEvU/VEfy4oEPqYV5jsnH
         NForvog33YmtSKw8V2XXlQ9IpDiI8Tjr1N6wfrSvJYwdhe51ka4KccRellloSoPDgHsl
         8uBg==
X-Received: by 10.224.8.72 with SMTP id g8mr67034093qag.83.1386155444640;
        Wed, 04 Dec 2013 03:10:44 -0800 (PST)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id b4sm39234059qai.7.2013.12.04.03.10.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Dec 2013 03:10:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <vpqiovpfxd1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238771>

On 19/11/13 06:11, Matthieu Moy wrote:
> I was wondering whether others had similar (or not) experience. In
> particular, as a teacher, I'm wondering whether I should push my
> students towards the GUI in the IDE, or advise them to keep using the
> command-line (we teach them git with the command-line first anyway, but
> after a year of practice, we may want to show them the GUI equivalent).
> 

My $0.02 as someone who performs some part-time SCM admin tasks for a
moderately sized group of engineers (~40) with varying degrees of
experience.

Some people are scared by a command line and think poking buttons in an
IDE is preferable (and somehow safer). As others have pointed out the
first sign of trouble they shuffle over to my desk. I see the people
that are comfortable with the command line far less frequently.

I think learning the command line first does help with peoples overall
understanding. Once they have some working knowledge of the basics
introducing some of the tools that integrate with those building blocks
is much easier.

In some respects the gui/IDE is better for some tasks. For example I
don't even bother telling people about 'git add -p' because 'git gui'
provides the same functionality with an interface that is better suited
to picking chunks/lines of code to stage. Another example is Eclipse's
"annotations" which provides the same information as 'git blame' but it
is right there with the code I'm editing.

Specifically about Eclipse; I've personally found that in the days of
Ganymede/Helios the VCS integration built around SVN and the mapping of
SVN concepts to Git was imperfect (impossible?). With Juno/Indigo the
support for DVCSes in general and for Git specifically is greatly
improved but I still rarely use Eclipse to actually make commits.

- C
