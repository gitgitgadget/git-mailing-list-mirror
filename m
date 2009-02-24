From: John Williams <john.williams@petalogix.com>
Subject: Re: Wierd git over http behaviour
Date: Tue, 24 Feb 2009 15:45:05 +1000
Message-ID: <1d3f23370902232145g61bccd67na0024ab81627c5e6@mail.gmail.com>
References: <1d3f23370902192213g560020b3h7a2459c1439e5e5c@mail.gmail.com>
	 <7vab8hiq3o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 06:46:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbq7n-0004Ar-NZ
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 06:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbZBXFpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 00:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbZBXFpI
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 00:45:08 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:14280 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbZBXFpH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 00:45:07 -0500
Received: by wf-out-1314.google.com with SMTP id 28so2916579wfa.4
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 21:45:05 -0800 (PST)
Received: by 10.142.48.14 with SMTP id v14mr2338885wfv.227.1235454305332; Mon, 
	23 Feb 2009 21:45:05 -0800 (PST)
In-Reply-To: <7vab8hiq3o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111214>

On Fri, Feb 20, 2009 at 4:23 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> John Williams <john.williams@petalogix.com> writes:
>
>> Strange thing is, when doing an http fetch of said tree, it gets no =
updates
>> to the tree later than about Jan 13 this year, even though the tree =
itself
>> has many, many commits since then (its origin is Linus's tree and we=
 pull
>> regularly). =A0Heads created later than that date are also not visib=
le (doing
>> git branch -a) in the clone pulled over http. =A0Clones made using g=
it: are
>> fine.
>
> Most likely you would want to run git-update-server-info from
> project.git/hooks/post-update hook. =A0A sample shipped with git look=
s like:

That was it - thanks for the quick response.

John
