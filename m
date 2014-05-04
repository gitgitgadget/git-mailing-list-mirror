From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: BUG or FEATURE? Use of '/' in branch names
Date: Sun, 04 May 2014 07:39:48 +0200
Message-ID: <5365D2A4.9010702@alum.mit.edu>
References: <5363D1B4.1000503@lge.com>	 <AAC0CF0A2CCEC34CBE983015FD81C4F7392A504B61@AICEXMBXCL02.LGE.NET>	 <20140502221617.GO9218@google.com> <1399102525.2716.1.camel@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Keith Derrick <keith.derrick@lge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"simon.busch@lge.com" <simon.busch@lge.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 07:40:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgp9d-000148-HT
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 07:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbaEDFjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 01:39:53 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53015 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750713AbaEDFjw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2014 01:39:52 -0400
X-AuditID: 12074411-f79ab6d000002f0e-f2-5365d2a705d2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 3A.11.12046.7A2D5635; Sun,  4 May 2014 01:39:51 -0400 (EDT)
Received: from [192.168.69.130] (p4FC963E8.dip0.t-ipconnect.de [79.201.99.232])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s445dmUL019441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 4 May 2014 01:39:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1399102525.2716.1.camel@spirit>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqLv8UmqwQc83U4vTNyawWnRd6Way
	eHtzCaPF+rvdbBaH519hdWD12DnrLrvH5dZzjB5db68weXzeJBfAEsVtk5RYUhacmZ6nb5fA
	nXF3ZU7BF66Kx29nMDUwnuHoYuTkkBAwkWhYN5sNwhaTuHBvPZgtJHCZUeLQk4IuRi4g+xyT
	RNvuC0wgCV4BbYkpj/6zdzFycLAIqEpMX2EEEmYT0JVY1NPMBBIWFQiS+HNWEaJaUOLkzCcs
	ILaIQJzExsvzmUFGMgtMZZQ4d/I0K0i9sIC5xLmF1RCr1jFKHNj3G2wVJ9DMW/u/gq2SEBCX
	6GkMAjGZBdQl1s8TAqlgFpCX2P52DvMERsFZSLbNQqiahaRqASPzKka5xJzSXN3cxMyc4tRk
	3eLkxLy81CJdU73czBK91JTSTYyQQBfcwTjjpNwhRgEORiUe3pO7U4KFWBPLiitzDzFKcjAp
	ifJ27EwNFuJLyk+pzEgszogvKs1JLT7EKMHBrCTCe30PUI43JbGyKrUoHyYlzcGiJM7Lt0Td
	T0ggPbEkNTs1tSC1CCYrw8GhJMFbCYxoIcGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKS
	jHhQ3MYXAyMXJMUDtNcTpJ23uCAxFygK0XqKUZfjQsOKFiYhlrz8vFQpcd7Gi0BFAiBFGaV5
	cCtgae0VozjQx8K8MSCjeIApEW7SK6AlTEBLxB2TQZaUJCKkpBoYUzznmpp/3HhUIpvL4FrI
	nwwW+YptCc+MJrSz3XKKqS3uuHAseAbL/XbnRp6L3SovCst3JpSyCZ0SfCi9Y9/9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248071>

On 05/03/2014 09:35 AM, Dennis Kaarsemaker wrote:
> On vr, 2014-05-02 at 15:16 -0700, Jonathan Nieder wrote:
>>>     $ git checkout -b hotfix/b2
>>>     error: unable to resolve reference refs/heads/hotfix/b2: Not a
>> directory
>>>     fatal: Failed to lock ref for update: Not a directory
>>>     $
>>
>> That's an ugly message.  I think we can do better. (hint hint)
> 
> 2.0.0-rc2 has a better message already:
> 
> $ git checkout -b hotfix/b2
> error: 'refs/heads/hotfix' exists; cannot create 'refs/heads/hotfix/b2'
> fatal: Failed to lock ref for update: Not a directory

I was trying to remember when this was changed, but at first I couldn't
reproduce the "fixed" error message at all.  Finally I figured out that
the the error message that you get depends on whether the existing
reference is loose:

    $ bin-wrappers/git checkout -b master/foo
    error: unable to resolve reference refs/heads/master/foo: Not a
directory
    fatal: Failed to lock ref for update: Not a directory

vs. packed:

    $ bin-wrappers/git checkout -b base/foo
    error: 'refs/heads/base' exists; cannot create 'refs/heads/base/foo'
    fatal: Failed to lock ref for update: Not a directory

It would be good to make the error message uniform and to document this
restriction.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
