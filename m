From: Martin Nordholts <enselic@gmail.com>
Subject: Re: [PATCH] Clarify the git-branch documentation of default start-point
Date: Thu, 18 Jun 2009 19:21:55 +0200
Message-ID: <4A3A77B3.8070502@gmail.com>
References: <1245303673.24201.3.camel@localhost.localdomain>	<7vprd2148u.fsf@alter.siamese.dyndns.org>	<1245305061.24201.12.camel@localhost.localdomain> <7v63eu0ze4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 19:20:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHLHM-0001n1-0X
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 19:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbZFRRTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 13:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753340AbZFRRTu
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 13:19:50 -0400
Received: from iph1.telenor.se ([195.54.127.132]:45644 "EHLO iph1.telenor.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871AbZFRRTt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 13:19:49 -0400
X-SMTPAUTH: 
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtQCAB8UOkrDNmV6mWdsb2JhbACYZQEBAQEBCAsKBxOnEpIEhAgF
X-IronPort-AV: E=Sophos;i="4.42,245,1243807200"; 
   d="scan'208";a="22186565"
Received: from ironport2.bredband.com ([195.54.101.122])
  by iph1.telenor.se with ESMTP; 18 Jun 2009 19:19:49 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtVfAFsUOkrVcX8QPGdsb2JhbAAIiVWOfgEBAQE3pyaSBIQIBQ
X-IronPort-AV: E=Sophos;i="4.42,245,1243807200"; 
   d="scan'208";a="503585557"
Received: from c-107f71d5.017-113-6c756e10.cust.bredbandsbolaget.se (HELO [192.168.1.2]) ([213.113.127.16])
  by ironport2.bredband.com with ESMTP; 18 Jun 2009 19:19:49 +0200
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7v63eu0ze4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121860>

Junio C Hamano wrote:
>> What I am trying to clarify is that a remote branch will never be the
>> default for the start-point argument to git-branch, so if someone wants
>> a remote branch as start-point, then the branch must be explicitly
>> specified.
>>     
>
> Because I misread your updated documentation, somehow I thought you were
> talking about "checkout -b".  Sorry for getting confused (and perhaps
> giving a confusing answer).
>
> There are two concepts you seem to be confused about: <start-point> and
> branch tracking.
>   

I indeed confused these concepts and I think your patch makes the 
documentation clearer here

 / Martin
