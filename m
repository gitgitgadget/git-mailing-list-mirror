From: n179911 <n179911@gmail.com>
Subject: How to ignore space when using 'git send-email' command
Date: Mon, 13 Jul 2009 13:53:11 -0700
Message-ID: <3b9893450907131353o77102b8cx6c8944f6cc45214a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 22:53:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQSWX-0000eN-B9
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 22:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756819AbZGMUxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 16:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756411AbZGMUxO
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 16:53:14 -0400
Received: from mail-qy0-f192.google.com ([209.85.221.192]:35097 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299AbZGMUxO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 16:53:14 -0400
Received: by qyk30 with SMTP id 30so969492qyk.33
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=LY+FfvWn8Ws4TKE91OYv9wyzVW76A62DQPZxB3QaHC4=;
        b=YIL9dDIRdBb8QNe4yhibxZqhfUv/BfbayAe/2tI2tR6DuUxe5euBUMGYTthn5K79Gv
         /kCwDNzuW6wHAfZWkpn90xdkcGl1728NxQqezJi13KA8MCrThGIG+xfo6N9PDaDpCjNB
         dt5oFs6MKs9M5n994LCP4g9t1QMduqUpcyU2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=xpifxJPid79fBNfRFLNj5p3e5T7VcfhqejWLfNFuB43TCUi8WbtgLyyhjBLjfKzpRc
         YdxZjWNFgL/5UXIi4RmZaHitGtY+oWpweSsEBFyC9pABt4H6Ap1jACbKmmA4TgZ1AsBG
         RzbgfCRt4D0bKiXCHHcDfpao+lQKdzT9ZMr3U=
Received: by 10.224.2.77 with SMTP id 13mr3317332qai.121.1247518391764; Mon, 
	13 Jul 2009 13:53:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123204>

Hi,

I am using git version 1.6.1.

When i use 'git send-email' command how can I specify it to 'ignore-all-space'?
I see there is an 'ignore-all-space' option in 'git diff' and 'git
format-patch', but there is not such option for git send-email.

I have already commit my changes to my local branch, so I can't use
'git diff' , 'git format-patch' to display the different which ignore
white spaces.

Can you please tell me how can I send-email which ignore white-spaces?

Thank you.
