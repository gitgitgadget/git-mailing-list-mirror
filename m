From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: User Authentication ?
Date: Mon, 13 Oct 2008 10:23:06 +0200
Message-ID: <200810131023.07312.jnareb@gmail.com>
References: <912ec82a0810110941t33343fe1mfe1bce58739f79fa@mail.gmail.com> <m3y70vj8ag.fsf@localhost.localdomain> <912ec82a0810130109k56e2e976kd00678e2ca3bc558@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Neshama Parhoti" <pneshama@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 10:25:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpIjI-0006Vh-1N
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 10:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbYJMIXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 04:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755704AbYJMIXN
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 04:23:13 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:57159 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756700AbYJMIXM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 04:23:12 -0400
Received: by ey-out-2122.google.com with SMTP id 6so536522eyi.37
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 01:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=g02LZFXpfJJYSeJRC5rNXKRwSYg4ax5e/c+hwd9yV8Q=;
        b=XJGy3bdE9VSsGzQpNc70HTR1LszC7+OcenJrXieANVGGoo9hzQtTIEdgPGx1mgG7BW
         NF5XblHJj0JnlpShxWJ7e8SwEMLS9WsZUr8vjyY7e4PnTTU3crRmCu0ndyotLi/zZbD+
         KrOG2R0YiGopjsh46gaKQFV30qPms6hY8PZa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kvZclDIzS9PYXa1VT/Y0CXm5q0u4nZzOJhYgCgfCpcyYaKafaGAxrvUSnHmddcFsRa
         zijbdh7aBYKTRwEltcSW/iGhlZoYXuM/G+QAX93SKQYYo1buftfiVwOHDsoE4q7LsKFG
         Tv/0jtb02HOINj9uD4dWcI8nqhjmcG8e0JPcE=
Received: by 10.210.130.14 with SMTP id c14mr5112210ebd.63.1223886191685;
        Mon, 13 Oct 2008 01:23:11 -0700 (PDT)
Received: from ?192.168.1.11? (abwv110.neoplus.adsl.tpnet.pl [83.8.245.110])
        by mx.google.com with ESMTPS id 20sm9479498eyc.9.2008.10.13.01.23.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 01:23:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <912ec82a0810130109k56e2e976kd00678e2ca3bc558@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98095>

Neshama Parhoti wrote:

> On Sat, Oct 11, 2008 at 8:28 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> "Neshama Parhoti" <pneshama@gmail.com> writes:
>>
>>> I want to setup a git server on the web but I need user
>>> authentication.
>>> I really don't want to give ssh logins for people who I just want to
>>> be able to access my repository...
>>
>> First, you can always set git-shell as shell for those git only
>> accounts. [...]
> 
> Thank you ! That should really be good. Any chance you are aware of
> documentation or further guidance about how to set this up ?

I have never had the need, but for Gitosis the seminal reference is
I think
  "Hosting Git repositories, The Easy (and Secure) Way"
  http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way

-- 
Jakub Narebski
Poland
