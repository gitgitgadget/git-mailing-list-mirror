From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Tue, 09 Jun 2009 12:32:57 -0700
Message-ID: <4A2EB8E9.5040207@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>	 <7vskidcf9s.fsf@alter.siamese.dyndns.org>	 <200906070932.36913.chriscool@tuxfamily.org>	 <4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>	 <4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>	 <c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>	 <c07716ae0906090526i714bb6c9g4e3d8cf61021af77@mail.gmail.com>	 <4A2E7EEC.2050807@zytor.com> <c07716ae0906091228s708058d4vea986239a6b458de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:39:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME7AX-0007nv-SW
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 21:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbZFITj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 15:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754779AbZFITj2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 15:39:28 -0400
Received: from terminus.zytor.com ([198.137.202.10]:59713 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbZFITj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 15:39:28 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n59JWve0028802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2009 12:32:57 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <c07716ae0906091228s708058d4vea986239a6b458de@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.94.2/9445/Tue Jun  9 07:42:26 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121212>

Christian Couder wrote:
>>>
>> Sort-of-kind-of.  I doubt most users will be able to recover from a
>> stuck situation, and unless we have extremely high cost of testing
>> (which is true for some applications) then expecting the user to
>> optimizing manually is really bad user design.
> 
> My opinion is that we should not penalize all the people working on
> "quite clean" projects and also people working on "not clean" projects
> who are able to recover, on the pretence that there are other people
> on these "not clean" projects who are not.
> 
> I think it's the projects maintainers' responsibility to keep their
> projects graphs quite clean (and they have the right to ask git
> developers for the tools to do that).

No, it's not.  This is saying "it's the user's responsibility to make up
for shortcomings in the tools", which is completely bass-ackwards.

> If they don't do so, then their
> users will suffer anyway. So it's not a big deal to ask them to teach
> their users to add a "--prng" option to "git bisect start" for example
> or something like that to try to work around the "not cleanliness" of
> their graphs.

Let's see... we can penalize the default user by 19% (the amount of
difference) if and only if they have skip points (at which point your
"project manager's responsibility" has already failed) or we can risk an
inexperienced user getting stuck?

	-hpa
