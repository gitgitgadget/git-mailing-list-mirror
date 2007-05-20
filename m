From: "Dave Hanson" <drh@drhanson.net>
Subject: Re: [ANNOUNCE] GIT 1.5.2
Date: Sun, 20 May 2007 06:46:19 -0700
Message-ID: <9fb1551c0705200646m62b61efegbae76e6f17b06799@mail.gmail.com>
References: <7vsl9rq2u2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 15:46:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hplju-0000fl-2S
	for gcvg-git@gmane.org; Sun, 20 May 2007 15:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758889AbXETNqW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 09:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755994AbXETNqW
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 09:46:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:31004 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758842AbXETNqV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 09:46:21 -0400
Received: by ug-out-1314.google.com with SMTP id 44so924250uga
        for <git@vger.kernel.org>; Sun, 20 May 2007 06:46:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FuDOSXnAm2uu+/vIDWzoPz6VT2Z2k02Nno+xsOQjYCUfwT5uNlaw8Y3MnLgYDSE5K+gYVYmy1atfhYI2FoFCWdWHcsWUNGXk9zbSG2YytgmT0PhxFxBTfewBgD34HJvsn9KPu5J5iRSXcAl0HALvZn09uvhdKlKZKlgV1uk70NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=SnKRocfW3vFWGhF56lDgtqOhYI9v3OG3CjvoInnSklhvUavjhBSXFQy+5sf9hSJ/D2XnNXf7pdi0nOMokTjjuKeSwd96E5UljMzCVoP+SL90vmJ7dB2JeMAWgCB4UxvFZGr6Jhq2IgDniRajJHyLnggvoBLsmxI18EfTWWPtdPk=
Received: by 10.82.180.17 with SMTP id c17mr6660531buf.1179668779795;
        Sun, 20 May 2007 06:46:19 -0700 (PDT)
Received: by 10.82.107.19 with HTTP; Sun, 20 May 2007 06:46:19 -0700 (PDT)
In-Reply-To: <7vsl9rq2u2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: ab9e5b26db8d7196
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47836>

When I try building git 1.5.2 on Mac OS X 10.4.9, using "make
prefix=/usr/local", it fails with:

$ git checkout v1.5.2
$ make prefix=/usr/local
...
    LINK git-http-fetch
/usr/bin/ld: can't locate file for: -lexpat
collect2: ld returned 1 exit status
make: *** [git-http-fetch] Error 1

But the build succeeds when I use:

$ make configure; ./configure --prefix=/usr/local; make

thanks,
dave h
