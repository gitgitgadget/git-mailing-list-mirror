From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git send-email doesn't work with IPv6 and STARTTLS
Date: Thu, 1 May 2014 11:05:46 -0700
Message-ID: <20140501180546.GA9218@google.com>
References: <53615259.90200@mirix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen_Ullrich@genua.de
To: Matthias-Christian Ott <ott@mirix.org>
X-From: git-owner@vger.kernel.org Thu May 01 20:05:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfvMr-000218-BT
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 20:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbaEASFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 14:05:53 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51479 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaEASFx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 14:05:53 -0400
Received: by mail-pa0-f46.google.com with SMTP id kx10so1263690pab.33
        for <git@vger.kernel.org>; Thu, 01 May 2014 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tVWKTPnK2kujv5QAUzmYw63UdC5y3npfFTkC+OIc8vg=;
        b=RpOVIKD/iX5AKx9icoS44TYmJ7svweVrdITtt5eCN6bwKGZ39Xbuki6Tt/bEbvrwQm
         kbyEOrmLL97O6qmEG4uhDNxvMF2wAVI0RWx3AF9oZEEUyLIIpfFrUURgAodkfAygRMM0
         eNGqRxrNyH+vxpQqeftPt4jpAmRoRrA4ggA4vvNWLupB3eCzZLvrQ+aRlD9zB2ezlN5l
         0WQj3ovdH5b9sIRrHc6Ag+iMLLBakqDk5ltcNoTTc9eOBD6OY1uhYGFExmj04JcYsiIC
         sZCtc31aGVHRG5WMXjKuH/uuEiscvqwsD1ug5fxejy9Zkih6Wme6Xadbrqir+rxqwuPc
         8onQ==
X-Received: by 10.66.180.141 with SMTP id do13mr23717539pac.93.1398967552355;
        Thu, 01 May 2014 11:05:52 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ey5sm162571421pab.22.2014.05.01.11.05.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 01 May 2014 11:05:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53615259.90200@mirix.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247821>

Hi,

Matthias-Christian Ott wrote[1]:

> git send-email uses Net::SMTP connections that use STARTTLS. Net::SMTP
> does not support IPv6. I patched Net:SMTP to use IO::Socket::INET6 and
> it worked.

Thanks for reporting.

 1. What version of Net::SMTP do you use?

 2. Would you be willing to contribute your patch to Net::SMTP upstream,
    for example by mailing it to bug-libnet@rt.cpan.org with
    the string "[rt.cpan.org #93823]" somewhere in the subject line[2]?

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/247769
[2] https://rt.cpan.org/Public/Bug/Display.html?id=93823
https://rt.cpan.org/NoAuth/RT/CPAN/Usage.html
