From: Richard Weinberger <richard@nod.at>
Subject: Re: git ate my home directory :-(
Date: Mon, 25 Mar 2013 23:09:56 +0100
Message-ID: <5150CB34.1030008@nod.at>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com> <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 23:10:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFb6-0005P3-Nh
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 23:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933500Ab3CYWKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 18:10:01 -0400
Received: from a.ns.miles-group.at ([95.130.255.143]:47834 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933436Ab3CYWKA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 18:10:00 -0400
Received: (qmail 25024 invoked by uid 89); 25 Mar 2013 22:09:59 -0000
Received: by simscan 1.3.1 ppid: 25017, pid: 25020, t: 0.0638s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO ?192.168.0.18?) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 25 Mar 2013 22:09:59 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219107>

Am 25.03.2013 23:06, schrieb Junio C Hamano:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Richard Weinberger wrote:
>>
>>> In my scripts I'm setting GIT_DIR to use git-fetch and git-reset without changing the
>>> current working directory all the time.
>>
>> Yeah, for historical reasons GIT_WORK_TREE defaults to $(pwd) when
>> GIT_DIR is explicitly set.
>
> And it *WILL* be that way til the end of time.  Unless you are at
> the top level of your working tree, you are supposed to tell where
> the top level is with GIT_WORK_TREE when you use GIT_DIR.  Always.
>
> And that is the answer you should be giving here, not implicit
> stuff, which is an implementation detail to help aliases.  I do not
> know how things will break when the end user sets and exports it to
> the environment, and I do not think we would want to make any
> promise on how it works.
>

Okay, I have to set GIT_DIR _and_ GIT_WORK_TREE to make my scripts safe again?
I've always set only GIT_DIR because it just worked (till today...).

Thanks,
//richard
