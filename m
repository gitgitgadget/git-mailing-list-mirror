From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/3] merge -Xindex-only
Date: Tue, 09 Jul 2013 21:38:13 +0200
Message-ID: <51DC66A5.80500@alum.mit.edu>
References: <cover.1373219466.git.trast@inf.ethz.ch> <51DAD8F2.5070008@alum.mit.edu> <87k3l1gip1.fsf@linux-k42r.v.cablecom.net> <51DBDB6F.7090105@alum.mit.edu> <878v1gey16.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 09 21:38:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwdjy-00009i-KV
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab3GITiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:38:18 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63025 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752493Ab3GITiS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 15:38:18 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-f8-51dc66a9996a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F7.8C.17335.9A66CD15; Tue,  9 Jul 2013 15:38:17 -0400 (EDT)
Received: from [192.168.69.140] (p57A24C98.dip0.t-ipconnect.de [87.162.76.152])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r69JcEXW002131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 9 Jul 2013 15:38:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <878v1gey16.fsf@linux-k42r.v.cablecom.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqLsy7U6gwekjEhZdV7qZLO5eXsXu
	wORx+/V8Zo/Pm+QCmKK4bZISS8qCM9Pz9O0SuDN6n6xlLpjLW3H7+TOmBsadXF2MnBwSAiYS
	R6/dYIWwxSQu3FvP1sXIxSEkcJlRYub1TiYI5xyTxPrX01lAqngFNCWePTnDBmKzCKhKPNs6
	FSzOJqArsainGaiBg0NUIEziym9ViHJBiZMzn7CAhEUElCW2LawBMZmBqh++SQQxhQW0Ja50
	W0IsOsUoca/nK9hwTgFziXNvpoHZzAI6Eu/6HjBD2PIS29/OYZ7AKDALyYJZSMpmISlbwMi8
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMkSPl2MLavlznEKMDBqMTDe0Dh
	TqAQa2JZcWXuIUZJDiYlUd4fyUAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrxJfEA53pTEyqrU
	onyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE75JUoEbBotT01Iq0zJwShDQTByfI
	cC4pkeLUvJTUosTSkox4UJTGFwPjFCTFA7R3Hkg7b3FBYi5QFKL1FKMux4EfW94zCrHk5eel
	SonzrgcpEgApyijNg1sBS0mvGMWBPhbm3QhSxQNMZ3CTXgEtYQJasicFbElJIkJKqoExhOP8
	Qm1nwcWR2rcka+XlVVS+S0g8MVASFrGaYqZ3euevI9Nq105rvdDa9l9d+1Be7XXnxd4zOh0m
	7OjY4fU+offLoRvxW4QfSbY9NNeeq52w7LjOAtH4bUcmb+KMdd17ULrc+3jmiWRD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229985>

On 07/09/2013 02:08 PM, Thomas Rast wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Since you've already implemented a way to merge into the index (even an
>> alternative index) without touching the working copy, I'll just cross my
>> fingers and hope for the appearance of an option that makes merge leave
>> HEAD, MERGE_HEAD, etc. untouched.
> 
> The most annoying part is probably where to put the output, since
> merging is more or less defined to do one of:
> 
> - update HEAD and return 0
> - update MERGE_HEAD and return 1

I don't understand what you mean here.  Why does *any* reference need to
be updated?  Why not

* load arbitrary commit-ish A into index

* merge arbitrary commit-ish B into index

* return error/OK depending on whether there was a conflict

?  The script that started the whole process would know what A and B are
and could create the commit itself using "git write-tree" and "git
commit-tree -p A -p B".  And if the index were an alternative index
chosen via GIT_INDEX_FILE then the rest of the git repo would be none
the wiser.

> I'm not sure how much flexibility is worth having.  Would it be
> sufficient if you had an option, e.g. -Xresult-ref=refs/heads/foo, that
> changes it to:
> 
> - update refs/heads/foo and return 0
> - return 1, not updating any refs
> 
> That would mean that it would only work for noninteractive use.  In the
> conflicting case, the driving script would need to remember what it
> wanted to merge so as have the information when finally committing.

That would be fine with me.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
