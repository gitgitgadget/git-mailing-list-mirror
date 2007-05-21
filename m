From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [PATCH] rename dirlink to gitlink.
Date: Tue, 22 May 2007 01:12:02 +0200
Message-ID: <e7bda7770705211612w3ce1b7dew8d48f1ddeb7d100e@mail.gmail.com>
References: <20070521200828.GC5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Martin Waitz" <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue May 22 01:12:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqH2u-0001MY-Iw
	for gcvg-git@gmane.org; Tue, 22 May 2007 01:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718AbXEUXMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 19:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756509AbXEUXMF
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 19:12:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:11878 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755718AbXEUXMD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 19:12:03 -0400
Received: by wx-out-0506.google.com with SMTP id i26so1674wxd
        for <git@vger.kernel.org>; Mon, 21 May 2007 16:12:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wg6F4f82Je3R21IbQh/raV88sTX5KFB4LR6jq10pT48znlDrRAuFR6SLHUMucdsPipU4PIvN/7qklx13XepbWVSMkHSE4dvo1buoS5FwlytnPnSeeRC7Ie6GAPT5J2bKOAv5IOqxSni7kNuSsTpLX2tmbbWJUl+Lnr9OKSjV94M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X+MR8YcOLETYxCCefCmkXN56zBXiHYLaa4TcIqjRitADVjGatECT+6zj7EDEF2yWn5fUHEH9mBPFPtKujzw+RP6aT7xQAy02z4sJ0YTUP/XytZ2JaByhKPONvtPBDyN4kIoq/em27K/zvQ8VIBA4yv2uCC12cBKBynp0wvN6/ik=
Received: by 10.90.87.5 with SMTP id k5mr4208837agb.1179789122548;
        Mon, 21 May 2007 16:12:02 -0700 (PDT)
Received: by 10.90.97.14 with HTTP; Mon, 21 May 2007 16:12:02 -0700 (PDT)
In-Reply-To: <20070521200828.GC5412@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48061>

On 5/21/07, Martin Waitz <tali@admingilde.org> wrote:
> Unify naming of plumbing dirlink/gitlink concept:
>
> perl -pi -e 's/dirlink/gitlink/g' -e 's/DIRLNK/GITLINK/g'
> ---


Does this mean that the link doesn't necessarily has to be represented
as a directory (even though current code does it) ?

//Torgil
