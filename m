From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Thu, 06 Mar 2014 17:41:27 +0100
Message-ID: <5318A537.4010400@alum.mit.edu>
References: <20140304174806.GA11561@sigill.intra.peff.net> <xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com> <20140305005649.GB11509@sigill.intra.peff.net> <xmqqy50oh45n.fsf@gitster.dls.corp.google.com> <20140305185212.GA23907@sigill.intra.peff.net> <xmqqppm0h2ti.fsf@gitster.dls.corp.google.com> <53183506.5080002@alum.mit.edu> <20140306155626.GB18519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 06 17:41:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLbMZ-0007dV-8j
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 17:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbaCFQle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 11:41:34 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51068 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751276AbaCFQle (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2014 11:41:34 -0500
X-AuditID: 12074411-f79ab6d000002f0e-8e-5318a53c4b4d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id C6.9E.12046.C35A8135; Thu,  6 Mar 2014 11:41:32 -0500 (EST)
Received: from [192.168.69.148] (p57A24A5D.dip0.t-ipconnect.de [87.162.74.93])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s26GfT9k019653
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 6 Mar 2014 11:41:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140306155626.GB18519@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqGuzVCLYYMFzTYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Bm3/39mLbgiV9F0R6WBsUei
	i5GTQ0LARGL94RVMELaYxIV769m6GLk4hAQuM0rsmvSBEcI5yySx8ecOdpAqXgFtiY5Ns8Fs
	FgFViZVPtoLZbAK6Eot6msEmiQoES6y+/IAFol5Q4uTMJ2C2iICsxPfDGxlBbGYBa4kVrw+D
	1QsL2EjcPPqLCWLZFyaJXT//sYIkOIGK1tw9BtTAAXSeuERPYxCIySygLrF+nhDEGHmJ7W/n
	ME9gFJyFZNsshKpZSKoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11cvNLNFLTSndxAgJ
	Z8EdjDNOyh1iFOBgVOLh7VgkESzEmlhWXJl7iFGSg0lJlNdkMVCILyk/pTIjsTgjvqg0J7X4
	EKMEB7OSCO8ikHLelMTKqtSifJiUNAeLkjgv3xJ1PyGB9MSS1OzU1ILUIpisDAeHkgTv4iVA
	jYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg6I0vBsYvSIoHaO8ZsL3FBYm5QFGI
	1lOMxhy32359YuR4vfbvJ0Yhlrz8vFQpcd6JIJsEQEozSvPgFsES2StGcaC/hXk3glTxAJMg
	3LxXQKuYgFZF84mDrCpJREhJNTCGd+t8bow5uCH7+za+Bdv6A5fZJL380m0RpRB2+4rhaqYb
	Djk+pqkVj5s3PbubXbLEfyb7D4ZJ3c9TPmpV8rYIdKtM++19fYKx3D2puAD/rLkK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243521>

On 03/06/2014 04:56 PM, Jeff King wrote:
> On Thu, Mar 06, 2014 at 09:42:46AM +0100, Michael Haggerty wrote:
> 
>> Replace objects are better than grafts in *almost* every dimension.  The
>> exception is that it is dead simple to create grafts, whereas I always
>> have to break open the man pages to remember how to create a replace
>> object that does the same thing.
>>
>> So I think a helpful step towards deprecating grafts would be to offer a
>> couple of convenience features to help people kick the "grafts" habit:
> 
> I agree that better tool support would make "git replace" more pleasant
> to use.
> 
>> * A tool that converts grafts (i.e., the grafts read from
>> $GIT_DIR/info/grafts) into the equivalent replacements.
> 
> I don't know if this is strictly necessary, if we make your command
> below pleasant to use. I.e., it should just be:
> 
>   while read sha1 parents; do
>     git replace --graft $sha1 $parents
>   done <.git/info/grafts
> 
> We can wrap that in "git replace --convert-grafts", but I do not think
> grafts are so common that there would be a big demand for it.

It's probably easier to wrap it than to explain to Windows users what
they have to do.

>> * A tool that creates a new replacement object that is the equivalent of
>> a graft.  I.e., it should do, using replace references, the equivalent
>> of the following command:
>>
>>       echo SHA1 [PARENT1...] >>$GIT_DIR/info/grafts
>>
>> These features could be added to "git replace" or could be built into a
>> new "git grafts" command.
> 
> I think it would be nice to have a set of "mode" options for
> "git-replace" to do basic editing of a sha1 and install the result
> (technically you could split the editing into a separate command, but I
> do not see the point in editing a sha1 and then _not_ replacing it).

If modifying without replacing is needed, it would be pretty easy to add
an option --stdout that writes the SHA1 of the modified object to stdout
instead of creating a replace reference.  That way what you want 95% of
the time is the default but there is still an escape hatch.

> Perhaps:
> 
>   # pretty-print sha1 based on type, start $EDITOR, create a
>   # type-appropriate object from the result (e.g., using hash-object,
>   # mktree, or mktag), and then set up the object as a replacement for
>   # SHA1
>   git replace --edit SHA1
> 
>   # ditto, but replace the $EDITOR step with the parent list
>   git replace --graft SHA1 PARENT1 PARENT2
> 
>   # ...or remove entries from a tree
>   git replace --remove-entry SHA1 foo bar

I like this idea a lot, especially the pretty-printer round-tripping.

"git replace" could support some of the options that "git filter-branch"
can take, like --env-filter, --msg-filter, etc. (at least if the target
is a commit object).

All of this would make it possible to build up the changes that you want
to integrate via "filter-branch" piecemeal instead of having to have a
single monster filter-branch invocation.  For example,

    for c in $(git rev-list --all --before=2007-01-01
--author=root@localhost)
    do
        git replace --env-filter 'export AUTHOR_EMAIL=john@example.com' $c
    done
    # Make some more changes to other commits...
    # And when everything is done and checked:
    git filter-branch --all --tag-name-filter=cat

To me this is easier to construct than the equivalent filter-branch
invocation, and can be faster because its processing can be more easily
limited to the commits that need it.  Of course to really gain speed,
there should be a C program that bakes in replace references by
traversing the object tree rather than processing each commit
separately, like filter-branch.  I predict that this approach would have
most of the speed of BFG.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
