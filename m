From: Richard Weinberger <richard@nod.at>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 14:07:44 +0100
Message-ID: <51519DA0.4090201@nod.at>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com> <7vboa7w2vm.fsf@alter.siamese.dyndns.org> <384BCFE976364F1EA6E56306566D003A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Mar 26 14:08:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKTbu-0005Gr-5a
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 14:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628Ab3CZNHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 09:07:50 -0400
Received: from a.ns.miles-group.at ([95.130.255.143]:47834 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932467Ab3CZNHt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 09:07:49 -0400
Received: (qmail 7410 invoked by uid 89); 26 Mar 2013 13:07:48 -0000
Received: by simscan 1.3.1 ppid: 7403, pid: 7406, t: 0.0730s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO ?192.168.0.15?) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 26 Mar 2013 13:07:48 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <384BCFE976364F1EA6E56306566D003A@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219158>

Am 26.03.2013 09:02, schrieb Philip Oakley:
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Monday, March 25, 2013 10:06 PM
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> Richard Weinberger wrote:
>>>
>>>> In my scripts I'm setting GIT_DIR to use git-fetch and git-reset without changing the
>>>> current working directory all the time.
>>>
>>> Yeah, for historical reasons GIT_WORK_TREE defaults to $(pwd) when
>>> GIT_DIR is explicitly set.
>>
>> And it *WILL* be that way til the end of time.  Unless you are at
>> the top level of your working tree, you are supposed to tell where
>> the top level is with GIT_WORK_TREE when you use GIT_DIR.  Always.
>
> Should this important warning be part of the git(1) documentation on the environment variables (and possibly other places) given the consequences of this case? It wasn't something
> I'd appreciated from a simple reading.

BTW: Can't we change git-clean such that it will not delete any files if GIT_DIR is set and GIT_WORK_TREE is "."?

Thanks,
//richard
