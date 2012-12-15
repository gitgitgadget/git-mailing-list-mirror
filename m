From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Sat, 15 Dec 2012 08:09:56 +0100
Message-ID: <50CC2244.4040103@alum.mit.edu>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org> <CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com> <7vvcc6z801.fsf@alter.siamese.dyndns.org> <CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com> <BF9B1394-0321-4F1C-AD1B-F40D02DBE71A@quendi.de> <CAMP44s3Es-rLjwe6sgOi9OmwQouM4AbFKAbGB5UgS6sUtYRgKQ@mail.gmail.com> <F151B265-7E3E-4989-AA16-EB7CAC298126@quendi.de> <CAMP44s0r_KAKt7Lm1cdumN1cOWzjab3ruYqxp-s6OR1g1qqbcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Max Horn <postbox@quendi.de>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 08:10:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjltC-0001cT-S6
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 08:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389Ab2LOHKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 02:10:02 -0500
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:62374 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751272Ab2LOHKA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Dec 2012 02:10:00 -0500
X-AuditID: 12074411-b7fa36d0000008cc-63-50cc22475ce7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A4.45.02252.7422CC05; Sat, 15 Dec 2012 02:09:59 -0500 (EST)
Received: from [192.168.69.140] (p57A247EF.dip.t-dialin.net [87.162.71.239])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qBF79vqt028628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 15 Dec 2012 02:09:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CAMP44s0r_KAKt7Lm1cdumN1cOWzjab3ruYqxp-s6OR1g1qqbcQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqOuudCbA4MUhc4uDj/Msuq50M1k0
	9F5htmi+vIHVgcVj56y77B4XLyl7TNi+l9nj8ya5AJYobpukxJKy4Mz0PH27BO6MaytXsxb0
	8lZsnL+HuYFxM1cXIyeHhICJRM/DDlYIW0ziwr31bF2MXBxCApcZJXa3z2aGcM4wSSyc/RQo
	w8HBK6At8WmVKUgDi4CqxKGzc5hBbDYBXYlFPc1MILaoQIDE4iXn2EFsXgFBiZMzn7CA2CIC
	hhJ726eC2cwCSRKvzjwB6xUWsJe4v/g+O8Suq8wSpy/sAhvEKRAo8eZqNxPIXmYBdYn184Qg
	euUltr+dwzyBUWAWkhWzEKpmIalawMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0Qv
	NaV0EyMklAV3MM44KXeIUYCDUYmHd0fE6QAh1sSy4srcQ4ySHExKorznZM8ECPEl5adUZiQW
	Z8QXleakFh9ilOBgVhLhFdsCVM6bklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV
	4eBQkuAVVQQaKliUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K0/hiYKSCpHiA9oYp
	ALXzFhck5gJFIVpPMVpyNLy88ZSR48cfEHmr4eZTRiGWvPy8VClx3m0gDQIgDRmleXDrYAnt
	FaM40PfCvGtBqniAyRBu6iughUxAC+MuHQdZWJKIkJJqYJwmKRr5IPI/0/NJ+it37T/8y9h9
	3YPkCXN+FL/L5pnnvuMmh8uU5rAqX72FqxrvTSsL4ZD74R+nXZe7KtRDJuW2R1nE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211520>

On 12/15/2012 04:14 AM, Felipe Contreras wrote:
> I'm going to say it one last time; merging this patch series either
> creates issues for the users, or not. There is a reality out there,
> independent of what you, Junio, or me think or say. And the fact is,
> that if this patch series is going to create issues for the users,
> *nobody* has pointed out why, so, since there's no evidence for it,
> the only rational thing to do is believe that there will be no issues
> for the users.
> 
> There is no known issue with the code, that is a fact. This code could
> be easily merged today, and in fact, it was merged by Junio already
> (but then reverted). There are no positive outcomes from the delay,
> only negative ones. I will address the minute issue about the extra
> cruft, eventually.

Cruft in the codebase is a problem for git *developers* because it makes
the code harder to maintain and extend.

And therefore cruft is a problem for git *users* because it slows down
future development (in whatever small amount).

Moreover, it is dangerous for a project to accept crufty code based on a
contributor's promise to clean up the code later:

* The developer might not get around to it, or might take longer than
expected.

* Until it is cleaned up, the cruft hinders other potential developers
to that code.

* The presence of cruft lowers the expectation of quality for the whole
project; cruft breeds more cruft.

It is simpler and fairer to have a policy "no crufty code" than to try
to evaluate each instance on a case-by-case basis.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
