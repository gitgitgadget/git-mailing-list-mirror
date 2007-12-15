From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [RFC 1/4] Add diff-diff, which compares the diffs of two commits
Date: Sat, 15 Dec 2007 18:33:07 +0100
Message-ID: <A5764757-D8D1-4B4C-B70D-4D1B0775423B@zib.de>
References: <1197737505128-git-send-email-prohaska@zib.de> <20071215170436.GA22485@atjola.homenet>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 15 18:45:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3b59-0001Ez-Eq
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 18:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbXLORpM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Dec 2007 12:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756754AbXLORpM
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 12:45:12 -0500
Received: from mailer.zib.de ([130.73.108.11]:50592 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbXLORpL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Dec 2007 12:45:11 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lBFHW18Z010958;
	Sat, 15 Dec 2007 18:36:11 +0100 (CET)
Received: from [192.168.178.21] (brln-4db82442.pool.einsundeins.de [77.184.36.66])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lBFHW0Jl008287
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 15 Dec 2007 18:32:01 +0100 (MET)
In-Reply-To: <20071215170436.GA22485@atjola.homenet>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68401>


On Dec 15, 2007, at 6:04 PM, Bj=F6rn Steinbrink wrote:

> On 2007.12.15 17:51:42 +0100, Steffen Prohaska wrote:
>> The following patch series adds experimental diff-diff support.
> [...]
>> At this point, I'm only seeking comments about the general direction=
=2E
>> The patches should not be applied to git.git.
>>
>>  - Are similar approaches already available?
>
> interdiff from patchutils. Probably interdiff would also be a better
> name than diff-diff, just to be consistent with what is already there=
=2E
> And using interdiff instead of plain diff in your script might also
> yield better results (I didn't use interdiff that often yet).


At a first glance, interdiff yields more intuitive results if it
works, but it may fail if the two patches differ to much.  I need
to play more to see how useful it is in real world examples.  I
did not know interdiff before.

At this point I'm not convinced that interdiff is exactly what I
have in mind.  For example it doesn't show differences between
commit messages of two git patches.

	Steffen
