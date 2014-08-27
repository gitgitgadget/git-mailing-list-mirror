From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Using Gerrit to review Git patches (was: Re: Transaction patch series
 overview)
Date: Wed, 27 Aug 2014 23:53:29 +0200
Message-ID: <53FE5359.4030403@alum.mit.edu>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com> <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com> <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com> <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com> <20140820231723.GF20185@google.com> <20140826000354.GW20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:53:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMl9t-0006nt-JK
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 23:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbaH0Vxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 17:53:33 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61139 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932246AbaH0Vxc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2014 17:53:32 -0400
X-AuditID: 12074413-f79ed6d000002501-19-53fe535cb5b7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 92.2C.09473.C535EF35; Wed, 27 Aug 2014 17:53:32 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB04AB.dip0.t-ipconnect.de [93.219.4.171])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s7RLrUQR018412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 27 Aug 2014 17:53:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <20140826000354.GW20185@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1I0J/hds0HCR3aLrSjeTxdubSxgt
	/k2ocWD22DnrLrvHgk2lHp83yQUwR3HbJCWWlAVnpufp2yVwZ5zuv8VW0CdRMb3lIWsD43Lh
	LkZODgkBE4mV94+yQthiEhfurWcDsYUELjNKzNur3sXIBWSfY5Lo2PKKsYuRg4NXQFvi23Fd
	kBoWAVWJUzffs4PYbAK6Eot6mplAbFGBIInZn+eBxXkFBCVOznzCAmKLCERIbDi0kBnEZhbQ
	l/j05wBYvbBAlMTPS8eZIHY9Z5Lo27EE7CBOAQOJ479Ws0A06Ei863sA1Swvsf3tHOYJjAKz
	kOyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfVyM0v0UlNKNzFCAld4B+Ou
	k3KHGAU4GJV4eD8s+BMsxJpYVlyZe4hRkoNJSZTXO+hfsBBfUn5KZUZicUZ8UWlOavEhRgkO
	ZiUR3g8eQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvFshQwaLU
	9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCkxhcDYxUkxQO0Nwmknbe4IDEXKArReopR
	UUqcd0YgUEIAJJFRmgc3FpaOXjGKA30pzFsF0s4DTGVw3a+ABjMBDf7V8RdkcEkiQkqqgTFG
	e+XiU4XTmI+Lxfd2HlIUsu7mubxg+p4W08SJkzdE/pdyWb3q9xXu0kNK812/mNyq/ZXCnxP6
	XHbmeh3V7AW5i510zuzpkun8dYl5SeXJ/2Yv1uTtEP/B17xyate093IuD6QSDIWX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256050>

On 08/26/2014 02:03 AM, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
> [...]
>> I've having trouble keeping track of how patches change, which patches
>> have been reviewed and which haven't, unaddressed comments, and so on,
>> so as an experiment I've pushed this part of the series to the Gerrit
>> server at
>>
>>  https://code-review.googlesource.com/#/q/topic:ref-transaction-1
> 
> Outcome of the experiment: patches gained some minor changes and then
> [...]
> 
> I found the web UI helpful in seeing how each patch evolved since I
> last looked at it.  Interdiff relative to the version in pu is below.
> I'm still hoping for a tweak in response to a minor comment and then I
> can put up a copy of the updated series to pull.

Thanks for organizing this "experiment". I was one of the guinea pigs
:-) I have wanted to review more of Ronnie's patches (actually, all of
them!) but have been overwhelmed by the number of iterations and the
number of patch series flying around in parallel. I was also interested
to try out Gerrit, which I haven't used before. So I took up Jonathan's
invitation and reviewed the first patch series in Gerrit. Here are some
of my first impressions.

* Overall, I found it easier to review commits in Gerrit than on the
mailing list, especially a long patch series like this one that has seen
so much flux. It was easier to see the comments from all reviewers that
apply to a patch, which is difficult on the mailing list when comments
are scattered over the many iterations of the patch series. It was
easier to incrementally increase the context around a patch. It was easy
to use the copy-paste commands provided in the "download" menu to fetch
the commit that I was reviewing into my local Git repository, and from
there to build it or investigate it using other tools.

* The Gerrit interface is very busy. It was somewhat overwhelming to me
as a beginner. On the other hand, the help menus ("?" key) are good and
the keyboard shortcuts are convenient. I didn't have to read much
documentation to get started doing review in Gerrit, at least at a basic
level.

* During two of my big Gerrit sessions the website was very responsive
and pleasant to use. During the third, it was terribly slow, like 5 - 15
seconds per page update. If I had only experienced the slow behavior, I
would have rejected Gerrit immediately. I hope that the slow behavior
was a rare anomaly.

* Gerrit sends out an endless flood of emails that mostly seem pretty
useless to me. I wish it weren't so chatty and that its emails were
better organized.

* At one point a back-and-forth in a line comment grew into a more
general issue that was more appropriate for the mailing list. The
transition from Gerrit to mailing list was a bit awkward.

So, overall I found it pleasant and efficient to review patches in
Gerrit. I would welcome more such "experiments". It would have been even
better if Gerrit would generate more useful notification emails.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
