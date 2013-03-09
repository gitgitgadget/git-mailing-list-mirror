From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Sat, 09 Mar 2013 06:32:32 +0100
Message-ID: <513AC970.6030502@alum.mit.edu>
References: <5104E738.602@alum.mit.edu> <vpqfw0rb25c.fsf@grenoble-inp.fr> <5129A5B3.7020807@alum.mit.edu> <vpqd2vok9bv.fsf@grenoble-inp.fr> <512B4203.3090802@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6?= =?ISO-8859-1?Q?r=F0_Bjarmason?= 
	<avarab@gmail.com>, Chris Hiestand <chiestand@salk.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Mar 09 06:33:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UECP8-0008ND-JC
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 06:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab3CIFcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 00:32:39 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:53322 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750791Ab3CIFcj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Mar 2013 00:32:39 -0500
X-AuditID: 1207440c-b7ff06d0000008f7-eb-513ac9767809
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id C4.EB.02295.679CA315; Sat,  9 Mar 2013 00:32:38 -0500 (EST)
Received: from [192.168.69.140] (p57A24BB0.dip.t-dialin.net [87.162.75.176])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r295WXjs017065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 9 Mar 2013 00:32:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <512B4203.3090802@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqFt20irQoG0jn8Xxp9dZLNY+u8Nk
	sX17F6NF15VuJouG3ivMFpc+r2e1aHxSZLH68R12Bw6PnbPusntM/HKc1ePiJWWPG9e7GT0+
	b5LzOHD5MVsAWxS3TVJiSVlwZnqevl0Cd8bOdc1MBZc5Kr6c62dqYPzI1sXIySEhYCIx+fkm
	VghbTOLCvfVAcS4OIYHLjBKztyxkh3BOM0lMb5nNCFLFK6At8f5YAwuIzSKgKnH93kt2EJtN
	QFdiUU8zE4gtKhAm8XLJDjaIekGJkzOfANVzcIgI6Ev8nAy2gFngJ5PElm2PwGqEBTwlFl4/
	AnaFkMBqRol/y3hAbE4BHYk7X7cxg9jMQPa7vgdQtrzE9rdzmCcwCsxCsmIWkrJZSMoWMDKv
	YpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11MvNLNFLTSndxAiJBZ4djN/WyRxiFOBgVOLh/fDH
	MlCINbGsuDL3EKMkB5OSKG/lMatAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK86rOAcrwpiZVV
	qUX5MClpDhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4lCd68E0CNgkWp6akVaZk5JQhpJg5O
	kOFcUiLFqXkpqUWJpSUZ8aBYjS8GRitIigdobxNIO29xQWIuUBSi9RSjLsfud49eMAqx5OXn
	pUqJ87aDFAmAFGWU5sGtgCW+V4ziQB8L864FqeIBJk24Sa+AljABLfELtgBZUpKIkJJqYOws
	vcPN0B8d3j7j+bHrDA8YRRPunY16WnFCrPLDysL0Y8USi8r/8YTly7a7lCkbzjFv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217702>

On 02/25/2013 11:50 AM, Michael Haggerty wrote:
> On 02/25/2013 10:54 AM, Matthieu Moy wrote:
>> [...] Works for me. One minor knit: you've included 10-characters sha1s (this
>> comes from
>>
>>         self.short = read_output(['git', 'rev-parse', '--short=10', sha1])
>>
>> ), I'd find it better with shorter sha1s. In the case of branch update,
>> if the branch name is a bit long, it could be nice to save a few
>> characters.
>>
>> Why not just say "git rev-parse --short", without argument? This way,
>> the default is used, ie. AFAICT it uses 7 characters by default, but
>> will use more if needed to keep the unicity.
> 
> [...] I guess I will change the code to use $(git rev-parse --short) (i.e.,
> shorter SHA1s) but reserving 10 columns in tables for them (which can be
> done via Python string formatting in the templates).  That should give
> the best of both worlds.

I implemented this change (allow git to choose the SHA1 abbreviation
length) and just pushed it to github.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
