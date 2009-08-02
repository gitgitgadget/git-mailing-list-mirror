From: Mark A Rada <markrada26@gmail.com>
Subject: Re: [PATCHv2 2/2] gitweb: support to globally enable/disable a snapshot format
Date: Sat, 1 Aug 2009 20:52:39 -0400
Message-ID: <99F483B0-B5F0-44FB-94EF-7C071E3C3524@gmail.com>
References: <1CE4F545-1ACA-4786-B0F2-EE7C746E6585@uwaterloo.ca> <m3hbwrqly9.fsf@localhost.localdomain> <D33D9C93-300E-4565-8040-BED425A6F2FE@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sun Aug 02 02:53:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXPJs-0001p0-Qi
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 02:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbZHBAwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 20:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbZHBAwn
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 20:52:43 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:38308 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbZHBAwn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 20:52:43 -0400
Received: by gxk9 with SMTP id 9so4914862gxk.13
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 17:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=Q/L0yPIBr+t6UA7qYovJ/ctGrpLr6vTHUHmcJtOEDPY=;
        b=NlMGKlnyLYKi+trQBoNS/1s6a17eyw6EI7sHM7LIfgqhFQ/JAQALDvUhF+ZAp8IQzo
         FwKvVBnjyexSHqbqV94byzxE9Ka6tMgvTj3/LM86aMF9dgqAR7l5MFeQe4YIQoPFhYMZ
         TbF+zF9n6NYQTBAEI7C9tWLTJTuxi92ykhRWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=n3KfvACzb0G8hnb6joEgHaGRqVSnOTFQSLot1lheYaYctXEYKvvyd8FLSZWRhG8jjX
         DbfDapfSjOFwLiaM5ftl4HaTQWvi8d2FBDTL/YpT/dUC5JvFkUhRJnhgvv8CZQgyRUf+
         dJt0wiUqeOOTIk7pRS90x0c839INas4NOm2qw=
Received: by 10.150.133.9 with SMTP id g9mr1445702ybd.2.1249174362658;
        Sat, 01 Aug 2009 17:52:42 -0700 (PDT)
Received: from ?192.168.1.102? (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
        by mx.google.com with ESMTPS id 20sm361638ywh.14.2009.08.01.17.52.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 17:52:41 -0700 (PDT)
In-Reply-To: <D33D9C93-300E-4565-8040-BED425A6F2FE@uwaterloo.ca>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124654>


On 1-Aug-09, at 7:50 PM, Mark A Rada wrote:

>
> On 1-Aug-09, at 5:11 PM, Jakub Narebski wrote:
>
>> Mark A Rada <marada@uwaterloo.ca> writes:
>>
>>> ------->8-------------
>>> From: Mark Rada <marada@uwaterloo.ca>
>>> Date: Sat, 1 Aug 2009 13:24:03 -0400
>>> Subject: [PATCH 2/2] gitweb: support to globally enable/disable a  
>>> snapshot format
>>>
>>> I added a 'disabled' variable to to the $known_snapshot_formats  
>>> keys so
>>> that a Gitweb administrator can globally enable or disable a  
>>> specific
>>> format for snapshots.
>>>
>>> All formats are enabled by default because project specific  
>>> overriding
>>> is disabled by default.
>>>
>>> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
>>
>> O.K.  I think this patch now covers everything needed.  Well, except
>> documentation.
>>
>
> Documentation documentation or code comments documentation?

Nevermind, I just discovered there was an INSTALL and README file for
Gitweb...I'll update those.


>
>>> ---
>>> gitweb/gitweb.perl |   17 ++++++++++++-----
>>> 1 files changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index 3398163..a59569f 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -167,27 +167,31 @@ our %known_snapshot_formats = (
>>
>> At the beginning of %known_snapshot_formats definition there is a
>> comment with description of structure of this hash.  You should have
>> updated it, for example in the following way:
>>
>> @@ -168,7 +168,8 @@ our %known_snapshot_formats = (
>> 	# 	'suffix' => filename suffix,
>> 	# 	'format' => --format for git-archive,
>> 	# 	'compressor' => [compressor command and arguments]
>> -	# 	                (array reference, optional)}
>> +	# 	                (array reference, optional),
>> +	# 	'disabled' => boolean (optional)}
>> 	#
>> 	'tgz' => {
>> 		'display' => 'tar.gz',
>>
>> The above is, of course, not the only possible way.
>>
>>> 		'type' => 'application/x-gzip',
>>> 		'suffix' => '.tar.gz',
>>> 		'format' => 'tar',
>>> -		'compressor' => ['gzip']},
>>> +		'compressor' => ['gzip'],
>>> +		'disabled' => 0},
>>>
>>> 	'tbz2' => {
>>> 		'display' => 'tar.bz2',
>>> 		'type' => 'application/x-bzip2',
>>> 		'suffix' => '.tar.bz2',
>>> 		'format' => 'tar',
>>> -		'compressor' => ['bzip2']},
>>> +		'compressor' => ['bzip2'],
>>> +		'disabled' => 0},
>>>
>>> 	'txz' => {
>>> 		'display' => 'tar.xz',
>>> 		'type' => 'application/x-xz',
>>> 		'suffix' => '.tar.xz',
>>> 		'format' => 'tar',
>>> -		'compressor' => ['xz']},
>>> +		'compressor' => ['xz'],
>>> +		'disabled' => 0},
>>>
>>> 	'zip' => {
>>> 		'display' => 'zip',
>>> 		'type' => 'application/x-zip',
>>> 		'suffix' => '.zip',
>>> -		'format' => 'zip'},
>>> +		'format' => 'zip',
>>> +		'disabled' => 0},
>>> );
>>
>> Although I though that we don't need to put "'disabled' => 0", as
>> the fact that 'disabled' key does not exist means that it is enabled.
>>
>> But if you chose to have all known formats not disabled, then I think
>> it is a correct solution.  (And then choosing between 'enabled' and
>> 'disabled' is mainly a matter of taste.)
>>
>
> I think spelling it out explicitly in each case makes things more  
> clear, but
> would it not increase the memory footprint ever so slightly (I'm not  
> familiar
> with PERL internals and whether having a field in one hash entry means
> it will have memory allocated in all the rest). I'm also not  
> convinced that
> worrying about this micro-optimization is worth it.
>
>
>>>
>>> # Aliases so we understand old gitweb.snapshot values in repository
>>> @@ -502,7 +506,8 @@ sub filter_snapshot_fmts {
>>> 		exists $known_snapshot_format_aliases{$_} ?
>>> 		       $known_snapshot_format_aliases{$_} : $_} @fmts;
>>> 	@fmts = grep {
>>> -		exists $known_snapshot_formats{$_} } @fmts;
>>> +		exists $known_snapshot_formats{$_} &&
>>> +		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
>>> }
>>>
>>> our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
>>> @@ -5171,6 +5176,8 @@ sub git_snapshot {
>>> 		die_error(400, "Unknown snapshot format");
>>> 	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
>>> 		die_error(403, "Unsupported snapshot format");
>>> +	} elsif ($known_snapshot_formats{$format}{'disabled'}) {
>>> +		die_error(403, "Snapshot format not allowed");
>>> 	}
>>>
>>> 	if (!defined $hash) {
>>
>> Now I think that covers everything: preventing displaying known but
>> disabled snapshot formats in snapshots links in gitweb, and  
>> preventing
>> using known but disabled snapshot format.
>>
>> -- 
>> Jakub Narebski
>>
>> Git User's Survey 2009
>> http://tinyurl.com/GitSurvey2009
>
> --
> Mark A Rada (ferrous26)
> marada@uwaterloo.ca
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
