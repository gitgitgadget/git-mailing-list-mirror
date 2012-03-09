From: Corey Thompson <cmtptr@gmail.com>
Subject: How does --assume-unchanged impact git-p4?
Date: Fri, 9 Mar 2012 10:58:48 -0500
Message-ID: <20120309155848.GA5998@jerec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 16:59:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S62De-0001Fg-MF
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 16:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287Ab2CIP66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 10:58:58 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51501 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab2CIP65 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 10:58:57 -0500
Received: by ghrr11 with SMTP id r11so919797ghr.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 07:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=1yZQ6nmopWn4Y/giyqtMkFTkRkhf/epx1TElslWum98=;
        b=k2+8A+1MvpNCIxMP6T1PyzBWFTr0kLLf+88R61d1S8pIW3qhwP0zef2ss19gH43YJD
         ycZX41h1SGPaXdu+/s9TkvF5bKsW8Wby5LDh9mF2rfxNKy6vsxoxjnCD25uJPbD5Rw9L
         ZHFE32kx3NNiv6PlFoh3K7nrWOvch7Wnjl6GfNRQ8Y1cnadCHdqILivVf2/QB+y/9Z57
         9F27vyidbceVUOj9vuGEclVn+UlSwyMx4W/p2UPOrnQlit8919HztHG9PRqkIFGtjhpb
         tp2xPepaRPO2MOKqWyzU8XaGCAiaracZqp+IjiuboXSr/s9lAh7Dr45v9plk/QQ1I+rV
         X/oQ==
Received: by 10.236.120.179 with SMTP id p39mr2999877yhh.22.1331308736737;
        Fri, 09 Mar 2012 07:58:56 -0800 (PST)
Received: from jerec (c-71-59-19-88.hsd1.ga.comcast.net. [71.59.19.88])
        by mx.google.com with ESMTPS id w44sm14800182yhk.17.2012.03.09.07.58.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 07:58:55 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192723>

Hello,

My workplace uses Perforce, so I've started using git-p4 to interface
with it.  Some of the files included in our depot are cached
pre-compiled binaries which do a great deal of damage to git's
performance, so after some research I found that I can "git update-index
--assume-unchanged" on these files.  This is great except that now I'm
worried that this might prevent git-p4 from doing its thing when someone
else updates these files.

So am I going to miss updates to our cached binaries using this method?
Is there a better method I should be using in this scenario?

Thanks,
Corey
