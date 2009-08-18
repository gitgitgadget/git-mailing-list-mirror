From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 19:44:38 +0200
Message-ID: <4A8AE886.8090000@gnu.org>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>	 <1250600335-8642-1-git-send-email-mstormo@gmail.com>	 <4A8AD561.1020303@gmail.com> <3af572ac0908181006n2e00b561x374007bff2e2d31f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johan 't Hart <johanthart@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, kusmabite@googlemail.com
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 19:49:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdSom-0000FN-2W
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 19:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759480AbZHRRtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 13:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759383AbZHRRtq
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 13:49:46 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:38838 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759371AbZHRRtp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 13:49:45 -0400
Received: by bwz22 with SMTP id 22so3179574bwz.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=aZQLi1xOIwdi8rmijeAXM46lhAJdE41KbvmJd+Zvq8w=;
        b=h9LXO7C48Z2JukE78I4wvuCrx67ixKQt9mKvU+QlPi20uCcrSCyJ/FdqUSLj24eoK1
         WONzvDajVNjCpskgycHtq5kGaZ/DctdfKLn4dS8/AJ/bgxZexMMRPerWJGLsk5f4tXg9
         CMA+pz68dCviQ4fqVxxEtgfSL4jtKzHyTS9lE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=f0IJngbXckbUBTi9Evm8at2QWuzendm36RJyGV3/34RpslT302tSxAxutosSMYOnqo
         gCCRuFK7rxl1Iee59dwJIH78NKaOEMMFUauWccoUNk0UoK+dv1GAEmuAJLTQxVzF6uiI
         eqWnlP1ROfUDT6r8foGtMKc0/LT9ty5ZGOlgI=
Received: by 10.204.32.209 with SMTP id e17mr4012888bkd.84.1250617785147;
        Tue, 18 Aug 2009 10:49:45 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-str.redhat.com [66.187.229.200])
        by mx.google.com with ESMTPS id 9sm7036758fks.28.2009.08.18.10.49.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 10:49:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <3af572ac0908181006n2e00b561x374007bff2e2d31f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126429>


> CMake is also useful to create installers/tarballs (see CPack), run
> tests (see CTest; it's NOT a unit test library but a tests launcher on
> steroids) and submit the results of compilation, tests and
> installation to a dashboard where you can easily see what (if
> anything) went wrong (see CDash, formerly Dart).

If I know the git hackers, CMake will _never_ be used except _possibly_ 
for generating a .vcproj file.

Paolo
