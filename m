From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Thu, 27 Feb 2014 12:18:41 +0100
Message-ID: <530F1F11.7060403@alum.mit.edu>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 12:18:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIyzL-0003nz-6T
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 12:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbaB0LSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 06:18:47 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63367 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750813AbaB0LSq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 06:18:46 -0500
X-AuditID: 12074413-f79076d000002d17-58-530f1f153070
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A3.77.11543.51F1F035; Thu, 27 Feb 2014 06:18:45 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1RBIffW028024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 06:18:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqCsqzx9s8PcEr8XtmS3MFl1Xupks
	GnqvMFssn7+GxYHFY+esu+weFy8pe3zeJBfAHMVtk5RYUhacmZ6nb5fAnTFjxT+2gjsyFSva
	37E1MDaLdzFyckgImEj8+zuHEcIWk7hwbz1bFyMXh5DAZUaJT1v3skA455kkHj+8A5Th4OAV
	0JZo/JMB0sAioCpx9811NhCbTUBXYlFPMxOILSoQLLH68gMWEJtXQFDi5MwnLCCtIgLmEq/X
	+YKEmQWKJY7N/MQOYgsLWEjcXr+CGcQWEgiQeHrrMlicUyBQYu+RdUwgrRIC4hI9jUEQrToS
	7/oeMEPY8hLb385hnsAoOAvJsllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdc
	LzezRC81pXQTIySwhXcw7jopd4hRgINRiYf3BDNfsBBrYllxZe4hRkkOJiVR3vNS/MFCfEn5
	KZUZicUZ8UWlOanFhxglOJiVRHjXMwHleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1ML
	UotgsjIcHEoSvIpyQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoOiNLwbGL0iK
	B2jvY1mQvcUFiblAUYjWU4y6HLfbfn1iFGLJy89LlRLnNQLZIQBSlFGaB7cClsZeMYoDfSzM
	awpSxQNMgXCTXgEtYQJaclSaB2RJSSJCSqqBcab73ZRadx+d6kVpH80ititc0v0xqap0hZuy
	sfHk189Zv7/nu9x7ZQLHu9d/mqadDvdlUbHguC5u1u9iN7/w1bGuxgs6fz78zNht 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242803>

On 02/26/2014 09:28 AM, Jacopo Notarstefano wrote:
> my name is Jacopo, a student developer from Italy, and I'm interested
> in applying to this years' Google Summer of Code. I set my eyes on the
> project called "git-bisect improvements", in particular the subtask
> about swapping the "good" and "bad" labels when looking for a
> bug-fixing release.

Hello and welcome!

> I have a very simple proposal for that: add a new "mark" subcommand.
> Here is an example of how it should work:
> 
> 1) A developer wants to find in which commit a past regression was
> fixed. She start bisecting as usual with "git bisect start".
> 2) The current HEAD has the bugfix, so she marks it as fixed with "git
> bisect mark fixed".
> 3) She knows that HEAD~100 had the regression, so she marks it as
> unfixed with "git bisect mark unfixed".
> 4) Now that git knows what the two labels are, it starts bisecting as usual.
> 
> For compatibility with already written scripts, "git bisect good" and
> "git bisect bad" will alias to "git bisect mark good" and "git bisect
> mark bad" respectively.
> 
> Does this make sense? Did I overlook some details?

I don't understand the benefit of adding a new command "mark" rather
than continuing to use "good", "bad", plus new commands "unfixed" and
"fixed".  Does this solve any problems?

What happens if the user mixes, say, "good" and "fixed" in a single
bisect session?

I think it would be more convenient if "git bisect" would autodetect
whether the history went from "good" to "bad" or vice versa.  The
algorithm could be:

1. Wait until the user has marked one commit "bad" and one commit "good".

2. If a "good" commit is an ancestor of a "bad" one, then "git bisect"
should announce "I will now look for the first bad commit".  If
reversed, then announce "I will now look for the first good commit".  If
neither commit is an ancestor of the other, then explain the situation
and ask the user to run "git bisect find-first-bad" or "git bisect
find-first-good" or to mark another commit "bad" or "good".

3. If the user marks another commit, go back to step 2, also doing a
consistency check to make sure that all of the ancestry relationships go
in a consistent direction.

4. After the direction is clear, the old bisect algorithm can be used
(though taking account of the direction).  Obviously a lot of the output
would have to be adjusted, as would the way that a bisect is visualized.

I can't think of any fundamental problems with a scheme like this, and I
think it would be easier to use than the unfixed/fixed scheme.  But that
is only my opinion; other opinions are undoubtedly available :-)

> There were already several proposals on this topic, among which those
> listed at https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#git_bisect_fix.2Funfixed.
> I'm interested in contacting the prospective mentor, Christian Couder,
> to go over these. What's the proper way to ask for an introduction? I
> tried asking on IRC, but had no success.

Just CC Christian on your emails to the mailing list, like I've done
with this email.  As a rule of thumb all communications should go to the
mailing list *plus* any people who are likely to be personally
interested in the topic (e.g., because they have participated in the
thread).

By the way, although "git bisect fixed/unfixed" would be a very useful
improvement, and has gone unimplemented for a lamentably long time, my
personal feeling is that it has too meat in it to constitute a GSoC
project by itself.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
