From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Merge (or maybe rebase) question
Date: Mon, 12 Oct 2009 12:55:37 +0100
Message-ID: <26ae428a0910120455k7ab5aa5ag8d701050e7acec5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 14:04:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxJaC-0000hw-Ef
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 14:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452AbZJLL4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 07:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755327AbZJLL4s
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 07:56:48 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:3277 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264AbZJLL4p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 07:56:45 -0400
Received: by ey-out-2122.google.com with SMTP id 4so1903344eyf.19
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 04:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=XYo01A73W7JtBy5Tx5Q7Z24ww8vwypC/lbaG4dwPxjk=;
        b=tMrauAJ1/KUlvGHQzO13d/AX6MmD+48pi+UPNZCd1nR7rUI8/96Iglxfmu8aRBtu35
         6Yf3lopeWKCzHZQieDq9FUrjWFfEvizMeEdavxvfktyKkgsFbnIy1wI2pUICbu/YhLFK
         OMW01FZOwCnKu5Bh6Bxc4Burz3yo2vy2C1ifo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=HatHbOpnZ52cXc/mMO7i5QF1o6e9LtsJ0IEcs3AxSQOizY7WS0zv3GRnvDQRJYAvqF
         XQ2SPrAB/Jm3IXovWmZKoSV43CNc4eCxdqtsjWsyaWy434lpc39hZGWY1w0MVXn0gCBF
         /D/K1cksBiR+22Dj3TCcH9CufMdEV/GyShtyM=
Received: by 10.216.87.68 with SMTP id x46mr1835999wee.2.1255348537617; Mon, 
	12 Oct 2009 04:55:37 -0700 (PDT)
X-Google-Sender-Auth: d72bb59044044af7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130004>

Another how best to do this.

- I have my project all nicely in git with all the different releases
and versions in there going back years. Happy :-)

- I have a customer who has heaviliy modified an oldish version of the
software.

- I have identified the version that they modified and created a
branch in my git repo based on that version (i.e. what they would have
started with before modifying it)

- Their changes where applied to a simple download - no version
control, no nothing.

I now need to update them to the latest version of the software - can
git help me here or is it all a disaster?

As usual, any advice much appreciated.

PS. To make matters worse - their original is full of expanced CVS
$Id:$ tags so it will look to git like every single file has changed.
Damn you cvs!!!
