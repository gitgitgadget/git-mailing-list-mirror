From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git should not use a default user.email config value
Date: Sat, 10 Aug 2013 13:42:52 +0200
Message-ID: <5206273C.3050803@alum.mit.edu>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de> <20130809194214.GV14690@google.com> <20130809223758.GB7160@sigill.intra.peff.net> <20130809231928.GY14690@google.com> <20130810064717.GB30185@sigill.intra.peff.net> <52060EF9.2040504@alum.mit.edu> <20130810102834.GA6237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 10 13:43:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V87ZV-0005Py-4Y
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 13:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757671Ab3HJLm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 07:42:57 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63281 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757626Ab3HJLm4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Aug 2013 07:42:56 -0400
X-AuditID: 1207440d-b7f006d000000adf-2f-5206273f5de6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F9.C8.02783.F3726025; Sat, 10 Aug 2013 07:42:55 -0400 (EDT)
Received: from [192.168.69.140] (p4FDD46A2.dip0.t-ipconnect.de [79.221.70.162])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r7ABgq9R013995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 10 Aug 2013 07:42:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130810102834.GA6237@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsUixO6iqGuvzhZksP6ZrEXXlW4mi7c3lzBa
	/N+xgMXiR0sPs8Wz/t+MDqweO2fdZfc4dqyV2eNug6bHs949jB6fN8kFsEZx2yQllpQFZ6bn
	6dslcGdcnHKMueALd8XOlWtYGhiPcXYxcnJICJhIfH69hw3CFpO4cG89mC0kcJlR4us32S5G
	LiD7PJPE2y9bGEESvALaEvM3nGACsVkEVCV2fLwEFmcT0JVY1NMMFOfgEBUIk7jyWxWiXFDi
	5MwnLCC2iICsxPfDGxlBZjILdDNKLNmyCWyOsICjxPfHs5gglu1ikji3+QUjyCBOASuJbR+U
	QUxmAXWJ9fOEQMqZBeQltr+dwzyBUWAWkhWzEKpmIalawMi8ilEuMac0Vzc3MTOnODVZtzg5
	MS8vtUjXSC83s0QvNaV0EyMkvHl3MP5fJ3OIUYCDUYmH1+IHS5AQa2JZcWXuIUZJDiYlUd4d
	smxBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4zzxnDRLiTUmsrEotyodJSXOwKInzqi1R9xMS
	SE8sSc1OTS1ILYLJynBwKEnwNqsBDRUsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgH
	RWl8MTBOQVI8QHvrQdp5iwsSc4GiEK2nGI05/qyc+4mR413TvE+MQix5+XmpUuK8lSClAiCl
	GaV5cItgie0VozjQ38K8GSBVPMCkCDfvFdAqJqBV0w+zgKwqSURISTUw9t1k3rHqZU1Nmenx
	zVe0Pt3ZvuHF7P2bFruFpCarW0jetdj06/T8FnmFuQ94QzJOKsc9z246f9r84oUq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232091>

On 08/10/2013 12:28 PM, Jeff King wrote:
> On Sat, Aug 10, 2013 at 11:59:21AM +0200, Michael Haggerty wrote:
> 
>> On 08/10/2013 08:47 AM, Jeff King wrote:
>>> But I think MX records and deliverability is beside the point. Even in a
>>> case where we come up with a valid, deliverable address, is that what
>>> the user wants to have in their commit history for all time?
>>
>> I intentionally don't set user.email in my ~/.gitconfig because I use
>> different identities (on the same machine) depending on what project I
>> am committing to (open-source vs. work).  After I clone a repo, I *rely*
>> on Git reminding me to set user.email on my first commit, because I
>> invariably forget to set it myself.  And for me, *any* universal,
>> heuristically-determined email address would be wrong for me for at
>> least some repos.
> 
> So if I understand your use case, then you would be even happier if
> rather than giving a warning, git simply barfed and said "please set
> your identity before committing"?

Yes, definitely.

For the particular use case that I described, I wouldn't mind setting a
global setting "barfOnMissingEmail = true" because I always use the same
Linux account.  But for other uses cases that arise at my company,
people have to jump around from one computer to another, and it would be
more convenient if the barfing behavior was the default without the need
for a setting.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
