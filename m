From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 22:06:19 +1000
Message-ID: <ee77f5c20805110506i58dc735fqb6f4258dbb67bf27@mail.gmail.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain>
	 <4826DF6A.2070306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Dima Kagan" <dima.kagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 14:07:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvAKg-0005ga-N1
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 14:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbYEKMGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 08:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbYEKMGV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 08:06:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:4791 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbYEKMGU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 08:06:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1435617fgg.17
        for <git@vger.kernel.org>; Sun, 11 May 2008 05:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QXYLic2kIzB15P+PViWp5G0i1mwIWrE9FYwHAoIgogI=;
        b=PKgkgn6cbVsgw/OQxrvjlQytI0cPF5Rj8yg1pNDclZAAoHqyIxqBnDa3vz9uGhnw5oeFANK12ftNOjUiU0PeQaBTpWhePlr2+aV+LOZOIBEka37CWOmJlVby7bpapl0+vWHi8MWpieeAVCy3DbWbgKhBLmpHyB6G/2WwmdzQi/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qkXR031TzAdlaTRlhkDHw1smNiZ156+3yAcUKtLjO2lmXdJcXbGGXUXyyMAkV84a4IgkTpxqb+sqCnB17qCvHBx/iW5Vil1lMNvaxRso8DVgsSc4o5ho+AKfNnddHSQCpQsb+GGwQEkdfobFI6C9LvcL5HE5xEVnOwkXcual6IA=
Received: by 10.86.26.1 with SMTP id 1mr9954435fgz.49.1210507579271;
        Sun, 11 May 2008 05:06:19 -0700 (PDT)
Received: by 10.86.96.12 with HTTP; Sun, 11 May 2008 05:06:19 -0700 (PDT)
In-Reply-To: <4826DF6A.2070306@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81761>

On Sun, May 11, 2008 at 9:58 PM, Dima Kagan <dima.kagan@gmail.com> wrote:

> That's a subjective point of view :) I'm coming from the SVN world and uncommitted changes on one branch don't affect other branches. Is there a way I can achieve this behavior with git?

If you *really* want SVN's behaviour of "branches", just copy your
whole working tree (including the .git directory) and start making
changes in that. Then they'll be completely separate and you can just
'cd' between them.


Dave.
