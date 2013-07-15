From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 2/2] post-receive-email: deprecate script in favor
 of git-multimail
Date: Mon, 15 Jul 2013 10:17:10 +0200
Message-ID: <51E3B006.5010503@alum.mit.edu>
References: <1373789343-3189-1-git-send-email-mhagger@alum.mit.edu> <1373789343-3189-3-git-send-email-mhagger@alum.mit.edu> <20130715060245.GD2962@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Hiestand <chrishiestand@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michiel Holtkamp <git@elfstone.nl>,
	=?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmas?= =?ISO-8859-1?Q?on?= 
	<avarab@gmail.com>, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 10:17:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UydyD-0005LU-OB
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 10:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038Ab3GOIRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 04:17:17 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:56590 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752825Ab3GOIRQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jul 2013 04:17:16 -0400
X-AuditID: 12074411-b7f296d000001209-79-51e3b00bd9d5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 71.4E.04617.B00B3E15; Mon, 15 Jul 2013 04:17:15 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r6F8HBR5000577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 15 Jul 2013 04:17:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130715060245.GD2962@elie.Belkin>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsUixO6iqMu94XGgwcW78harZj5mt1j77A6T
	xbWTi1ks9nZ3slp0XelmsmjovcJsceP8LlaLtzeXMFpc+rye1aLxSZHF+7P/mR24Pc7tXcji
	sXPWXXaPiV+Os3qcffSA2ePiJWWPz5vkPA5cfswWwB7FbZOUWFIWnJmep2+XwJ2xd+NtpoJ/
	ohUTzks1MG4V7GLk5JAQMJH4NP8iK4QtJnHh3nq2LkYuDiGBy4wSu+cuYgJJCAlcY5L4ecwO
	xOYV0Jb4vXcpO4jNIqAqcfT0RRYQm01AV2JRTzNQPQeHqECYxJXfqhDlghInZz4BKxER0JB4
	/ukb2HxmgXYWiWOPPoIlhAViJJ4dm8gMsXg+o8TWnT1sIAlOAQOJmX/+g13HLKAj8a7vATOE
	LS+x/e0c5gmMArOQLJmFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RS
	U0o3MUIiRnAH44yTcocYBTgYlXh4M9QeBwqxJpYVV+YeYpTkYFIS5f2xGijEl5SfUpmRWJwR
	X1Sak1p8iFGCg1lJhHeZ8qNAId6UxMqq1KJ8mJQ0B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwM
	B4eSBO+StUBDBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGRGl8MjFWQFA/Q3rMg
	7bzFBYm5QFGI1lOMuhwHfmx5zyjEkpeflyolzvsEpEgApCijNA9uBSw9vmIUB/pYmFdgHVAV
	DzC1wk16BbSECWhJ82ywJSWJCClgMuI2mJLQJK53ym3xWV3hqU9ltJc6zn32fe2j 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230437>

On 07/15/2013 08:02 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> Add a notice to the top of post-receive-email explaining that the
>> script is no longer under active development and pointing the user to
>> git-multimail.
> 
> I think the spirit of this patch is sane.  Some thoughts on wording:
> 
> [...]
>> --- a/contrib/hooks/post-receive-email
>> +++ b/contrib/hooks/post-receive-email
>> @@ -2,10 +2,19 @@
>>  #
>>  # Copyright (c) 2007 Andy Parkins
>>  #
>> -# An example hook script to mail out commit update information.  This hook
>> -# sends emails listing new revisions to the repository introduced by the
>> -# change being reported.  The rule is that (for branch updates) each commit
>> -# will appear on one email and one email only.
>> +# An example hook script to mail out commit update information.
>> +#
>> +# ***NOTICE***: This script is no longer under active development.  It
>> +# has been superseded by git-multimail, which is more capable and
>> +# configurable and is largely backwards-compatible with this script;
>> +# please see "contrib/hooks/multimail/".  For instructions on how to
>> +# migrate from post-receive-email to git-multimail, please see
>> +# "README.migrate-from-post-receive-email" in that directory.
> 
> I think I'd say something like
> 
> (1)
> 	# An example hook script to mail out commit update information.
> 	#
> 	# This script is kept for compatibility, but it is no longer actively
> 	# maintained.  Consider switching to git-multimail, which is more
> 	# configurable and largely compatible with this script.  See
> 	# contrib/hooks/multimail/README.migrate-from-post-receive.
> 	#
> 	# This hook sends emails listing new revisions ...
> 
> or, if I wanted to emphasize the warning,
> 
> (2)
> 	# An example hook ...
> 	#
> 	# Warning: this script is kept for compatibility, but it is no longer
> 	# actively maintained.  Consider switching to ...
> 
> or, if I wanted to avoid seeming to promise that the script will be
> around in the future,
> 
> (3)
> 	# An example hook ...
> 	#
> 	# Warning: this script is no longer actively maintained.  Consider
> 	# switching to ...
> 
> I prefer (2), which makes it clear to the reader that it is dangerous
> to keep using the script (since no one is actively chasing down bugs)
> while also making it clear why a potentially buggy script with a good
> natural successor is still in contrib for now.  What do you think?

Honestly, as the main author of git-multimail, I am biased and think it
would be better for other people to make the decision about if/how/when
to annotate post-receive-email.  Any of your suggestions are fine with me.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
