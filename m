From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Sun, 15 Jul 2012 06:38:09 +0200
Message-ID: <50024931.6050601@alum.mit.edu>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <loom.20120714T114314-421@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 06:46:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqGiX-0004O0-Da
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 06:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772Ab2GOEpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jul 2012 00:45:16 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:49952 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750708Ab2GOEpO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2012 00:45:14 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Jul 2012 00:45:14 EDT
X-AuditID: 1207440d-b7f236d000000943-31-500249333f78
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F8.15.02371.33942005; Sun, 15 Jul 2012 00:38:11 -0400 (EDT)
Received: from [192.168.69.140] (p57A253B5.dip.t-dialin.net [87.162.83.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q6F4c9FS021986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 15 Jul 2012 00:38:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <loom.20120714T114314-421@post.gmane.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqGvsyRRgsK5d3qLrSjeTxfuz/5kd
	mDx2zrrL7vF5k1wAUxS3TVJiSVlwZnqevl0Cd8afNvOCE2wVX079YWxgXMLaxcjJISFgIvH3
	wiVmCFtM4sK99WxdjFwcQgKXGSVWTj7MBOGcYZLYvewTI0gVr4C2xPaNDSwgNouAqsTWK+1M
	IDabgK7Eop5mIJuDQ1QgTGL6TnaIckGJkzOfgJWLCFhL/JpwghWkhFlAXKL/H1hYWMBZYuWc
	HWBThARyJf6e7gDbxClgJtF35TgbRLm1xLfdRSBhZgF5ieats5knMArMQrJgFkLVLCRVCxiZ
	VzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbopaaUbmKEBCjvDsb/62QOMQpwMCrx8O4U
	ZgoQYk0sK67MPcQoycGkJMr7ww0oxJeUn1KZkVicEV9UmpNafIhRgoNZSYRX4itjgBBvSmJl
	VWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYJ3sQfQUMGi1PTUirTMnBKENBMH
	J8hwLimR4tS8lNSixNKSjHhQhMYXA2MUJMUDtHcuSDtvcUFiLlAUovUUoyXHky+3bjFyLNh1
	D0h2fwGSQix5+XmpUuK8TSANAiANGaV5cOtgaeoVozjQ98K8XSBVPMAUBzf1FdBCJqCFs37+
	8wdaWJKIkJJqYBRzeRcgvvxuzjzlLZ5JB3bLTpws6z9Pp/9LltjmrBaOjMiXOtrlt/RvG3oz
	nD23MVDnCNeqUHEJDiX/qNvPd9Z7i26e9KZbLtHnWYXqlHJn9103mPWkks30Xvtu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201465>

On 07/14/2012 11:46 AM, Stefan N=E4we wrote:
>> From: Michael Haggerty <mhagger <at> alum.mit.edu>
>>
>> Add a new Python script, contrib/hooks/post-receive-multimail.py, th=
at
>> can be used to send notification emails describing pushes into a git
>> repository.  This script is derived from
>> contrib/hooks/post-receive-mail, but has many differences, including=
:
>
> Looks interesting!
>
> Do you have a fork of git.git somewhere that contains the script?
> (I find it so much easier these days to simply fetch another repo ins=
tead
> of applying patches with 'git am'.)

You can get it at github

     git://github.com/mhagger/git.git

branch "git-multimail".  If you try it out, please let me know how it=20
works for you.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
