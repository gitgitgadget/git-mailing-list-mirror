From: Alfred Perlstein <alfred@freebsd.org>
Subject: Re: [PATCH] Document the 'svn propset' command.
Date: Mon, 13 Jun 2016 05:52:12 -0700
Organization: FreeBSD
Message-ID: <81a197e2-7e0e-176a-c934-0e5f95cfda83@freebsd.org>
References: <20160612191550.GA14160@elvis.mu.org>
 <CAFZEwPM5qnzw7RCUwOkJFo+U982kVGU8_3GUTXvHAypKtvEgTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Joseph Pecoraro <pecoraro@apple.com>,
	David Fraser <davidf@sjsoft.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 14:52:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCRLp-0002zw-0a
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 14:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423274AbcFMMwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 08:52:16 -0400
Received: from elvis.mu.org ([192.203.228.196]:24985 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422860AbcFMMwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 08:52:15 -0400
Received: from Alfreds-MacBook-Pro-2.local (unknown [IPv6:2601:645:8003:a4d6:455b:699:483d:25c7])
	by elvis.mu.org (Postfix) with ESMTPSA id 02A06346DFC2;
	Mon, 13 Jun 2016 05:52:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
In-Reply-To: <CAFZEwPM5qnzw7RCUwOkJFo+U982kVGU8_3GUTXvHAypKtvEgTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297190>

Thank you Pranit.  I thought that "signed off by" is used once someone 
approved my patch as opposed to when it's in "proposal" stage.  This was 
my first email with a patch for this issue, who should/could I have used 
for "signoff"?


-Alfred


On 6/12/16 11:59 PM, Pranit Bauva wrote:
> Hey Alfred,
>
> On Mon, Jun 13, 2016 at 12:45 AM, Alfred Perlstein <alfred@freebsd.org> wrote:
>> Junio + all,
>>
>> A week ago I was requested to provide documentation for the
>> 'svn propset' command.  I have attached a diff off of the
>> 'maint' branch for this, however it seems to apply cleanly
>> to 'master' as well.
>>
>> Thank you for your patience.
>>
>> This is also available on my github here:
>> https://github.com/splbio/git/tree/document_propset
> I am not particularly sure whether the above could form a good commit
> message. I think you wanted to include this as a comment. git-am picks
> up these patches. The title commit is taken from the subject stripping
> the '[PATCH]'. Then the body before '---' is taken as the rest of the
> commit message. Then the diff is applied. To include comments add them
> after ---. Also please have a look at Documentation/SubmittingPatches.
> Also missing signoff. For the patch to actually be accept you need to
> follow those instructions. Thanks for contributing.
>
>> ---
>>   Documentation/git-svn.txt | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
>> index fb23a98..e104824 100644
>> --- a/Documentation/git-svn.txt
>> +++ b/Documentation/git-svn.txt
>> @@ -459,6 +459,20 @@ Any other arguments are passed directly to 'git log'
>>          Gets the Subversion property given as the first argument, for a
>>          file.  A specific revision can be specified with -r/--revision.
>>
>> +'propset'::
>> +       Sets the Subversion property given as the first argument, to the
>> +       value given as the second argument for the file given as the
>> +       third argument.
>> ++
>> +Example:
>> ++
>> +------------------------------------------------------------------------
>> +git svn propset svn:keywords "FreeBSD=%H" devel/py-tipper/Makefile
>> +------------------------------------------------------------------------
>> ++
>> +This will set the property 'svn:keywords' to 'FreeBSD=%H' for the file
>> +'devel/py-tipper/Makefile'.
>> +
>>   'show-externals'::
>>          Shows the Subversion externals.  Use -r/--revision to specify a
>>          specific revision.
> Regards,
> Pranit Bauva
>
