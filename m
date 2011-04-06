From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Wed, 06 Apr 2011 09:04:45 -0400
Message-ID: <4D9C64ED.4030900@mit.edu>
References: <4D9B310A.9020203@mit.edu> <1302034509-8842-1-git-send-email-asedeno@mit.edu> <4D9B7A9E.6040902@mit.edu> <4D9C6262.2080408@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 15:05:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7SPy-0007qo-95
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 15:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963Ab1DFNE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 09:04:59 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:65049 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755870Ab1DFNE7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 09:04:59 -0400
X-AuditID: 12074424-b7cacae000003d70-aa-4d9c64d18e8f
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 73.A2.15728.1D46C9D4; Wed,  6 Apr 2011 09:04:18 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id p36D4vV7027580
	for <git@vger.kernel.org>; Wed, 6 Apr 2011 09:04:57 -0400
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p36D4uQp013602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 6 Apr 2011 09:04:57 -0400 (EDT)
Received: by darkmatter.mit.edu (Postfix, from userid 108)
	id E2F9A14C029; Wed,  6 Apr 2011 09:04:55 -0400 (EDT)
Received: from [18.238.2.136] (JABUN.MIT.EDU [18.238.2.136])
	by darkmatter.mit.edu (Postfix) with ESMTPSA id AFAB114C00F;
	Wed,  6 Apr 2011 09:04:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D9C6262.2080408@drmicha.warpmail.net>
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixCmqrHspZY6vwcOrzBZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4Mo4ffgjY8Ei1or527eyNDDOZOli5OSQEDCR2LrhGhOELSZx4d56
	ti5GLg4hgX2MEos/NzGDJIQETjJK3JjHApH4yCTx/eBXRohEkcTab7eZIRKLGSXu3VrECpLg
	FVCTWP3nIXsXIwcHi4CqxO1WUZAwm4CLxJLH19hAbFGBTImOPe/ZIcoFJU7OfAJ2kYiAvsS1
	c09YQWYyC8xilHg0eyLYFcICHhLTjq2GWjaHUWLW1mdgCU6gH/6s3MIM8YOkxOnjR5hAFjML
	qEusnycEEmYWkJfY/nYO8wRGkVlI9s1CqJqFpGoBI/MqRtmU3Crd3MTMnOLUZN3i5MS8vNQi
	XXO93MwSvdSU0k2MoJBnd1HZwdh8SOkQowAHoxIP7+nFs32FWBPLiitzDzFKcjApifJeSJjj
	K8SXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE1/T1LF8h3pTEyqrUonyYlDQHi5I47zxJdV8hgfTE
	ktTs1NSC1CKYrAwHh5IEb14y0FDBotT01Iq0zJwShDQTByfIcB6g4ROAKUKIt7ggMbc4Mx0i
	f4pRUUqctxgkIQCSyCjNg+uFpaRXjOJArwjzhoNU8QDTGVz3K6DBTECDt06ZDTK4JBEhJdXA
	OEdC11vVtP5+RdNz5lnRKvx+80IiZ9sxPHwxvf5mctYLF46PT6pMppa8PR904Zv9/CNLW0+J
	vFwpOf/8uYOLp39f1iWwNeDHEXGvD64aLGLGX26emrCVzTxA8gRj077PS6fVXZs8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170973>

On 4/6/2011 8:53 AM, Michael J Gruber wrote:
>> > So I'm continuing to look into that. Perhaps it makes sense to use pushurl
>> > for both src and dst when branching?
> For branching, yes. This is just the following in disguise:
> 
> http://permalink.gmane.org/gmane.comp.version-control.git/135577
> 
> "svn cp" between 2 URLs simply requires they're within the same repo.

Yeah, I understand that. The purpose of that email was to make sure that
the patch was not committed as is, and it was hastily written because I
was practically out the door at the time.

Thanks for the pointer though.

I'll be sending an updated patch in a few hours.

-Alejandro
