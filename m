From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Fwd: gitweb trouble on fedora
Date: Fri, 26 Feb 2010 13:45:45 -0800
Message-ID: <4B884109.9090509@eaglescrag.net>
References: <f71da3d1002261329o1ec140f0y9ad56a61b26ccbfc@mail.gmail.com> <f71da3d1002261332s671d0010h7d196569ec8c911@mail.gmail.com> <4B883F65.6050909@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brent Payne <brent.payne@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 22:46:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl80S-00089E-GA
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 22:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966259Ab0BZVps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 16:45:48 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:35280 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966239Ab0BZVpr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 16:45:47 -0500
Received: from voot-cruiser.eaglescrag.net (173-21-222-212.client.mchsi.com [173.21.222.212])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o1QLjjp2017592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Fri, 26 Feb 2010 13:45:46 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <4B883F65.6050909@eaglescrag.net>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Fri, 26 Feb 2010 13:45:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141155>

Errr let me back that up - my gitweb-caching package in fedora doesn't
make reference to /var/cache/git at all - where is the code your trying
to run coming from?  Which iteration of the caching code are you using,
is it mainline, Jakub's, mine, fedora's?  Some additional information
would be helpful.

- John 'Warthog9' Hawley

On 02/26/2010 01:38 PM, J.H. wrote:
> Brent,
> 
> Make sure that /var/cache/git is owned by apache.  I assume your using
> gitweb-caching as opposed to gitweb on fedora.  This is a fedora bug
> though and should be filed on bugzilla.redhat.com
> 
> - John 'Warthog9' Hawley
> 
> On 02/26/2010 01:32 PM, Brent Payne wrote:
>> plain text version
>>
>> ---------- Forwarded message ----------
>> From: Brent Payne <brent.payne@gmail.com>
>> Date: Fri, Feb 26, 2010 at 1:29 PM
>> Subject: gitweb trouble on fedora
>> To: git@vger.kernel.org
>>
>>
>> I'm new to about everything, but I've hit my head on the wall for a
>> couple of hours, went through the gitweb README and INSTALL, online
>> tutorial, everything.
>>
>> I am having trouble getting gitweb running on a fedora box with apache.
>>
>> The apache error is
>> [Fri Feb 26 13:21:25 2010] [error] [client 127.0.0.1] [Fri Feb 26
>> 13:21:25 2010] gitweb.cgi: Can't opendir(/var/cache/git): Permission
>> denied
>> [Fri Feb 26 13:21:25 2010] [error] [client 127.0.0.1] [Fri Feb 26
>> 13:21:25 2010] gitweb.cgi:  at /var/www/cgi-bin/gitweb.cgi line 2432
>>
>>
>> Can anyone guess at what I'm doing wrong?
>>
>> Thanks,
>> Brent
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
