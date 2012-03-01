From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 1 Mar 2012 23:28:12 +1100
Message-ID: <CAH5451mmvxQZc1JEZe+W8WD_QwikpELhxG1WHJAKfp6rW3DCHw@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com> <8762eoimp0.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 01 13:28:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S357g-0005Fz-BN
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 13:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759026Ab2CAM2f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 07:28:35 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35458 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759010Ab2CAM2d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 07:28:33 -0500
Received: by wgbdr13 with SMTP id dr13so523670wgb.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 04:28:32 -0800 (PST)
Received-SPF: pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.103.97 as permitted sender) client-ip=10.180.103.97;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.103.97 as permitted sender) smtp.mail=andrew.ardill@gmail.com; dkim=pass header.i=andrew.ardill@gmail.com
Received: from mr.google.com ([10.180.103.97])
        by 10.180.103.97 with SMTP id fv1mr10171140wib.17.1330604912713 (num_hops = 1);
        Thu, 01 Mar 2012 04:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=D9ci48TR/dSRXnPnIsPGf9OJYJLlYy5t/PYqsi6FYhc=;
        b=CgzM+s41h6TaY8u1L5skPcslu/8SJ7aZx4M4jf7BrgLsg/nTjqBbhZruY5GvHfkneJ
         WFzeiiL6E2y56tUKFzNDoag2LOws4jlsblCV5NcpRM9i5JNHskyfkHy6LvMciCrAdqWn
         Dq3miqELyFsn1JEgl6/0H/cCN3Bk2PpEacySc=
Received: by 10.180.103.97 with SMTP id fv1mr8131448wib.17.1330604912622; Thu,
 01 Mar 2012 04:28:32 -0800 (PST)
Received: by 10.223.96.133 with HTTP; Thu, 1 Mar 2012 04:28:12 -0800 (PST)
In-Reply-To: <8762eoimp0.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191920>

On 1 March 2012 22:29, Thomas Rast <trast@inf.ethz.ch> wrote:
> Andrew Ardill <andrew.ardill@gmail.com> writes:
>
>> I have set up a JIRA instance using Atlassian's OnDemand service,
>> available at https://git-scm.atlassian.net/
> [...]
>> As I see it (and Junio has mentioned before) we are going to need
>> people who are able to manage the issues in this system
>
> Note that you are not the first one to try. =C2=A0The most elaborate =
plan and
> writeup that I know of sits at
>
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/136500 =
=C2=A0[1]
>
> Jan "jast" Kr=C3=BCger also mentioned server issues today, so *.jk.gs=
 is
> presumably down because of that, not because gitbugs.jk.gs is no long=
er
> valid.
>
> Nevertheless, AFAIK it has never been used for "real work", so you ma=
y
> want to look into why that happened, and do something different.
>

Thanks for the links Thomas, I think the general sentiments summarised
there are echoed every time someone mentions an issue tracker on the
list. It is good to have the summary though!

I think that, to some degree, the model that most quickly arises from
the ideals of that list is inherently flawed. The git list is, almost
by definition, a fairly chaotic place. Issues get looked into because
either someone makes a loud enough noise, or someone is interested
enough in the problem. An issue tracker is a much more structured
beast, and trying to tether the two is obviously going to be
difficult.
One of the benefits of an issue tracker is that it keeps all
discussion around an issue in the one place. The driving wedge here is
that we *already* have somewhere that issues are tracked, albeit in a
less structured sense. Anything that reduces the duplication efforts
needed is a desirable thing, but more on that later.

The one thing we need to avoid is single points of failure. In my
experience, this is achieved by ensuring that people contributing
issues are able to do as much of the leg work as possible. Typically
they want to help, and are limited most by unnecessary restrictions
and lack of understanding. If the process is simple enough it becomes
much easier for new people to step in and make valuable contributions
(the mailing list is in some ways the embodiment of this). We also
need to encourage those who are willing and empower each other to be
time-effective.

I feel that is enough pontificating from me, and I am really enjoying
the discussion. Please, if you think it will work or not, visit the
site [1] - sign up if you want to - and provide feedback. I am going
to open a project to capture feedback, and anything else related that
is not directly relevant to the list, and that will probably be a good
place to test the ropes if you want to get your hands dirty. In
general, it is very hard to break things so if you would like to have
a play around with the system please let me know and get involved!

Regards,

Andrew Ardill

[1] git-scm.atlassian.net
