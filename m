From: Matt McCutchen <hashproduct@gmail.com>
Subject: Re: [PATCH] gitweb: make search form generate pathinfo-style URLs
Date: Mon, 02 Jul 2007 15:03:01 -0400
Message-ID: <1183402981.2664.10.camel@mattlaptop2>
References: <1183057027.6108.4.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 21:03:11 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5RB0-00015X-5S
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 21:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbXGBTDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 15:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbXGBTDF
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 15:03:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:42505 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbXGBTDE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 15:03:04 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1591312wxd
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 12:03:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=K2wWqlwk31323StkswcOyqAEA9d2HGtDmP+GfP44dFx7daveRByrzuDCezgrl/d/WaiHuGwY0mDBn+g64hPz2DU4zcMQO84qkto8vxrPxsDoxYg5IpBblOIczsufaUnCCYhDruRoMuOvWNzHb1Z9ihQPwTnM0vTPQB13y7hBMxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=mOa3vYSCHzFjZ8SLbVng250/vGDVx2JDzKWAwPXyAg8PWDJF6vrlvhqOjeK+vWd8aaMB4VtLJxALuWXGvQJHMPPBC5oeCL5InY5fBLBi2WnCFlTApAO2wG5F/MZnXxZ6FSN8YsjRQwzvc1eBUYno13y7AO+saPyZayI24Umeo40=
Received: by 10.90.113.18 with SMTP id l18mr5449955agc.1183402983473;
        Mon, 02 Jul 2007 12:03:03 -0700 (PDT)
Received: from ?192.168.1.10? ( [71.163.67.14])
        by mx.google.com with ESMTP id 7sm19076372agd.2007.07.02.12.03.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jul 2007 12:03:03 -0700 (PDT)
In-Reply-To: <1183057027.6108.4.camel@mattlaptop2>
X-Mailer: Evolution 2.10.2 (2.10.2-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51392>

On Thu, 2007-06-28 at 14:57 -0400, Matt McCutchen wrote:
> The search form generated traditional-style URLs with a "p=" parameter
> even when the pathinfo feature was on.  This patch makes it generate
> pathinfo-style URLs when appropriate.

I sent this patch four days ago but no one has commented or done
anything about it.  Please clue me in: is this typical, or did I do
something wrong or do I need to do something else?

Thanks,
Matt
