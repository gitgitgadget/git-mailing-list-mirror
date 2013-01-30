From: Marc Khouzam <marc.khouzam@ericsson.com>
Subject: RE: [feature request] git add completion should exclude staged
 content
Date: Wed, 30 Jan 2013 18:55:35 +0000
Message-ID: <E59706EF8DB1D147B15BECA3322E4BDC097E39@eusaamb103.ericsson.se>
References: <20130126172137.GB5852@mobster.11n_AP_Router>
 <7vip6iteod.fsf@alter.siamese.dyndns.org> <5106444F.2040007@gmail.com>
 <51067487.9050505@drmicha.warpmail.net> <510684FB.80104@gmail.com>
 <5106A5CE.3000800@drmicha.warpmail.net>
 <7vd2wpxki1.fsf@alter.siamese.dyndns.org> <5106DC87.7090607@gmail.com>
 <E59706EF8DB1D147B15BECA3322E4BDC097A7E@eusaamb103.ericsson.se>
 <51096543.9050100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: 'Junio C Hamano' <gitster@pobox.com>,
	'Michael J Gruber' <git@drmicha.warpmail.net>,
	'wookietreiber' <kizkizzbangbang@googlemail.com>,
	"'git@vger.kernel.org'" <git@vger.kernel.org>
To: 'Manlio Perillo' <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 19:56:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cpE-00011N-W0
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538Ab3A3Szj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:55:39 -0500
Received: from usevmg20.ericsson.net ([198.24.6.45]:56705 "EHLO
	usevmg20.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab3A3Szi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jan 2013 13:55:38 -0500
X-AuditID: c618062d-b7fcb6d000007ada-8f-51096ca96cc8
Received: from EUSAAHC002.ericsson.se (Unknown_Domain [147.117.188.78])
	by usevmg20.ericsson.net (Symantec Mail Security) with SMTP id 34.2C.31450.9AC69015; Wed, 30 Jan 2013 19:55:37 +0100 (CET)
Received: from EUSAAMB103.ericsson.se ([147.117.188.120]) by
 EUSAAHC002.ericsson.se ([147.117.188.78]) with mapi id 14.02.0318.004; Wed,
 30 Jan 2013 13:55:36 -0500
Thread-Topic: [feature request] git add completion should exclude staged
 content
Thread-Index: AQHN++mhfJpcTCjP3EKl2TzxlKhfVJhdzFlAgAECzICAADl7gIAAE52AgAAnIQD//8WNMYAAe6+AgAJnELCAAJ5KgP//sNnw
In-Reply-To: <51096543.9050100@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.117.188.134]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsUyuXSPn+7KHM5AgyPvNSzWvDjNbNF1pZvJ
	oqH3CrPF1JZnjBYX/3SxO7B6tE6exOyxc9Zddo+nEyaze1y8pOzxeZNcAGsUl01Kak5mWWqR
	vl0CV8bfg+eYC3bKV6w53c/UwPhdoouRk0NCwETi94EzzBC2mMSFe+vZuhi5OIQEjjBKNK25
	zQjhLGeUOHTsNStIFZuAnsSNn7fYQWwRAX2JDVenMIMUMQvsYZT4u2M/WJGwQKDEo80fGCGK
	giQap/xjhrDzJI4t+gJWwyKgKrGh/xgTiM0r4C3xd1kX1OrZzBJb5l8Ea+YU0JR4/LUBzGYU
	kJXYffY6WAOzgLjErSfzmSDuFpBYsuc81A+iEi8f/2OFsJUlljzZzwJRryOxYPcnNghbW2LZ
	wtfMEIsFJU7OfMIygVFsFpKxs5C0zELSMgtJywJGllWMHKXFqWW56UYGmxiBMXZMgk13B+Oe
	l5aHGKU5WJTEeYNcLwQICaQnlqRmp6YWpBbFF5XmpBYfYmTi4JRqYGRlCTqitoFj0XZvM5+7
	Evef9/9onP2QWbFj9zm21I0rRO7bFCc4fyw/d+DAgireCTziv1oaiip3xW3sPJi0ojP5aO6U
	2V+WX1ruPLVUZXL/Ws8FDmmf3frTQxSCNL6GPDJ+cnR949yrvZ3iK86Ur+H09TQOMK72XKVv
	eSkmRfF/qYuGUdAcNSWW4oxEQy3mouJEAGLyp2h/AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215056>


> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Manlio Perillo
> Sent: Wednesday, January 30, 2013 1:24 PM
> To: Marc Khouzam
> Cc: 'Junio C Hamano'; 'Michael J Gruber'; 'wookietreiber'; 
> 'git@vger.kernel.org'
> Subject: Re: [feature request] git add completion should 
> exclude staged content
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Il 30/01/2013 15:06, Marc Khouzam ha scritto:
> > [...]
> >> I will try to update the patch, with your latest suggestions (avoid
> >> tricky POSIX shell syntax, and CDPATH issue - if I remember 
> >> correctly),
> >> and with an update for the t/t9902-completion.sh test (that I 
> >> completely
> >> missed).
> > 
> > Hi Manlio,
> > 
> 
> Hi.
> 
> > I'm trying to update git-completion.tcsh to work properly with
> > your nice new completion feature.  But I'm having trouble with 
> > the missing '/' at the end of directories.
> > 
> > The new logic in git-completion.bash tells bash that 'filenames'
> > completion is ongoing so bash will add a '/' after directories.
> > Sadly, tcsh won't do that, so it would be simpler if
> > git-completion.bash added the '/' itself.  I looked at the 
> > git-completion.bash script changes and I noticed that for 
> > bash version < 4, you have to add the '/' yourself.
> 
> The compatible version is not only required for Bash; you can 
> use it for
> other shells.
> 
> Try to redefine the __git_index_file_list_filter function to use the
> version that adds a slash to directory names.

I hadn't thought of that!
Although I would prefer not to have special cases like that,
it does work well.
Thanks!

> > I also noticed the following comment:
> > 
> >  # XXX if we append a slash to directory names when using
> >  # `compopt -o filenames`, Bash will append another slash.
> >  # This is pretty stupid, and this the reason why we have to
> >  # define a compatible version for this function.
> > 
> > So I gather you would rather add a '/' all the time to deal
> > with older bash version transparently.  This would be great
> > for tcsh also.  I'm trying to figure out
> > when bash mis-behaves when you add the '/' all the time?
> > When I try it (I have bash 4.1.5(1)-release) I didn't run
> > into the double slash problem you mention in the comment.
> > 
> 
> I'm using the same version: 4.1.5(1), on Debian stable.
> 
> > I'm hoping we can straighten this out and have
> > git-completion.bash add the '/' all the time.
> > 
> > Could you explain when the problem happens?
> > 
> 
> Bash 4.1.5(1) always adds an additional slash for directories.
> I have tested it right now: change the filter function to use the
> compatible version:
> 
> __git_index_file_list_filter ()
> {
> 	# Default to Bash >= 4.x
> 	__git_index_file_list_filter_compat
> }
> 
> 
> Then running `git add <TAB>` inside the git repository, I get 
> this file
> completion list:
> 
> $ git add <TAB>
> contrib//

Ok, I see.  The double-slash is visible in the completion list
but it does not appear on the command-line when bash automatically
adds it.  So if you typed 
  git add contri<tab>
you will properly get
  git add contrib/
That is the case I was looking at.
I understand why you cannot put that second slash in the code now.

Thanks

> 
> 
> > Thanks
> > 
> 
> 
> Thanks to you
> 
> Manlio
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAlEJZUMACgkQscQJ24LbaUQUGACgkMG/bZrJKBzlZ8toEQwmggQX
> m9kAn2ATJbSp87kOkoCCc00eHmh71r3y
> =D9iu
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 