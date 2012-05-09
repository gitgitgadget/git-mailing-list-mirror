From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Index format v5
Date: Wed, 09 May 2012 10:37:03 +0200
Message-ID: <4FAA2CAF.3040408@alum.mit.edu>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com> <4FA7E703.7040408@alum.mit.edu> <20120508141137.GA3937@tgummerer.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 10:44:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS2VO-0000g3-H2
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 10:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757877Ab2EIIoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 04:44:12 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:55531 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755107Ab2EIIoJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 04:44:09 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 May 2012 04:44:09 EDT
X-AuditID: 12074412-b7f1c6d00000092d-93-4faa2cb2980e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C5.19.02349.2BC2AAF4; Wed,  9 May 2012 04:37:06 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q498b3wQ014272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 May 2012 04:37:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120508141137.GA3937@tgummerer.surfnet.iacbox>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsUixO6iqLtJZ5W/we+9AhaPTm5msui60s1k
	0dB7hdniR0sPs8X8QxNZLS6svs1usXLXQiYHdo+ds+6yeyzYVOrxrHcPo8fFS8oef87vYfWY
	+2kRq8fnTXIB7FHcNkmJJWXBmel5+nYJ3BmLf7IWzDCpOPVqJXMDY59mFyMnh4SAicTra7+Y
	IWwxiQv31rN1MXJxCAlcZpS48u4RlHOMSeLhm3ZWkCpeAW2JhZ+PsIPYLAKqEqd3XGADsdkE
	dCUW9TQzdTFycIgKhEmsfqABUS4ocXLmExYQW0RAS2LS1z6wMcwCLYwSr+dFgJQLC8hIbFjv
	BbFqIaPErDlbGEFqOAVsJZ59esMGUsMsYC3xbXcRRKu8xPa3c5gnMArMQrJhFkLVLCRVCxiZ
	VzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKExIDQDsb1J+UOMQpwMCrx8Gpt
	XOkvxJpYVlyZe4hRkoNJSZTXU3uVvxBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3lnqQOW8KYmV
	ValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8osBYFxIsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHxWh8MTBKQVI8QHtfg9zEW1yQmAsUhWg9xWjMMW/K1quMHLOX
	AEkhlrz8vFQpcV4lkE0CIKUZpXlwi2DJ7xWjONDfwrw6IFU8wMQJN+8V0ComoFXTDoO8WFyS
	iJCSamA0FRZf+Krm5ZrH8xTqHa+ISNnuD6zqZIk+6j1j/q0PCds+tbFaK9hUmJjs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197462>

On 05/08/2012 04:11 PM, Thomas Gummerer wrote:
>> * The details of the extension data blocks are described in the first
>>    (overview) section, whereas it seems like they should be described
>>    in their own section following the "conflict data" section.  But
>>    wouldn't the presence of extension data blocks prevent the addition
>>    of conflict data?
>
> Only the details that should be there for every extension are described
> in the overview (the header of the extension), to make sure every
> extension has the same header format, and thus a reader which doesn't
> understand a specific extension still can read its header and know
> what's going on.
>
> They won't prevent the addition of conflicted data, since when a
> conflict is created, other files were probably added and the index has
> to be rewritten anyway. Once the conflict is resolved however only a
> bit has to be flipped, so there is no rewrite necessary.

In other words, the presence of extensions *does indeed* prevent the 
addition of conflict data, but you don't think that it is a problem.

Moving the conflict data to after the extensions, on the other hand, 
would mean that conflict data can sometimes be added without a rewrite. 
  I cannot judge whether this would be useful.

Handling conflict data *as* an extension would allow the conflict data 
to be added at any time without rewriting.  I cannot judge whether this 
would be useful.

>> * Does the index file include directory entries for empty directories?
>>    What about directories that contain only other directories?
>
> In theory the index is able to include empty directories. I'm however
> not sure if this should be implemented. I'd be happy to get more
> feedback there.

