From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: use result of open(2) to check for presence
Date: Thu, 5 Jan 2006 09:48:16 -0500
Message-ID: <118833cc0601050648t17f68bcch8fd7c541585e965c@mail.gmail.com>
References: <81b0412b0601050343w4c00ac86y30569c3babbf6728@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 15:48:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuWPh-0003Up-Ve
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 15:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWAEOsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 09:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWAEOsS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 09:48:18 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:1339 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751354AbWAEOsR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 09:48:17 -0500
Received: by zproxy.gmail.com with SMTP id 14so3283512nzn
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 06:48:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mby6btr80yqJ765gCJ1qeixCAs6+VSjwh8XV3WyCvWKSsIuODacoZZXzn1OpY035n2kNUNEbxsBqEb4K2e367upPqTd/mwjQ8buLA/G1nRTnCRI/2Oxq/8OmGgle8lBMDOdJasYcf6HutO45Kdkzc+9OCksw4ITt0v/dUYzF49Q=
Received: by 10.37.22.26 with SMTP id z26mr6821266nzi;
        Thu, 05 Jan 2006 06:48:16 -0800 (PST)
Received: by 10.36.90.2 with HTTP; Thu, 5 Jan 2006 06:48:16 -0800 (PST)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0601050343w4c00ac86y30569c3babbf6728@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14198>

Neat, but perhaps you should check the fstat return code.
It actually can fail, for example if the filesize cannot be represented in the
structure because it is too big.

Morten
