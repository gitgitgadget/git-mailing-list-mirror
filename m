From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: [PATCH] Mention libiconv as a requirement for git-am
Date: Wed, 1 Aug 2007 00:36:31 -0300
Message-ID: <f329bf540707312036v26e553d6n2b0f99e53ca0aabb@mail.gmail.com>
References: <20070731150948.GA9947@localhost>
	 <f329bf540707312003i60e910e9kf97d2f50fdecbed2@mail.gmail.com>
	 <fcaeb9bf0707312018p25297d76g50489fa303856dd6@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <J.Sixt@eudaptics.com>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 05:36:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG50w-0000jx-BK
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 05:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbXHADgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 23:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbXHADgd
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 23:36:33 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:8303 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbXHADgd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 23:36:33 -0400
Received: by py-out-1112.google.com with SMTP id d32so143022pye
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 20:36:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CBi4+MDcsQwSzJ2k7m2vOaPjGJHW9Gpa6Mgx+1+6uoASIGxbbalUZk91O5gk5xvroprV28Ne3GCeCCfras1WS0oPJ1NreCGY5RJBaELaDZt0DkbpYQo4W0TI1eUNJuHbI8MLLCIku7+DoWVI2JAbVbfn+/ALR6RzVtxS/fE1Xps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HDSJ5gyGZqJCrIHzVRGv2hWM5Q9vjl4760fQJmCd2Ab1uUOstu/dA/aX4ard9zAgPmiNt7rKDy4NOUig2bpar/ZZn/KC+XT8tQvw8EC9MZf2Vs4Mb6CxMPV6jnRLfRrsroieDgTTfntEoKF05Du5olMP8wbKdBVBtn3RMY0l4b8=
Received: by 10.64.208.20 with SMTP id f20mr326070qbg.1185939391749;
        Tue, 31 Jul 2007 20:36:31 -0700 (PDT)
Received: by 10.65.157.11 with HTTP; Tue, 31 Jul 2007 20:36:31 -0700 (PDT)
In-Reply-To: <fcaeb9bf0707312018p25297d76g50489fa303856dd6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54403>

2007/8/1, Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> I'm sorry I judged by reading Makefile without actually testing your
> installation, so I might be wrong. By default Makefile set
> NO_ICONV=YesPlease on MinGW so it won't use libiconv even if it
> exists. You need to unset NO_ICONV and set NEEDS_LIBICONV in
> config.mak in order to enable it.

this is done automatically when running configure. If you find a
problem with the installer please let me know.

> I'm going to test it tomorrow.



-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
