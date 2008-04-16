From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Wed, 16 Apr 2008 15:56:18 -0500
Message-ID: <46a038f90804161356o7518ec72j3bfb4e9fe4e48852@mail.gmail.com>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
	 <20080416200107.GG3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nigel Magnay" <nigel.magnay@gmail.com>, git <git@vger.kernel.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 23:06:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmEgk-0000PU-P3
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbYDPU4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbYDPU4V
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:56:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:50082 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbYDPU4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:56:20 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1015480ugc.16
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=azDRRBEQ5j4n1gAr1hEqp90XwODCF8ZAV6HAysxjz5s=;
        b=IL2Z3OPJq5HwlRRy9yNeTxSixcL0vdY9sRW9SmcvyLcB6AERJ+w59Zc3UR4m5ogkKVRCylioUnM2ymb2tw5uJOoGbq4vRFAik0sEIIfYdTspK2eTZId5lteRcOyKFJfAWaAR/zCdl5ANkbuwB2vmmTXYCGAd9gmK41KZov1PALI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ECfIRJ3J0rRIABuQhsirySqdT1aC5rPnSQ/MzJfEqMFQ9yBSZxYRulw7uIWGiSGLybGnmMdFfqsPvBN1YewOVuDjedrVux0746KGItq4akcM7UuXTb5IRTmH3pslcz/AnJXx39ssX7tPHCi0NK6MheX3Fwl5e4WnhcM2HbhSWRw=
Received: by 10.66.244.2 with SMTP id r2mr7416374ugh.64.1208379379057;
        Wed, 16 Apr 2008 13:56:19 -0700 (PDT)
Received: by 10.66.252.2 with HTTP; Wed, 16 Apr 2008 13:56:18 -0700 (PDT)
In-Reply-To: <20080416200107.GG3133@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79751>

On Wed, Apr 16, 2008 at 3:01 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
>  core.autocrlf=false is a bad choice for Windows.
...
>  If you do not want problems, you should use core.autocrlf=true
>  on Windows.

If you are making the above statements in generally about git, I
disagree. I have used msysgit a lot with unix-newlines projects, and
it works fantastic. I am careful to work with newline-smart editors
but any half-decent editor will cope. The general hint is: avoid any
content-mangling options if possible, and git will do the right thing.

OTOH, you might be referring to git-svn on Windows, which I have no
experience with :-)

cheers,



martin
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
