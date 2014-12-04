From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 00/13] the refs-transactions-reflog series
Date: Thu, 4 Dec 2014 09:53:43 -0800
Message-ID: <20141204175343.GA9992@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
 <54809577.4080302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, ronniesahlberg@gmail.com,
	gitster@pobox.com, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 04 18:53:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwabG-0002bL-EM
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 18:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911AbaLDRxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 12:53:53 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:52707 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932869AbaLDRxu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 12:53:50 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so20167972igi.5
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 09:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=U1L75u3tn0yMTonXbRVKXzkwo/UPwjW3s57bcs4QTiY=;
        b=Djzy3LwiQNKsOhxM1APrHzgDn4M8BDUJv6Fcv66hJ4jkx+QG3JufL/Q37y9LSzI2d1
         6hybsjFctc84iF2++CpSaprwwLeweXfoWsO0PBwsc+fSkuocKlwzvXb674Ls43yz2puv
         0d5J+gLpVMqnr2V+AiFK9mBKPjYZjnNpSta2k8/xqUjS8ib9LGot0n1Vt6KC0dDRuIAR
         f3rNPpDG7YPMWW3EmOWukySYEgNZjgn7orVzOTtvP6fRWpBHv+nOk+cKtyjtp3VhQhY1
         3vnCrP7DQb6MnsNSeEDE1p2lslsk8xfBKcbvF6xJmg6pwQTGLTdbVzKQe3/dFnR6JLAx
         6+iA==
X-Received: by 10.50.136.135 with SMTP id qa7mr14699237igb.32.1417715629685;
        Thu, 04 Dec 2014 09:53:49 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c1ad:3fe5:3da3:c161])
        by mx.google.com with ESMTPSA id h36sm5794033iod.17.2014.12.04.09.53.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 09:53:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54809577.4080302@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260770>

Hi,

Michael Haggerty wrote:
> On 12/04/2014 09:29 AM, Stefan Beller wrote:

>> This is the whole refs-transactions-reflog series[1],
>> which was in discussion for a bit already. It applies to origin/master.
>
> I am still unhappy with the approach of this series, for the reasons
> that I explained earlier [1]. In short, I think that the abstraction
> level is wrong. In my opinion, consumers of the refs API should barely
> even have to *know* about reflogs, let alone implement reflog expiration
> themselves.

Would it make sense to propose competing documentation patches (to
Documentation/technical/api-ref-transactions.txt, or to refs.h), so
we can work out the API that way?

I don't think the API questions that we're talking about would end up
affecting the details of how the files backend implements them too
much.

Jonathan
