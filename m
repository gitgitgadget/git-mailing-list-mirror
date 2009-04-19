From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: [PATCH RFC3.5 05/12] send-email: Improve redability and 
	error-handling in send_message's sendmail code
Date: Sun, 19 Apr 2009 03:17:20 +0100
Message-ID: <18071eea0904181917u7c7187bubc8fab6ede2d19ef@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
	 <76718490904181851g2701ce59x614ea60452b914ce@mail.gmail.com>
	 <b4087cc50904181913g117937le333c3b255f7d184@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 04:18:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvMcR-00005u-PH
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 04:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbZDSCRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 22:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbZDSCRW
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 22:17:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:21275 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbZDSCRW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 22:17:22 -0400
Received: by fg-out-1718.google.com with SMTP id 22so92645fge.17
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 19:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l7XoOLwrmAemZ3BfQ7AuFzoVH10tvJ/qA6xs+3SKuy0=;
        b=ePbmPFrdO4xtsN2g1q2rLfZ3OCLQfR+EEIGxLeyYw6xTu0RJOEMCf70wKYNVBoTzp/
         ZH6xR05ipTK+SKknAIdmSIv3e2GmQOdRtZaK+RsuOLQipZcZqt06gRv8p7g4RzSJ1JP6
         tahV2YUrEBt5PyRr/FgTqNAYp3Ue6HIYrYP3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qsWS9o9EUydFdB5jmJYpBLIBVI2G8Md2yOfi++d8JpVKH6J5SWGH48Wt/GVxTscdDp
         bG6RmgcQgelf5CqFeqnVGcvsgE9/J+UrlvLCQujWZPFSn5qwmqvccBtRMgHr1tQ7wKLE
         +bEDtNME7RKAOQCqoHfPDn7S+QeG02pQYeR5A=
Received: by 10.86.86.10 with SMTP id j10mr3046770fgb.37.1240107440618; Sat, 
	18 Apr 2009 19:17:20 -0700 (PDT)
In-Reply-To: <b4087cc50904181913g117937le333c3b255f7d184@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116877>

2009/4/19 Michael Witten <mfwitten@gmail.com>:
> However, I wonder if your comment is a veiled quip at my "Improve
> redability" claim (which is also ironically unreadable). :-)

More concerning is that it's a perl 5.10ism -- you cannot assume that
perl 5.10 is installed on all platforms.  I really wouldn't use this
construct.

-- Thomas Adam
