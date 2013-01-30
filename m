From: Marc Khouzam <marc.khouzam@ericsson.com>
Subject: RE: [feature request] git add completion should exclude staged
 content
Date: Wed, 30 Jan 2013 14:06:44 +0000
Message-ID: <E59706EF8DB1D147B15BECA3322E4BDC097A7E@eusaamb103.ericsson.se>
References: <20130126172137.GB5852@mobster.11n_AP_Router>
 <7vip6iteod.fsf@alter.siamese.dyndns.org> <5106444F.2040007@gmail.com>
 <51067487.9050505@drmicha.warpmail.net> <510684FB.80104@gmail.com>
 <5106A5CE.3000800@drmicha.warpmail.net>
 <7vd2wpxki1.fsf@alter.siamese.dyndns.org> <5106DC87.7090607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: 'Michael J Gruber' <git@drmicha.warpmail.net>,
	'wookietreiber' <kizkizzbangbang@googlemail.com>,
	"'git@vger.kernel.org'" <git@vger.kernel.org>
To: 'Manlio Perillo' <manlio.perillo@gmail.com>,
	'Junio C Hamano' <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 15:08:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0YKY-00071V-T1
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 15:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab3A3OHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 09:07:41 -0500
Received: from usevmg20.ericsson.net ([198.24.6.45]:46726 "EHLO
	usevmg20.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab3A3OHi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jan 2013 09:07:38 -0500
X-AuditID: c618062d-b7fcb6d000007ada-ec-510929273450
Received: from EUSAAHC003.ericsson.se (Unknown_Domain [147.117.188.81])
	by usevmg20.ericsson.net (Symantec Mail Security) with SMTP id 3A.06.31450.72929015; Wed, 30 Jan 2013 15:07:36 +0100 (CET)
Received: from EUSAAMB103.ericsson.se ([147.117.188.120]) by
 EUSAAHC003.ericsson.se ([147.117.188.81]) with mapi id 14.02.0318.004; Wed,
 30 Jan 2013 09:06:45 -0500
Thread-Topic: [feature request] git add completion should exclude staged
 content
Thread-Index: AQHN++mhfJpcTCjP3EKl2TzxlKhfVJhdzFlAgAECzICAADl7gIAAE52AgAAnIQD//8WNMYAAe6+AgAJnELA=
In-Reply-To: <5106DC87.7090607@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.117.188.134]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsUyuXRPoK6GJmegwbY9HBZrXpxmtui60s1k
	0dB7hdliasszRouLf7rYHVg9WidPYvbYOesuu8fTCZPZPS5eUvb4vEkugDWKyyYlNSezLLVI
	3y6BK2PZundsBX1CFdcWHWNtYNzB18XIySEhYCLxf9d3FghbTOLCvfVsXYxcHEICRxglml6e
	ZYJwljNKPJh7iR2kik1AT+LGz1tgtohAuMT6488YQYqYBaYxSnQ0PwZLCAsESjza/IERoihI
	onHKP2YIO0ni2PlbYDaLgKrE+aMLwVbzCnhLzF18CqxeSGAXk8TdR2EgNqeApsTuDVuYQGxG
	AVmJ3Wevg9nMAuISt57MZ4I4W0BiyZ7zzBC2qMTLx/9YIWxliSVP9rNA1OtILNj9iQ3C1pZY
	tvA1M8ReQYmTM5+wTGAUm4Vk7CwkLbOQtMxC0rKAkWUVI0dpcWpZbrqRwSZGYIQdk2DT3cG4
	56XlIUZpDhYlcd4g1wsBQgLpiSWp2ampBalF8UWlOanFhxiZODilGhil8pQSS1ov1M7VaXwv
	PJk9b4pLj986n4CmZVUzfpgFfHuhomlwzUZ7wRum2OC7zo8Xh+aGLk6omjFzi8remX8jDHs4
	/Yp6nwk9r1oZp3fBZm7p/A8SrwUuFDsG1SV4V1zU/D33NmPJ//tPu2vs+KMvzBa3Wx0jUMPQ
	48Rn6Wh2sHzBcWnBFiWW4oxEQy3mouJEAIBEGsh+AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215019>


> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Manlio Perillo
> Sent: Monday, January 28, 2013 3:16 PM
> To: Junio C Hamano
> Cc: Michael J Gruber; wookietreiber; git@vger.kernel.org
> Subject: Re: [feature request] git add completion should 
> exclude staged content
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Il 28/01/2013 18:52, Junio C Hamano ha scritto:
> > [...]
> > 
> > Thanks both for commenting.  I'll find time to read it over again
> > and perhaps we can merge it to 'next' and advertise it in the next
> > issue of "What's cooking" report to ask for wider testing to move it
> > forward.
> 
> Thanks.
> 
> I will try to update the patch, with your latest suggestions (avoid
> tricky POSIX shell syntax, and CDPATH issue - if I remember 
> correctly),
> and with an update for the t/t9902-completion.sh test (that I 
> completely
> missed).

Hi Manlio,

I'm trying to update git-completion.tcsh to work properly with
your nice new completion feature.  But I'm having trouble with 
the missing '/' at the end of directories.

The new logic in git-completion.bash tells bash that 'filenames'
completion is ongoing so bash will add a '/' after directories.
Sadly, tcsh won't do that, so it would be simpler if
git-completion.bash added the '/' itself.  I looked at the 
git-completion.bash script changes and I noticed that for 
bash version < 4, you have to add the '/' yourself.  
I also noticed the following comment:

 # XXX if we append a slash to directory names when using
 # `compopt -o filenames`, Bash will append another slash.
 # This is pretty stupid, and this the reason why we have to
 # define a compatible version for this function.

So I gather you would rather add a '/' all the time to deal
with older bash version transparently.  This would be great
for tcsh also.  I'm trying to figure out
when bash mis-behaves when you add the '/' all the time?
When I try it (I have bash 4.1.5(1)-release) I didn't run
into the double slash problem you mention in the comment.

I'm hoping we can straighten this out and have
git-completion.bash add the '/' all the time.

Could you explain when the problem happens?

Thanks

Marc
