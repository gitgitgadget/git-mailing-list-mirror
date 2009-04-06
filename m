From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Fetching SHA id's instead of named references?
Date: Tue, 7 Apr 2009 01:50:36 +0400
Message-ID: <37fcd2780904061450t62cac214x7588e056a6450bab@mail.gmail.com>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>
	 <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
	 <33f4f4d70904060541s6dfb7e8ctf50f5e8a872ae1c@mail.gmail.com>
	 <alpine.DEB.1.00.0904061447220.6619@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Klas Lindberg <klas.lindberg@gmail.com>,
	Git Users List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 23:52:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqwjo-0002vC-8q
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 23:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759848AbZDFVun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 17:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759759AbZDFVum
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 17:50:42 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:52874 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759822AbZDFVuj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 17:50:39 -0400
Received: by fxm2 with SMTP id 2so2083561fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 14:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b4OOHLVoERfrQ2UdG4aFuDl8xlalJ2k+TM0vaOmn56s=;
        b=gYIOr3k+Yi3vNuaWzKgK8seMFyFvlGAYDqt57bBzR+FpMXfrBi4NjVwA0S/2CWYrEf
         jvx/mep05jkUPvR3ZBN4lzt15ynhp+/fe2wXq6SyfltNe3rWgioUmtswwwRiTir+rxKe
         ZUuC7QJYNR3hQlOT+LmSmVhxgerOvJ1Fyd7nU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g82yczVsnRl913CX8x+5QA4o/FgM4qTPXr+omBbMic9bpAjCVo1EsASyzehPBpyFFJ
         tMPNG8COH5bpUgv23zzbTXi/HYVp/w72nGwEW0rFqO983vDvXvPAirW2/izhVkTYQHpl
         u02d4uGGEiguWYNzMV0Xk+6hvDh5MMDaFgRyg=
Received: by 10.86.36.17 with SMTP id j17mr3493076fgj.19.1239054636419; Mon, 
	06 Apr 2009 14:50:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904061447220.6619@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115885>

On Mon, Apr 06, 2009 at 02:48:17PM +0200, Johannes Schindelin wrote:
>_
> The issue is not if someone manages to fetch stuff before you repair it.__
> The issue is that that someone should not be able to manage _after_ you_
> repair it.

But how this someone will know the exact SHA-1 needed to fetch this
commit without having seen this commit already? Guessing SHA-1 by
brute force attack does not sound very promising...

Dmitry
