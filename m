From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 17:28:09 +0100
Message-ID: <3f4fd2640908180928k1be7db20vdc81b5acc482f693@mail.gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <1250600335-8642-1-git-send-email-mstormo@gmail.com>
	 <4A8AD561.1020303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	bonzini@gnu.org, kusmabite@googlemail.com
To: "Johan 't Hart" <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:29:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRYS-0000Mz-FJ
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759324AbZHRQ2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759121AbZHRQ2J
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:28:09 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:38682 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758706AbZHRQ2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:28:08 -0400
Received: by vws2 with SMTP id 2so3190441vws.4
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9DAmSwWHP7iUDF+fHm+gxVK8e0ELWjPrLv9hzK86To8=;
        b=tRT7sAZ6yDA3RzQNWWuFo4WDC1bXKXl3s0YwaEnRvuu65Yh0Nixy4QvjtSi9Vqrr3j
         052a9gLO6FQOSb9yYt+Xhk8+ptkPHL1YnIIjwFcWO/2WJQWzS0J2dlDkCUOxaVp+0g27
         ZdHHtIg/+eZxfElnEG7y17TXB69We4mPrNTQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=voYgfMkChzy6yMNidBfguXf1COPfY6zEeKw0atGGCOzqCq5z7qu5u36Q06TYZfzBAX
         /iBPfsL4iLyCZAB1CA3jdgiqdnEIhDMx6UVMvZf96Htf/A4AwmnADCwD3NYZAXbScpOf
         OiBM5c2vnSggeuUjewPntSToIBb0lrFRpsYG0=
Received: by 10.220.127.134 with SMTP id g6mr7302172vcs.35.1250612889232; Tue, 
	18 Aug 2009 09:28:09 -0700 (PDT)
In-Reply-To: <4A8AD561.1020303@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126410>

2009/8/18 Johan 't Hart <johanthart@gmail.com>:
> Marius Storm-Olsen schreef:
>>
>> From: Marius Storm-Olsen <mstormo@gmail.com>
>>
>> By using GNU Make we can also compile with the MSVC toolchain.
>> This is a rudementary patch, only meant as an RFC for now!!
>>
>
> Would this mean that only the MSVC toolchain is used to build git in batch?
> Or does GNU Make create a .vcproj file like CMake? Because that ofcource is
> the whole purpose of using CMake. One can use the Visual Studio IDE to hack
> on git.

... unless you add a file to the vcproj, or change the project
settings: you'll need to update the CMake file and the Make file (for
the POSIX builds), otherwise you're going to break things.

- Reece
