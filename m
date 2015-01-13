From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: commit --amend --author   error
Date: Tue, 13 Jan 2015 12:24:18 +0100
Message-ID: <54B50062.3090209@drmicha.warpmail.net>
References: <54B4D428.2050300@irisgermanica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Gunnar Wagner <gunnar.wagner@irisgermanica.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 12:24:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAzaC-0006ug-6a
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 12:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbbAMLYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 06:24:20 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46023 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751355AbbAMLYT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2015 06:24:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 68EF9207A2
	for <git@vger.kernel.org>; Tue, 13 Jan 2015 06:24:19 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 13 Jan 2015 06:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=tMBnJE099CpIgxLrVZhzCE
	8TVM8=; b=Uho1IlmwP9dmaTvOXXIOFhgqjeqLf6Bi/EpH3qefRbSb18Cz+t4Tp2
	OFsNVxfxrZa2HHAV8sexAM2kGRvhEs05TecnLnCa9zBvwsboloWjB4e75zZdrMF4
	lUBlo4TuSxMnl4LwJOGJvjc/HIGukbVRoQOop1Elnh8vAiPHRy2/4=
X-Sasl-enc: 3XD7st0GCLvLpuv0L1H3SBQoUfaln1EFnRybqwy5iBbE 1421148259
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DA71FC00018;
	Tue, 13 Jan 2015 06:24:18 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54B4D428.2050300@irisgermanica.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262336>

Gunnar Wagner schrieb am 13.01.2015 um 09:15:
> I got APGL licensed code from someone else and want to post it on my 
> github (without taking credit for the work)
> 
> tried   git commit --amend --author="Author name, www.website.com" but 
> got an error message which said something like "original author not found"
> Can it be that the --amen --author only work if the author is on github 
> himself?
> 

This has nothing to do with github.

The author has be in the form "authorname <authoremail>". The important
parts for the format are the <>.

Michael
