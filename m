From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 09 Jun 2013 23:42:34 +0200
Message-ID: <51B4F6CA.8020807@alum.mit.edu>
References: <20130608164902.GA3109@elie.Belkin> <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com> <20130608173447.GA4381@elie.Belkin> <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com> <20130609014049.GA10375@google.com> <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com> <20130609052624.GB561@sigill.intra.peff.net> <CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com> <20130609174049.GA1039@sigill.intra.peff.net> <CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com> <20130609181002.GC810@sigill.intra.peff.net> <CAMP44s0ky7ad3cGBQs0DNht4Uo4MR08VrNx+PigcNraDP76CLA@mail.gmail.com> <CALKQrgc5K0U2qCHjjzgxw1=70FbmHdokU3H0tfB_=+7gDVNzsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 23:42:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlnNs-00088E-K1
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 23:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab3FIVmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 17:42:40 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:51265 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750993Ab3FIVmj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 17:42:39 -0400
X-AuditID: 12074412-b7f656d00000102f-4f-51b4f6ce465b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 53.C8.04143.EC6F4B15; Sun,  9 Jun 2013 17:42:38 -0400 (EDT)
Received: from [192.168.69.140] (p57A24CDE.dip0.t-ipconnect.de [87.162.76.222])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r59LgYIK023367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Jun 2013 17:42:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CALKQrgc5K0U2qCHjjzgxw1=70FbmHdokU3H0tfB_=+7gDVNzsA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsUixO6iqHvu25ZAg/tfrSxWzXzMbtF48Sqr
	xcHHeRZdV7qZLBp6rzBbzLu7i8ni7c0ljBbdU94yWvxo6WF24PTYOesuu8ell9/ZPJ717mH0
	uHhJ2ePzJrkA1ihum6TEkrLgzPQ8fbsE7oyXD7UK2kUqPs96xtrAuEegi5GTQ0LAROJY8092
	CFtM4sK99WxdjFwcQgKXGSVufH7NBOGcY5K40dLJBFLFK6AtcebnfZYuRg4OFgFVidPLOUDC
	bAK6Eot6msFKRAXCJN4vm8oKUS4ocXLmExYQWwSofMfjX2wgNrPABSaJCw/BbGEBI4nvS68w
	Q+x6xCpx9nAPI0iCUyBQ4t3mTlaQXcwC6hLr5wlB9MpLbH87h3kCo8AsJCtmIVTNQlK1gJF5
	FaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZIFAjtYFx/Uu4QowAHoxIPr8C6
	zYFCrIllxZW5hxglOZiURHn/vtgSKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEt6AJKMebklhZ
	lVqUD5OS5mBREuf9uVjdT0ggPbEkNTs1tSC1CCYrw8GhJMFr/xWoUbAoNT21Ii0zpwQhzcTB
	CTKcS0qkODUvJbUosbQkIx4UpfHFwDgFSfEA7Z0F0s5bXJCYCxSFaD3FqMsx48fkd4xCLHn5
	ealS4rwtIEUCIEUZpXlwK2Ap7xWjONDHwrzxIFU8wHQJN+kV0BImoCVT1MGWlCQipKQaGA9/
	VNxxViHqRPMMwwlRz/weZ+2IFLXLSGq8GCEjtW9u8O6i7/7ab6zqhCZaZyj4C7O/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227172>

On 06/09/2013 09:11 PM, Johan Herland wrote:
> [...]
> FWIW, I'd like to express my support for the opinions expressed by
> Jonathan, Jeff and Thomas. They accurately describe my impression of
> these discussion threads.

I also agree.  In my opinion, Felipe, your abrasiveness, your disregard
of project standards, and your eternal argumentativeness outweigh the
benefit of your contributions, large though they may be.

Writing code is only a small part of keeping the Git project going.

* Reviewing code is an essential, more thankless, and therefore more
precious, contribution.  Therefore the Git project has standards to make
code review less unpleasant and more effective; for example: (1) patches
shouldn't cause regressions; (2) commit messages have to be written to
very high standards; (3) reviewers' comments should be accepted
gratefully and taken very seriously.  Almost everybody in the Git
community accepts these standards.  Felipe, you do not seem to.  The
result is that reviewers' time and goodwill are wasted, and they
justifiably feel unvalued.  We can't afford to misuse reviewers; they
are the bedrock (and the bottleneck) of the project.

* Gaining and keeping contributors is important to maintaining the
success of the project.  The mailing list is the main forum for the
development community; therefore, it is important that the mailing list
be a place where people display a high degree of technical excellence,
but also respect for one another, friendliness (or at least a lack of
hostility), and discussions that do turn into flame wars.  It is
possible to have a profound technical disagreement without losing
respect for the other side; contrariwise it is NOT acceptable to twist a
technical disagreement into a personal attack, even by the slightest
insinuation.  Felipe, in my opinion your participation in the mailing
list lowers the tone dramatically, and will result in loss of other
contributors and the failure to attract new contributors.

Felipe, I wish that you would devote a small fraction of your prodigious
energy to the very difficult challenge of feeling empathy,
understanding, and respect for the other members of the community.  But
if things continue the way they have, I personally would, with sadness
in my heart, prefer to forgo your patches in exchange for the more
important benefit of a more collegial (and therefore overall more
productive and sustainable) community.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
