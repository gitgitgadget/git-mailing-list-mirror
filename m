From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Tue, 20 May 2014 16:55:49 +0200
Message-ID: <537B6CF5.4020808@alum.mit.edu>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>	<20140516084126.GB21468@sigill.intra.peff.net>	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>	<537693aee4fdd_3e4812032fcc@nysa.notmuch>	<xmqq7g5i4r48.fsf@gitster.dls.corp.google.com>	<53795c3e58f73_10da88d30829@nysa.notmuch> <xmqqha4lwj57.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 16:55:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmlSP-0002ig-6n
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 16:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbaETOzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 10:55:53 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:61050 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753319AbaETOzw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 May 2014 10:55:52 -0400
X-AuditID: 1207440d-f79c26d000000b51-40-537b6cf7074f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.0D.02897.7FC6B735; Tue, 20 May 2014 10:55:51 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0D15.dip0.t-ipconnect.de [93.219.13.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4KEtnHW012966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 20 May 2014 10:55:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <xmqqha4lwj57.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqPs9pzrY4MJkWYuDj/Msuq50M1k0
	9F5htvjR0sPswOKxc9Zddo9nvXsYPS5eUvb4vEkugCWK2yYpsaQsODM9T98ugTvjzaNF7AVL
	uCvmL7rP0sDYw9nFyMkhIWAi0fxgEhOELSZx4d56NhBbSOAyo8SlPiCbC8g+xySxYvNzZpAE
	r4C2xOXl/8AaWARUJS58nQxmswnoSizqaQayOThEBYIk/pxVhCgXlDg58wkLiC0iECex9MhZ
	VpASZgEjiXmn60FMYQFPifa2SIhNp5gkJl46zw5SzilgLTHv7ldGkBoJAXGJnsYgkDCzgI7E
	u74HzBC2vMT2t3OYJzAKzkKybBaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXS
	y80s0UtNKd3ECAlv3h2M/9fJHGIU4GBU4uGVkKoKFmJNLCuuzD3EKMnBpCTK25dYHSzEl5Sf
	UpmRWJwRX1Sak1p8iFGCg1lJhNc+GCjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQ
	WgSTleHgUJLgfZMN1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPit34YmD0gqR4
	gPZuAWnnLS5IzAWKQrSeYtTlOHXnWBuTEEtefl6qlDjvNJAiAZCijNI8uBWwZPaKURzoY2He
	PyBVPMBECDfpFdASJqAlfxdXgiwpSURISTUwOgSsFMnxrLrTHv5kv2ZEWgbvTKvX3PJv9oWH
	paa9+/lO6aqNyJ4Onamxrt8qdp2flbsoYI+Xke2aikv57oFzP7RMyuVZ+ij03GrB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249689>

On 05/19/2014 11:31 PM, Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
>> Junio C Hamano wrote:
>>>
>>> After looking at the reverse-depends list of packages, my faith is
>>> strengthened in that the Git ecosystem is truly maturing and useful
>>> third-party plug-ins will be picked up by distro packagers.
>>
>> Where is git-imerge packaged?
> 
> I didn't see it on the archive the said Ubuntu box slurps from, but
> I did not check all the other distros.
> 
> Michael, do you know what distro folks are doing with imerge?  For
> the purpose of this thread, "I do not follow distros, and I do not
> know" is a perfectly acceptable answer, but it would be very
> relevant if your answer is "I suggested these distros to include it,
> but so far they have been uncooperative and I haven't had much
> success".

I haven't heard of any Linux distros that have git-imerge packages.  I
just searched the package archives for Debian, Fedora, Gentoo, and Arch
without finding it.

OTOH I haven't suggested it to any package maintainers nor done much to
promote it after the initial flurry of publicity after GitMerge 2013
(blog posts, talk, and interview on GitMinutes).

Oh yeah, there's also this animated GIF here [1] :-)

Michael

[1] https://github.com/blog/1691-michael-haggerty-is-a-githubber

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
