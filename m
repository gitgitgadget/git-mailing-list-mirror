From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: Rebase and incrementing version numbers
Date: Thu, 19 Jan 2012 11:58:28 -0800
Message-ID: <CAJsNXTkDdHTMqmXCynT2nEYyuTmSF53RVtG2V+v7b+qcsYYufg@mail.gmail.com>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
	<CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
	<CANgJU+WWq=+BP1ZDbGY3weB5Xey2TtbryDJvz5=eMLFzNet3xQ@mail.gmail.com>
	<CADo4Y9is9mBOJaU+YRTMedTz7FfDrMFoDiqiUvQpVxQpyariPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: demerphq <demerphq@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Thu Jan 19 21:05:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnyEX-0003PU-Fh
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 21:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874Ab2ASUFN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 15:05:13 -0500
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:41882
	"HELO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932487Ab2ASUFL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 15:05:11 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jan 2012 15:05:11 EST
Received: (qmail 31360 invoked from network); 19 Jan 2012 19:58:31 -0000
Received: from unknown (209.85.212.174)
  by p3plsmtpa06-06.prod.phx3.secureserver.net (173.201.192.107) with ESMTP; 19 Jan 2012 19:58:30 -0000
Received: by wics10 with SMTP id s10so264486wic.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 11:58:29 -0800 (PST)
Received: by 10.180.104.5 with SMTP id ga5mr41203876wib.21.1327003109006; Thu,
 19 Jan 2012 11:58:29 -0800 (PST)
Received: by 10.223.61.132 with HTTP; Thu, 19 Jan 2012 11:58:28 -0800 (PST)
In-Reply-To: <CADo4Y9is9mBOJaU+YRTMedTz7FfDrMFoDiqiUvQpVxQpyariPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188830>

On Thu, Jan 19, 2012 at 10:48 AM, Michael Nahas <mike.nahas@gmail.com> =
wrote:
> On Thu, Jan 19, 2012 at 1:12 PM, demerphq <demerphq@gmail.com> wrote:
>> Stop using version numbers and start using the git sha1 of the code
>> you are using.
>>
>> Yves
>
> 1. Others in the group use SVN.
> 2. The version number needs to be increasing, to work with the curren=
t
> process. =A0SHA1's are random.
> 3. The "git sha1" for the commit/snapshot cannot be put into the
> config file, which is part of the snapshot.

Suggestion #1:  Just put $Rev$ into the file and be done with it until
the team moves over to Git (at which point you can figure something
else out).

Suggestion #2:  In your release process, put something like `sed -e
"s/@@id@@/$(date +%s)/" source-dir/config > release-dir/config`

-PJ
