From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/15] api-remote.txt: correct section "struct refspect"
Date: Thu, 24 Oct 2013 09:06:44 +0200
Message-ID: <5268C704.4020505@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>	<1382543448-2586-5-git-send-email-mhagger@alum.mit.edu> <xmqq1u3brfp5.fsf@gitster.dls.corp.google.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 24 09:06:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZF0P-0008Bj-8T
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 09:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554Ab3JXHGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 03:06:49 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44108 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751359Ab3JXHGs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Oct 2013 03:06:48 -0400
X-AuditID: 1207440f-b7f306d000006d99-07-5268c7083924
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id C6.A9.28057.807C8625; Thu, 24 Oct 2013 03:06:48 -0400 (EDT)
Received: from [192.168.69.9] (p57A24971.dip0.t-ipconnect.de [87.162.73.113])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9O76hjX016051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 Oct 2013 03:06:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <xmqq1u3brfp5.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsUixO6iqMtxPCPI4NpaDovpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFo8bSz0mLeixdsFj9aepgdOD0urXvJ5HHozxR2j2cn2tk8
	Lr38zubxrHcPo8fFS8oeM1pes3h83iTnceDyY7YAzihum6TEkrLgzPQ8fbsE7oytz9wL3vNU
	vP/4mqWBcQNXFyMHh4SAicSZ3wZdjJxAppjEhXvr2boYuTiEBC4zSnzqWsECkhASOMsksXwz
	mM0roC1x+GgrE4jNIqAqcW3VX3YQm01AV2JRTzNYXFQgRGLhquPsEPWCEidnPgHrFRFQk5jY
	dogFZAGzwH0mid89r8GKhAV8JM7d/ssCsXkVo8S6x4vAJnEKWEt8nrKMDcRmFtCReNf3gBnC
	lpfY/nYO8wRGgVlIlsxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqp
	KaWbGCERw7+DsWu9zCFGAQ5GJR5ejQ/pQUKsiWXFlbmHGCU5mJREeVWPZAQJ8SXlp1RmJBZn
	xBeV5qQWH2KU4GBWEuH1rADK8aYkVlalFuXDpKQ5WJTEedWXqPsJCaQnlqRmp6YWpBbBZGU4
	OJQkeI2OAjUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgyI1vhgYqyApHqC9uiDt
	vMUFiblAUYjWU4y6HPO+fPjGKMSSl5+XKiXOawxSJABSlFGaB7cClh5fMYoDfSzM+wPkPR5g
	aoWb9ApoCRPQkilL0kCWlCQipKQaGP3kt4qxPlo61+mAmNgztRwLY6E/apIeof8/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236568>

On 10/23/2013 08:43 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>> Subject: Re: [PATCH 04/15] api-remote.txt: correct section "struct refspect"
> 
> refspect???

Thanks for catching the typo.

>> * Replace reference to function parse_ref_spec() with references to
>>   functions parse_fetch_refspec() and parse_push_refspec().
>>
>> * Correct description of src and dst: they *do* include the '*'
>>   characters.
> 
>  * Replace a single SP after a full-stop at the end of sentence with
>    double SP as if we were back in the typewriter age.

:-)

I agree it's archaic, but it is standard practice in English.

Also, emacs, with the default sentence-end-double-space setting, doesn't
treat punctuation followed by a single space as an end of sentence and
when reflowing text even goes to extra effort not to break a line at
such a position (because that would make it look like it *were* the end
of the sentence).

TeX also distinguishes between interword spaces and end-of-sentence
spaces, but it uses a different heuristic (which can be overridden by
explicit markup).  It also typesets them differently: end-of-sentence
spaces are a bit wider and more elastic.

Nevertheless it is probably good that there is no Unicode
END_OF_SENTENCE_SPACE character; otherwise we would never get *any* work
done for all the arguing about how to encode empty pixels :-)

> The last one made it hard to spot what actually got changed,
> though.  The updated text otherwise looks correct.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
