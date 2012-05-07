From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Index format v5
Date: Mon, 07 May 2012 17:15:15 +0200
Message-ID: <4FA7E703.7040408@alum.mit.edu>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 17:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRPlc-0004JJ-P2
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 17:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239Ab2EGPWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 11:22:23 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:52009 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756590Ab2EGPWW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 11:22:22 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 May 2012 11:22:22 EDT
X-AuditID: 12074413-b7f886d0000008a0-88-4fa7e70788ea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3E.C2.02208.707E7AF4; Mon,  7 May 2012 11:15:19 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q47FFGkG017928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 7 May 2012 11:15:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqMv+fLm/QfdDK4tHJzczWXRd6Way
	aOi9wmzxo6WH2WL+oYmsFhdW32a3WLlrIZMDu8fOWXfZPRZsKvV41ruH0ePiJWWPP+f3sHrM
	/bSI1ePzJrkA9ihum6TEkrLgzPQ8fbsE7ozmC+kFa3Ur9nVdYm1gnKbcxcjJISFgIvHyczcj
	hC0mceHeerYuRi4OIYHLjBKPDu1ngXCOMUl8efOZCaSKV0BbYuayg0BVHBwsAqoS044kgoTZ
	BHQlFvU0M4GERQXCJFY/0ICoFpQ4OfMJC4gtIqAlMelrHyuIzSzQwijxel4ESLmwgIzEhvVe
	IGEhgQCJ1T/XgZ3DKRAo0downxmkhFnAWuLb7iKITnmJ7W/nME9gFJiFZMEshKpZSKoWMDKv
	YpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJf+EdjLtOyh1iFOBgVOLhbRZY
	7i/EmlhWXJl7iFGSg0lJlHfvU6AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6lSUA53pTEyqrU
	onyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEr8UzoEbBotT01Iq0zJwShDQTByfI
	cC4pkeLUvJTUosTSkox4UHzGFwMjFCTFA7TXGaSdt7ggMRcoCtF6itGYY96UrVcZOWYvAZJC
	LHn5ealS4rzGIKUCIKUZpXlwi2CJ7xWjONDfwrzRIFU8wKQJN+8V0ComoFWbny0DWVWSiJCS
	amBc+Lt2+ue7Rd6fVpxb98yqdxXHMVufYDnNm28r9howsK8zlM/4+dBx/6mkpz+e 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197277>

On 05/03/2012 07:25 PM, Thomas Gummerer wrote:
> I have been drafting the Version 5 of the index format over the past
> few days with the help of Thomas Rast, Michael Haggerty, cmn and
> barrbrain on IRC. It will save with prefix compression on the path, and
> using a crc32 over the stat data, instead of the full data, since it is only
> used for checking if the file is changed. (Thanks Michael Haggerty for
> this hint. Unless we are missing something this will save another
> ~4 MB on the Webkit index.
>
>
>
> GIT index format
> ================
 > [...]

Here are some comments about the format document, version 55047b3d. 
They probably overlap with other feedback that you have gotten, but I 
don't have time to cross-correlate everything.  Hope it helps.

Overall
=======

I find the format definition pretty difficult to read.  The following
suggestions might make it easier to follow.

* You might want to give each of the elements C-like names; e.g.,
   "ndir (32 bits): number of directories in the index".  These names
   could be used as unambiguous references from other parts of the
   documentation.  The names could also be used in the implementing
   code, to make the correspondence with the format definition easier
   to follow.

* Name things consistently.  For example, "A number of sorted
   directories (see below)" should be changed to "A number of directory
   entries (see below), sorted by path name".

* Putting the above two things together, the description "A number of
   sorted directories" might become "direntries (ndir * directory
   entries): one directory entry for each of the ndir directories in
   the index, sorted by path name".

* Are all "offsets" relative to the start of the index file?  If so,
   it would be good to state this explicitly at the start (and maybe
   rename them "file positions"?).  If not, please be very explicit
   about where each offset is measured from, and whether it is signed
   or unsigned.

* You seem to switch randomly between counting sizes in bits vs bytes.
   Please try to be more consistent.  BTW, I think the size of an SHA1
   object name is more commonly described as "20 bytes" rather than
   "160 bits".

* The details of the extension data blocks are described in the first
   (overview) section, whereas it seems like they should be described
   in their own section following the "conflict data" section.  But
   wouldn't the presence of extension data blocks prevent the addition
   of conflict data?

* Are there situations (for example during conflicts?) when it is
   allowed to have directory and file entries with the same name?

* Does the index file include directory entries for empty directories?
   What about directories that contain only other directories?

Overview
========

* Does "32-bit size of the extension" include the whole extension data
   block (including header) or only the "extension data"?

Directory entry
===============

* "4-byte number of entries in the index that is covered by the tree
   this entry represents."  What does this include?
   Files/directories/both?  Recursive or non-recursive?

* "160-bit object name for the object that would result from writing
   this span of index as a tree."  Is this always valid?

* It might be convenient to store directory names with trailing '/'
   characters (except for the top-level directory, which can be stored
   as "").  That way (1) it is trivial to concatenate the directory
   name and the filename to produce the file path; (2) directories and
   files can be distinguished by name and therefore intermingled in
   lists; (3) such lists can be sorted using strcmp() without having to
   simulate an invisible '/' character.

File entry
==========

* I believe that only the basename is stored, not the whole path.  But
   then why is the encoding for '/' specified (there should be no '/'
   characters)?

* Why is the encoding of '.' specified?  Is it somehow significant for
   the index file format?

* Are file entries sorted by entire path or only by the basename?

Flat loading
============

* I found the explanation pretty incomprehensible.  Perhaps some
   pseudo-code would make it clearer?

* Since I can't understand the explanation, I'm not sure if this
   comment makes any sense.  But when traversing into a subdirectory,
   don't *all* of the remaining files from the parent directory need to
   be tucked away somewhere?

* At an even higher level of abstraction, your directory entry
   contains a count "number of entries in the index that is covered by
   the tree this entry represents".  If this count is recursive, then
   it seems like it would be enough to know how many entries will come
   from traversing a whole subdirectory tree.  So it should be possible
   to skip that many entries in the in-memory array and continue
   reading the file entries for the parent subdirectory.  For example,
   suppose our files are [A, B/1, B/2/a, B/2/b, B/3, C].  If I start by
   reading the files in the root directory, then I can fill the index
   array entries

       [A, -, -, -, -, C]

   because when I see that "B" is a directory containing a total of
   four entries, I just leave fours spaces for them in the array and
   continue with the next file, "C".  Of course I would have to
   remember (e.g., on a queue) that directory "B" still needs to be
   processed, and the starting index in the array where its entries
   have to be filled in.  Still, this jumping around would be in the
   RAM holding the index array pointers rather than in the file
   positions.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
