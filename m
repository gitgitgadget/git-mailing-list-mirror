From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: cvsimport and branches with "(" in the name
Date: Tue, 29 Apr 2008 20:45:42 -0400
Message-ID: <118833cc0804291745m2da2a3bdl21a9440e961afb6@mail.gmail.com>
References: <320075ff0804290022r56c9f4efx74a13d3502be212@mail.gmail.com>
	 <20080429155238.GA18494@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "GIT Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 02:46:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr0Su-0002ep-LQ
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 02:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336AbYD3App (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 20:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755153AbYD3Apo
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 20:45:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:3862 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577AbYD3Apo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 20:45:44 -0400
Received: by fg-out-1718.google.com with SMTP id l27so211140fgb.17
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 17:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xqWyYzsM8S/J6NBe7rruxU4zGOuV5uFo7VldnRNqfgs=;
        b=a0T7xLT+9E5ZJRRtJ8rDHzjs+qSLeFNfsClU2lB1eTVj3XNOC45Ah60yGJJDaWQwPrQ+u6pTCYOqYtkQ7jxGWty6dC+Tw03J3Mw4Pr6s3jQaYQUhk7HzGK1Lz2Yzbzg771c3M+lUfLlM0jYBMlk/YhImxfKUA/Cm9TfNM+zDsck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ARjyaadZLKeSrkQ4pJTIeI1n0pdo3Bo/on4N0LL5wG2Be5bp8UG6ylYUmKfA2cswenQ3HC9pvxTWh/Dv6rLYx3yzG4R+3josFIQm5quGQ0BwhXIa6rvWwIiZjQfmMwhw8e8QZp1YZpQuMMfOHajAUNGEPx5hi5AFy2nZ2WPuXy4=
Received: by 10.86.25.12 with SMTP id 12mr691331fgy.25.1209516342704;
        Tue, 29 Apr 2008 17:45:42 -0700 (PDT)
Received: by 10.86.76.7 with HTTP; Tue, 29 Apr 2008 17:45:42 -0700 (PDT)
In-Reply-To: <20080429155238.GA18494@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80775>

>  -       system("git-update-ref $remote/$branch $cid") == 0
>  +       system('git-update-ref', "$remote/$branch", $cid) == 0

I hope there are no further such system calls left.  This could run arbitrary
commands if one was tricked into importing an evil repository.

Morten
