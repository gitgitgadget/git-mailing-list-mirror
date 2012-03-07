From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Wed, 7 Mar 2012 12:18:36 -0500
Message-ID: <CABURp0q7fJLBHGGdD7EQ6pwEu=zErKHz+ZZJ5HLVe5VO2Y66gQ@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <8762eoimp0.fsf@thomas.inf.ethz.ch> <7vmx80nt68.fsf@alter.siamese.dyndns.org>
 <4F504699.3070406@gmail.com> <20120302041924.GG5248@burratino>
 <4F505F8C.70802@gmail.com> <7vsjhrfprz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 18:19:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5KVz-0005Bh-Vl
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 18:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528Ab2CGRS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 12:18:59 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48474 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755524Ab2CGRS6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 12:18:58 -0500
Received: by lahj13 with SMTP id j13so7516930lah.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 09:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=eZoidLoT120MSUi63U0MX6PEP3WpUNbmEpxh86b1mVM=;
        b=kdW7Zg+LSwmE8pIcc58sLrvRUdxwmUvWDqABGgrZcooSd37A/zgJIYqZP9Hrio/jD9
         H/y5roX/kAUU6jlQu+SYxqKhKfpWX9pd7ZOJfvfL8KIeqiPHtyT+b2cNJUqIdUA6/ME+
         I6R6XXrlVSG/5x90CdQZgbfJEzMu6hy1TJIAGsGmu0xvepGLXMTAMxJXuRPcutELH4B8
         o3VOz1ucIiSNatjipZ3afng3XL5ky/f66fdYXrQBlsEe7TpJxJYbnZXnXslPDFGpy+g2
         f+2swdXWMMdy7tj5fAcRiOtao0x7Y4F/i48h3ojUflcqsqNTFC7MpT7PYktspRs2QLcF
         IncQ==
Received: by 10.152.147.1 with SMTP id tg1mr2002247lab.22.1331140736651; Wed,
 07 Mar 2012 09:18:56 -0800 (PST)
Received: by 10.112.8.133 with HTTP; Wed, 7 Mar 2012 09:18:36 -0800 (PST)
In-Reply-To: <7vsjhrfprz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192464>

On Fri, Mar 2, 2012 at 2:03 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Neal Kreitzinger <nkreitzinger@gmail.com> writes:
>
>> I realize this is not an exact match of the git-workflow, but you ge=
t
>> the idea. =A0I'm also new to mailinglists so I'm not sure if you can
>> change part of the subject line. =A0If not, a header in the body cou=
ld
>> possibly be used.
>
> The most important information is missing from your discussion: who a=
re
> you trying to help, and what problem are you trying to solve?

Problems this could help solve (regardless of whether it's an
appropriate tool for the job):

1. Collects issues into a more concise list than the mailing list provi=
des.

2. Collects issues (and discussion) conveniently bundled with the git
source code.

3. Collects issues for off-line reference and searching.

4. Reduction of list noise, if issues in git.git turn out to be better
grep-targets than the mailing list.

5. Serves as an incubator for a git-based distributed issues tracker
Best Practice or Dire Warning, depending on how it goes.

The current mailing list bug tracker, where finding existing issues
and previous discussions is "crowd-sourced" to the list, is very
efficient for the new users, but not so efficient for the core
developers and respondents.

I doubt this idea is really workable or appropriate for git.git, for
various reasons.  But I do think a well-designed, distributed,
git-based issue tracker could be useful for many other projects.  Many
others have tried and failed, so I am probably wrong about this last
statement.   See [*1*] for a list of mostly stagnating prior art.

Phil

[*1*] http://dist-bugs.branchable.com/software/
