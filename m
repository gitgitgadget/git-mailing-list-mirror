From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: No progress from push when using bitmaps
Date: Fri, 14 Mar 2014 10:43:52 +0100
Message-ID: <5322CF58.6060506@alum.mit.edu>
References: <CAJo=hJth1YB+u2Y9S0X3xk7s2-HcPP4_k03qprHBU4A9721i8g@mail.gmail.com> <20140313212626.GA23618@sigill.intra.peff.net> <CAJo=hJu1WscibwectWzrUcoOV4-9xk4hBm1JA+RjONmgvZTXwQ@mail.gmail.com> <20140313220754.GA20173@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 10:44:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOOem-0002oZ-VA
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 10:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812AbaCNJn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 05:43:57 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:49115 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755543AbaCNJn4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2014 05:43:56 -0400
X-AuditID: 1207440e-f79c76d000003e2c-50-5322cf5a2486
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id DC.C3.15916.A5FC2235; Fri, 14 Mar 2014 05:43:55 -0400 (EDT)
Received: from [192.168.69.148] (p57A2431A.dip0.t-ipconnect.de [87.162.67.26])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2E9hqMb018886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 14 Mar 2014 05:43:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140313220754.GA20173@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqBt9XinY4MF7RouuK91MFj9aepgt
	5h+ayOrA7PGsdw+jx5/ze1g9Pm+SC2CO4rZJSiwpC85Mz9O3S+DOmNI6i7mgV6ji4qqYBsZ+
	vi5GTg4JAROJnkf/mCFsMYkL99azdTFycQgJXGaU6J9/jhXCOcck0XnuEztIFa+AtsTse4fB
	bBYBVYmHn9eB2WwCuhKLepqZQGxRgWCJ1ZcfsEDUC0qcnPkEzBYRkJX4fngjI4jNLOAoceDa
	G7C4sICpxPb7Z8BsIYHPjBLzb5SB2JwC1hJ9XUeA5nMAXScu0dMYBGIyC6hLrJ8nBDFFXmL7
	2znMExgFZyFZNguhahaSqgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI31cjNL9FJTSjcx
	QsKZbwdj+3qZQ4wCHIxKPLwOhxWDhVgTy4orcw8xSnIwKYnyhp5UChbiS8pPqcxILM6ILyrN
	SS0+xCjBwawkwut6BijHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLg
	jT8H1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPit34YmD0gqR4gPZGgrTzFhck
	5gJFIVpPMepybNi2ppFJiCUvPy9VSpx3+lmgIgGQoozSPLgVsOT1ilEc6GNhXkOQUTzAxAc3
	6RXQEiagJYnrwJaUJCKkpBoYu+rOpsyKW2Im9iDs8Ln7/9dtsj/+zmWnm2Iv+9T72XMqrKJb
	ru4zVJJVumrc/Cy9qGjW517/E7MY2Q9oSzlVd784Weu7f3JGgVpvd+jsOcJmh5/n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244085>

On 03/13/2014 11:07 PM, Jeff King wrote:
> On Thu, Mar 13, 2014 at 03:01:09PM -0700, Shawn Pearce wrote:
> 
>>> It would definitely be good to have throughput measurements while
>>> writing out the pack. However, I'm not sure we have anything useful to
>>> count. We know the total number of objects we're reusing, but we're not
>>> actually parsing the data; we're just blitting it out as a stream. I
>>> think the progress code will need some refactoring to handle a
>>> throughput-only case.
>>
>> Yes. I think JGit suffers from this same bug, and again we never
>> noticed it because usually only the servers are bitmapped, not the
>> clients.
>>
>> pack-objects writes a throughput meter when its writing objects.
>> Really just the bytes out/second would be enough to let the user know
>> the client is working. Unfortunately I think that is still tied to the
>> overall progress system having some other counter?
> 
> Yes, I'm looking at it right now. The throughput meter is actually
> connected to the sha1fd output. So really we just need to call
> display_progress periodically as we loop through the data. It's a
> one-liner fix.
> 
> _But_ it still looks ugly, because, as you mention, it's tied to the
> progress meter, which is counting up to N objects. So we basically sit
> there at "0", pumping data, and then after the pack is done, we can say
> we sent N. :)
> 
> There are a few ways around this:
> 
>   1. Add a new phase "Writing packs" which counts from 0 to 1. Even
>      though it's more accurate, moving from 0 to 1 really isn't that
>      useful (the throughput is, but the 0/1 just looks like noise).
> 
>   2. Add a new phase "Writing reused objects" that counts from 0 bytes
>      up to N bytes. This looks stupid, though, because we are repeating
>      the current byte count both here and in the throughput.
> 
>   3. Use the regular "Writing objects" progress, but fake the object
>      count. We know we are writing M bytes with N objects. Bump the
>      counter by 1 for every M/N bytes we write.

Would it be practical to change it to a percentage of bytes written?
Then we'd have progress info that is both convenient *and* truthful.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