Currently git does not keep track of empty directories.  Even though 
there have been proposals to fix this, it is far beyond the scope of 
your project to implement the handling of empty directories.  The 
question is whether your format definition *forbids* the presence of 
empty directories in the index file (in the interest of definiteness, 
and it might make the reader implementation a little bit simpler, but it 
imposes a constraint on the writer).  Obviously empty directories, even 
if present, mustn't have an effect on the SHA1 of the trees containing them.

>> Directory entry
>> ===============
>>
>> * "4-byte number of entries in the index that is covered by the tree
>>    this entry represents."  What does this include?
>>    Files/directories/both?  Recursive or non-recursive?
>
> This is from the cache-tree. I'm not sure but I think it includes both
> files and directories, recursively.

Please figure this out for the final spec.

>> File entry
>> ==========
>> [...]
>
>> * Are file entries sorted by entire path or only by the basename?
>
> They are sorted by the basename, in the respective block of their
> directories.
> Example: paths: a/a a/z b/b
> File entries in the index:
> a ...
> z ...
> b ...

OK, so in other words, the file entries of all files in a directory (not 
including files in subdirectories) are stored contiguously, sorted by 
basename.  (The thing that wasn't immediately clear is whether files 
from subdirectories are intermingled with those of the parent directory.)

>> Flat loading
>> ============
>>
>> * I found the explanation pretty incomprehensible.  Perhaps some
>>    pseudo-code would make it clearer?
>> [...]
> [...] I have changed the flat loading in the documentation,
> hope it's more understandable now.

Maybe it's just be, but I still don't think it is very clear.  Here is 
version fbf8add1b026:

> == Flat loading
>
> Since internally git expects and works with lexicografic ordering,
> a simple linear scan throught the subdirectories doesn't give
> the right internal sorting. To achieve the right internal sorting
> the loading will be done in the following way:
>
> 1. Start with the root directory, and read also the name of the
>   first subdirectory (=next directory in the list).
>
> 1a. Use the next directory (the one against which the filenames
>   were checked previously), and read the next directory name,
>   to check the files against.
>
> 2. Check the stack if the element at the top is < then the current
>   directoryname.
>
>   If it's < then current directory name, add files from the stack
>     to the entry list, until the file name is > then the
>     directory name.
>
> 2. While filename < directoryname add the filenames to the entry
>   list
>
> 3. Add the rest of the files to a stack.
>
> 4. Continue with 1a, if there are more directories left.
>
> 5. Add the rest of the files from the stack to the end of the
>   entry list.

Aside from the fact that there are two number (2)s,

* What does "Use the next directory (the one against which the filenames 
were checked previously)" mean?  What does it mean to "use a directory"? 
  Does it mean to recurse into the directory?  Is the stack preserved 
passed down to the recursive function calls, or does each level of the 
recursion have its own stack?  What does "against which the filenames 
were checked previously" mean (there are no filenames mentioned in the 
earlier steps)?

* You talk about a stack, and "Add the rest of the files to a stack". 
But when you retrieve entries from a stack, they come out in reverse 
order.  So are you imagining that each element of the stack is an array 
of file entries?  Or do you push the files onto the stack in reverse 
order?  Or do you really mean a queue rather than a stack?

* Are the file entries read before they are put on the stack, or does 
the stack just remember where to read them from when their turn comes?

* "Continue with 1a, if there are more directories left": I assume you 
mean subdirectories of the current directory, but maybe you are talking 
about all directories?

There is a reason that I asked for pseudocode, namely because it forces 
you to be more precise in your description.  I can certainly imagine 
several workable algorithms for reading the index file, and the 
different algorithms have different tradeoffs particularly regarding the 
amount of temporary space needed and locality of reference in the index 
file (which, I understand, will be mmapped when practical but it is not 
practical on all platforms).  Once you express the algorithm in 
pseudocode it is possible to be sure which variant you have chosen and 
consider whether it is really workable.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
