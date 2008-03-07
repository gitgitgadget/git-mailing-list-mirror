From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: Problems building git with custom curl installation
Date: Thu, 6 Mar 2008 20:37:15 -0500
Message-ID: <9b3e2dc20803061737l1832fb82g6532808b58a12ab5@mail.gmail.com>
References: <47D08EA7.8000607@gravity.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ian Hinder" <hinder@gravity.psu.edu>
X-From: git-owner@vger.kernel.org Fri Mar 07 02:38:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXRX3-0005yi-95
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 02:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760474AbYCGBhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 20:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761131AbYCGBhS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 20:37:18 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:4140 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764293AbYCGBhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 20:37:16 -0500
Received: by rv-out-0910.google.com with SMTP id k20so92292rvb.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 17:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O7cDvJV0X02mzBYP6kkVmDROxn9HFl81JFMFsME0VQU=;
        b=A3IdB8t6ElRVgDS0U/VwLjLeXCGShWnuijx2EN7GBTKFouxX2Otc5RJpvXEX2CVeNivAYcTnStPJKg+JnbZ+CsaShKh/2stlWHW/WdsuwBK46OEMlUlGTRZ2oTuK3oDs6o524qvJQthQKLpHiJBTJ3BR1bPSiw9tOXr1cby2o94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TQwoFRrInBhFt3prIVAfI2kR/YggWmNsJJ6S97OptBHfXqivYjrZCLYeiIM6yzLDmqOR/n4zpiey6bCJ6gpnNiUKky2Sz2SmqtyA2q40z9HZlWeuyW/SCruXl3tlvlb8z6Q/vt8C1QMX030o1sGGHSCme7iDdHyx+IvhkuFbW3I=
Received: by 10.140.148.3 with SMTP id v3mr284045rvd.64.1204853835690;
        Thu, 06 Mar 2008 17:37:15 -0800 (PST)
Received: by 10.140.188.1 with HTTP; Thu, 6 Mar 2008 17:37:15 -0800 (PST)
In-Reply-To: <47D08EA7.8000607@gravity.psu.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76445>

On Thu, Mar 6, 2008 at 7:39 PM, Ian Hinder <hinder@gravity.psu.edu> wrote:
[snip]
>  1. Configure: Specifying the curl location leads to output that
>  indicates that curl was not correctly located, even though a
>  subsequent make finds it successfully and includes it in the build.

I'd just like to add that configure also doesn't detect and warn about
a missing gettext package, which became evident to me today when I
tried compiling it on a newly installed machine.  The configure is
successful, but the build fails.


Steve
