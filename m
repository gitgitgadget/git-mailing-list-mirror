From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] defaults for where to merge from (take 3)
Date: Thu, 1 Mar 2007 11:42:16 +0100
Message-ID: <81b0412b0703010242t36cea2fdr676c1adb799c8077@mail.gmail.com>
References: <es450f$d58$1@sea.gmane.org> <45E68897.8000607@lu.unisi.ch>
	 <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
	 <45E68EDE.2090405@lu.unisi.ch>
	 <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
	 <45E69297.8070001@lu.unisi.ch>
	 <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
	 <45E69EEE.8070905@lu.unisi.ch>
	 <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
	 <7vvehls1h9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bonzini@gnu.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 11:42:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMijs-00020e-6v
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 11:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbXCAKmT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 05:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbXCAKmT
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 05:42:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:63760 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964930AbXCAKmS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 05:42:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so332622uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 02:42:17 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NE0w0usFKN5v4PSvfcxFvjXGM3rz4P3R4vXniKIxa3q6hysANy6zj1NscisJzWKPLwAOsfUxr67ybVzF4stqmzh9NDdjfh3q/GxahjM8kEACLwl+EFS1QsJCSzKyM5fQkCM57iiJsjMiAFgQk3C6v697xvKteae7btx61EI8x6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jfok7EhXUXctFLYEDdHGisSLa5tAPvxb0YN5NGrlnDBu/3sAx3xXZQI0KHd1eM+k75xtejp6SllUq6Cl2D0lGdY4JqMWXQYwfJtz0CIsUpgOGgm1goxzq2Q5k6cbPq7elE5EsuBkacIClrXtd30mYhdFN2vJH4BocfU4TUxN9bE=
Received: by 10.78.180.18 with SMTP id c18mr143107huf.1172745736471;
        Thu, 01 Mar 2007 02:42:16 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 02:42:16 -0800 (PST)
In-Reply-To: <7vvehls1h9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41079>

On 3/1/07, Junio C Hamano <junkio@cox.net> wrote:
> Also it would be nice if you guys can fight it out about the
> default value for 'tracked'.  I do not think _I_ can defend the
> position to create these tracking configurations by default to
> old timers (especially the ones that do not follow the git
> mailing list), as I am not convinced (not yet, anyway).

I agree with Dscho wrt the default, partly because I don't
care as long as I can change it, partly because the learning
curve curve can never be shallow enough and the less
surprises the better.
The oldtimers will have no problems changing the default,
and the option is properly documented in the patch.
