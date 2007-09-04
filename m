From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 12:28:00 -0400
Message-ID: <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:28:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISbG3-0002AI-Kq
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbXIDQ2D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbXIDQ2C
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:28:02 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:6595 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbXIDQ2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:28:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1211722rvb
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 09:28:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JiRE0UdJa/ULp5/L/AVhsCVHsIOUV4jklZXuUD8kFow657QMIG1S5aZyaeft0XRNRuak2Tqkg3lk83XAgeZM5fSMtiNwfGaU/TTkJWnUlYPEQWrrHMGo0dehsbWL9uHvBCFb2T00VK4pzJ7KBhN4l219P0gTlh+T5jDhFiHnaV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XLvM/8vezOCDFZMcCBMFpENlKPulyYG8dHurl1RG/ehrEEbbBwPxa8BLPDMiDBvJ6qwammf3d7olL0nE5GGJcIMr0MVKFE2pCceGAJga1J+uSBlmkbK5KD6di/4QYmV1HOo4mQO4I6q7OV+lZrVZAjq4BlyGHUHyzyehtPJkUuE=
Received: by 10.140.136.6 with SMTP id j6mr1472473rvd.1188923280201;
        Tue, 04 Sep 2007 09:28:00 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Tue, 4 Sep 2007 09:28:00 -0700 (PDT)
In-Reply-To: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57610>

Another way of looking at the problem,

Let's build a full-text index for git. You put a string into the index
and it returns the SHAs of all the file nodes that contain the string.
How do I recover the path names of these SHAs?

-- 
Jon Smirl
jonsmirl@gmail.com
