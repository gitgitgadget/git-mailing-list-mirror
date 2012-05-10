From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Index format v5
Date: Thu, 10 May 2012 20:17:23 +0200
Message-ID: <4FAC0633.90809@alum.mit.edu>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com> <4FA7E703.7040408@alum.mit.edu> <20120508141137.GA3937@tgummerer.surfnet.iacbox> <4FAA2CAF.3040408@alum.mit.edu> <20120510121911.GB98491@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 20:24:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSY2c-0004Xz-1h
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 20:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761159Ab2EJSYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 14:24:31 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:52853 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761152Ab2EJSY3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 14:24:29 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 May 2012 14:24:29 EDT
X-AuditID: 12074411-b7f596d000000932-82-4fac06368455
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.D7.02354.6360CAF4; Thu, 10 May 2012 14:17:26 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4AIHNTw025072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 10 May 2012 14:17:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120510121911.GB98491@tgummerer>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsUixO6iqGvGtsbfoPGgssWjk5uZLLqudDNZ
	NPReYbb40dLDbDH/0ERWiwurb7NbrNy1kMmB3WPnrLvsHgs2lXo8693D6HHxkrLHn/N7WD3m
	flrE6vF5k1wAexS3TVJiSVlwZnqevl0Cd8bhqd2sBT0SFe2HNjM3MB4X6mLk5JAQMJE4/msF
	K4QtJnHh3nq2LkYuDiGBy4wS29dvY4ZwjjNJzHjdygRSxSugKbF2+RuwDhYBVYntWyezgNhs
	AroSi3qagWo4OEQFwiRWP9CAKBeUODnzCViJiICWxKSvfWCtzAItjBKv50WAlAsLyEhsWO8F
	seoJUPjGbzaQGk4BfYl77x+wg9QwC1hLfNtdBNEqL7H97RzmCYwCs5BsmIVQNQtJ1QJG5lWM
	cok5pbm6uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsYIVEguINxxkm5Q4wCHIxKPLzcb1f7
	C7EmlhVX5h5ilORgUhLl/cC4xl+ILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO+c6UDlvCmJlVWp
	RfkwKWkOFiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJXgFWoKGCRanpqRVpmTklCGkmDk6Q
	4VxSIsWpeSmpRYmlJRnxoCiNLwbGKUiKB2gvL0g7b3FBYi5QFKL1FKMux4xPi64xCrHk5eel
	SonzfmABKhIAKcoozYNbAUt5rxjFgT4W5lUAGcUDTJdwk14BLWECWjLt8EqQJSWJCCmpBsYF
	yRFMyUmne4tNLUTeWgkpZov1vbS6IGYeNl9fUV+w+KmStCLL9JbK539WbZGZzmo8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197611>

On 05/10/2012 02:19 PM, Thomas Gummerer wrote:
> == Flat loading
>
> Since internally git expects and works with lexicografic ordering,
> a simple linear scan throught the subdirectories doesn't give
> the right internal sorting. To achieve the right internal sorting
> the loading will be done in the following way:
>
> The data structure is a stack of queues, to allow continous reading
> of the file.
>
> s ->  queue1
> t ->  queue2
> a ->  queue3
> c ->  queue4
> k ->  queue5
>
> dirs = read_all_directories
>
> foreach dir in dirs do
>      file = read_next_file
>
>      while element_on_top_of_stack.first_element<  nextdir
>          indexentries.append(dequeue(element_on_top_of_stack))
>          if element_on_top_of_stack == emtpy:
>              remove_element_on_top_of_stack
>
>      if file[filename]<  nextdir
>          indexentries.append(file)
>      else
>          queue.add(file)
>          foreach f in rest_of_files_in_directory:
>              queue.add(f)
>          stack.push(queue)
>
> foreach queue in stack:
>      foreach entry in queue:
>          indexentry.append(entry)

1. It seems to me that the first time that a file with a filename before 
nextdir is encountered, the reading of the directory containing the file 
will be terminated.  This would, for example, be the case for any 
directory that contains multiple files but no subdirectories.

2. There is still a lot that is unnecessarily obscure.  For example, I 
suppose (but you don't say) that "rest_of_files_in_directory" means to 
read the files at that moment.  It would be more explicit (and no more 
verbose) to write

     while (f = read_next_file()) != NULL:
         queue.add(f)

3. You don't cover corner cases, like when read_next_file() is called 
but there are no files left in the directory, or when there is no 
nextdir (which itself is not defined).  OK, this pseudocode is only 
meant to be illustrative, so I guess we can wait until your real 
implementation to see such details.  On the other hand, you probably 
want to get all the details straight in pseudocode or Python before you 
start translating it into C.

4. I think the algorithm would be easier to understand and implement if 
it were written recursively.  The call stack would replace your explicit 
stack (but you would still need one queue per directory level).  A key 
observation is that when "nextdir" precedes the next file, then all of 
the files in subdirectories of nextdir do as well.  Thus an obvious 
recursion would be to call a function like 
read_all_files_under_dir(indexentries, dirs, dirindex) at this point, 
which would consume all of the directories that are subdirectories of 
dirs[dirindex] (i.e., all directories whose names have the string 
dirs[dirindex] as a prefix).  Using this method would mean that there is 
no need to compare each file under dirs[dirindex] against the next file 
in the outer directory.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
