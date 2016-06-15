From: Joseph Pecoraro <pecoraro@apple.com>
Subject: Re: [PATCH] Document the 'svn propset' command.
Date: Wed, 15 Jun 2016 13:32:07 -0700
Message-ID: <BD0842E2-2AA2-40EB-B1FC-2097A1B7BF39@apple.com>
References: <20160612191550.GA14160@elvis.mu.org>
 <20160615051950.GA93388@elvis.mu.org> <20160615201556.GA6303@dcvr.yhbt.net>
 <xmqqvb1a5hlf.fsf@gitster.mtv.corp.google.com>
 <FBF1CB04-C2EE-4675-8FC0-69A48410BB48@freebsd.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
	git@vger.kernel.org, David Fraser <davidf@sjsoft.com>,
	Pranit Bauva <pranit.bauva@gmail.com>
To: Alfred Perlstein <alfred@freebsd.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 22:32:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDHUK-0002NN-Ow
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 22:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932893AbcFOUcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 16:32:18 -0400
Received: from mail-out6.apple.com ([17.151.62.28]:51364 "EHLO
	mail-in6.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753767AbcFOUcO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 16:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=apple.com; s=mailout2048s; c=relaxed/simple;
	q=dns/txt; i=@apple.com; t=1466022731; x=2329936331;
	h=From:Sender:Reply-To:Subject:Date:Message-id:To:Cc:MIME-version:Content-type:
	Content-transfer-encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-reply-to:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=22f0+6hWahprSboICsDLMftWEXvjf2ujlzigW72OttY=;
	b=1WD0fg+bWFPP4vIKqVY6r0WOdVNdOqn6NzJ3NTqa3FTAu6HNkmsoX18bnsID0ZTL
	gIoiBaGtmAPJG226JUaBsKFZXc9T50fcezwDL3SU08yaXkihby0f8VM5fhBd9kNt
	DGBIBJvNp8kGjVKCBWSLhJjvH2fpZjHRI5P7Olcen79DYMT/CWT07bucILgf/TKr
	V2tbHQuJperYWSPl9pE1DsUQ3AqMobWoSfoFZkiHi5GQHoZywBKw9vUCrj/rfl7a
	A6MZ15u6qMksLoHzJYtdQc8ckvQYW5Hgu2jvlqRDewgOeOSPRXVXBMLwMp/d6uTi
	78GR2di/xqNS0Twq4vAMcg==;
Received: from relay6.apple.com (relay6.apple.com [17.128.113.90])
	by mail-in6.apple.com (Apple Secure Mail Relay) with SMTP id BF.AA.27179.A4BB1675; Wed, 15 Jun 2016 13:32:11 -0700 (PDT)
X-AuditID: 11973e15-f79686d000006a2b-38-5761bb4a5cc9
Received: from chive.apple.com (chive.apple.com [17.128.115.15])
	(using TLS with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by relay6.apple.com (Apple SCV relay) with SMTP id 05.B3.28643.84BB1675; Wed, 15 Jun 2016 13:32:09 -0700 (PDT)
Received: from pecoraro.apple.com ([17.202.44.84])
 by chive.apple.com (Oracle Communications Messaging Server 7.0.5.35.0 64bit
 (built Mar 31 2015)) with ESMTPSA id <0O8T006QYYDKGP40@chive.apple.com> for
 git@vger.kernel.org; Wed, 15 Jun 2016 13:32:08 -0700 (PDT)
In-reply-to: <FBF1CB04-C2EE-4675-8FC0-69A48410BB48@freebsd.org>
X-Mailer: Apple Mail (2.3124)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsUi2FAYpeu9OzHc4O90douuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGWsmCxd8IWjYuP8x+wNjHPZuxg5OSQETCRufz3IDGGLSVy4t54N
	xBYS2MsoceFVLkzNuQcfgGq4gOLTmCQa1t9lhHC6mSQu/VrBClIlLCAlsX1aCxOIzSygJbF+
	53Ewm1dAT2Ly0QY2iBoLiR1X94NtYwOqebChEayGU8BeomfzPjCbRUBVYub/WywgC5gFFjJK
	LLm8AWqotsSTdxdYIYbaSFx+95sJ4oqnjBJ9t/eBbRAR0JQ4tXMvG8TdshJPTi5igbC/skr8
	7NCbwCgyC8mBs5AcOAvJjgWMzKsYhXITM3N0M/PM9BILCnJS9ZLzczcxgsJ7up3oDsYzq6wO
	MQpwMCrx8AqsTwwXYk0sK67MPcQozcGiJM77chpQSCA9sSQ1OzW1ILUovqg0J7X4ECMTB6dU
	AyOvzPMa9ygP9tpT9Vv1Q8z2XXhasnT77C+zxQ7nX3oZ2aN057DxuqypNk89deP2Nzjk3S9+
	2torJ+jJGukX1GVpM9HnaP1RseNn5n5WWuMR8/T2sWuHNsZ6+zrdv7kzd/7qLQ2fZvR53WxY
	yiTsNq3l2ZIjEwqlY6VdJb5OKe6+sdCbVeCVxiUlluKMREMt5qLiRADnAEkxUAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsUi2FDMr+u5OzHcYMUPa4uuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGWsmCxd8IWjYuP8x+wNjHPZuxg5OSQETCTOPfjADGGLSVy4t56t
	i5GLQ0hgGpNEw/q7jBBON5PEpV8rWEGqhAWkJLZPa2ECsZkFtCTW7zwOZvMK6ElMPtrABlFj
	IbHj6n6wqWxANQ82NILVcArYS/Rs3gdmswioSsz8f4sFZAGzwEJGiSWXN0AN1ZZ48u4CK8RQ
	G4nL734zQVzxlFGi7/Y+sA0iApoSp3buZYO4W1biyclFLBMYBWchOWoWkqNmIZm7gJF5FaNA
	UWpOYqWZXmJBQU6qXnJ+7iZGcEgWRu1gbFhudYhRgINRiYdXYH1iuBBrYllxZe4hRgkOZiUR
	3q+bgEK8KYmVValF+fFFpTmpxYcYpTlYlMR553sDpQTSE0tSs1NTC1KLYLJMHJxSDYxSRWHx
	q83m3WFUX+YRa8JxMcDM9NNiz9jVi2+FMla7qwhVyBktTz/UvW2m2pwjGyaZLLn6OLm1d+rZ
	Y4dVTuZUt/rMvH3wCYddoMah/+41kSuKPxy4c2OCkNOG/senJ5cHfLcR4r3Zvb/l4vfJusd3
	SjXuu61hIqNUynKBZaXvr3P2ver3+N4psRRnJBpqMRcVJwIAmoLSQ0UCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297400>

> On Jun 15, 2016, at 1:24 PM, Alfred Perlstein <alfred@freebsd.org> wrote:
> 
>> On Jun 15, 2016, at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Eric Wong <e@80x24.org> writes:
>> 
>>> Thanks Alfred,
>>> 
>>> I've removed the '.' from the commit subject, signed-off,
>>> and pushed to my repo for Junio:
>>> 
>>> The following changes since commit 05219a1276341e72d8082d76b7f5ed394b7437a4:
>>> 
>>> Git 2.9 (2016-06-13 10:42:13 -0700)
>>> 
>>> are available in the git repository at:
>>> 
>>> git://bogomips.org/git-svn.git svn-propset-doc
>>> 
>>> for you to fetch changes up to f3961b2eba8ba6aa2fddc827ddf5c26b41391872:
>>> 
>>> Document the 'svn propset' command (2016-06-15 20:11:22 +0000)
>> 
>> I actually queued it directly on top of v2.3.0-rc0~32^2 (git-svn:
>> support for git-svn propset, 2014-12-07) so that it could go to
>> older maintenance tracks.
>> 
>> I will pick up your Reviewed-by: and redo it.  Thanks.
>> 
> 
> Thank you, always great working with the git project!  
> 
> -Alfred 

Thanks for addressing this!

- Joe
