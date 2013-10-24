From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 02/15] t5510: prepare test refs more straightforwardly
Date: Thu, 24 Oct 2013 08:49:50 +0200
Message-ID: <5268C30E.4050906@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>	<1382543448-2586-3-git-send-email-mhagger@alum.mit.edu> <xmqq61snrg0q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 08:57:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZEqt-0001dR-4b
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 08:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab3JXG46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 02:56:58 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:51376 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751533Ab3JXG45 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Oct 2013 02:56:57 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Oct 2013 02:56:57 EDT
X-AuditID: 1207440e-b7fbc6d000004ad9-27-5268c3138c3f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 98.77.19161.313C8625; Thu, 24 Oct 2013 02:49:55 -0400 (EDT)
Received: from [192.168.69.9] (p57A24971.dip0.t-ipconnect.de [87.162.73.113])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9O6nogQ015415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 Oct 2013 02:49:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <xmqq61snrg0q.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsUixO6iqCt8OCPIYMYdJYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFo8bSz0mLeixdsFj9aepgdOD0urXvJ5HHozxR2j2cn2tk8
	Lr38zubxrHcPo8fFS8oeM1pes3h83iTnceDyY7YAzihum6TEkrLgzPQ8fbsE7oy765vZCu4I
	Vhz6/4a5gXEDXxcjJ4eEgIlE57zV7BC2mMSFe+vZuhi5OIQELjNKvH+xjwnCOcsk8eTXFeYu
	Rg4OXgFtiZMr5UAaWARUJZ4s2M0GYrMJ6Eos6mlmArFFBUIkFq46DjaUV0BQ4uTMJywgtoiA
	msTEtkMsIDOZBe4zSfzueQ1WJCzgJbHo9UpGiGWrGCWazz8G6+AUsJbY+aCdFcRmFtCReNf3
	gBnClpfY/nYO8wRGgVlIlsxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrGermZ
	JXqpKaWbGCFRw7eDsX29zCFGAQ5GJR5ejQ/pQUKsiWXFlbmHGCU5mJREedkOZQQJ8SXlp1Rm
	JBZnxBeV5qQWH2KU4GBWEuH1rADK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbB
	ZGU4OJQkeF8cBGoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VrfDEwXkFSPEB7
	VUBu4i0uSMwFikK0nmLU5Zj35cM3RiGWvPy8VClxXkWQIgGQoozSPLgVsBT5ilEc6GNhXjWQ
	Kh5geoWb9ApoCRPQkilL0kCWlCQipKQaGDmWZ/2u7IgqmWD/MdtuoxHXxpwJiv7M 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236567>

On 10/23/2013 08:36 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> "git fetch" was being used with contrived refspecs to create tags and
>> remote-tracking branches in test repositories in preparation for the
>> actual tests.  This is obscure and also makes one wonder whether this
>> is indeed just preparation or whether some side-effect of "git fetch"
>> is being tested.
>>
>> So use the more straightforward commands "git tag" / "git update-ref"
>> when preparing branches in test repositories.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  t/t5510-fetch.sh | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index c5e5dfc..08d8dbb 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -88,7 +88,7 @@ test_expect_success 'fetch --prune on its own works as expected' '
>>  	cd "$D" &&
>>  	git clone . prune &&
>>  	cd prune &&
>> -	git fetch origin refs/heads/master:refs/remotes/origin/extrabranch &&
>> +	git update-ref refs/remotes/origin/extrabranch master &&
> 
> As long as you have checked that our local 'master' should be at the
> same commit as the origin's 'master' at this point, I think this
> change is OK.

It doesn't matter what the reference points at; the only point of these
tests is to check whether branches that look like stale remote-tracking
branches are pruned or not by the later command.

> I wouldn't call the use of "very explicit, without any room for
> mistake" refspecs "contrived", though.

According to Wiktionary, contrived means "unnatural, forced".

When the goal is just to create a local reference whose contents are
irrelevant, "fetch" is not the first command that comes to my mind.  It
brings a lot of unnecessary machinery to bear on such a trivial task.
Plus it is not very common in daily life to invoke "fetch" with a
complicated, asymmetic refspec like this.  Because of that it cost me a
little extra time to convince myself that the "fetch" command wasn't
trying to do something more.  In that sense it seems "contrived" to me.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
