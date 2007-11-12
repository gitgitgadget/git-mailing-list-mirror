From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 08:57:46 -0500
Message-ID: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 14:58:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrZnn-0006y5-MA
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 14:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758666AbXKLN5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 08:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758632AbXKLN5r
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 08:57:47 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:52233 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758496AbXKLN5q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 08:57:46 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1174410rvb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 05:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=7Tr3bZf0QcIPhtPj8eqRiSY8EOtXoqD8xP6tMdcEZ7M=;
        b=thFop5+EVeE7iH9Mn2n+l/wyEVQX6pm9mdk/8fhJymmcVgPJa+xpo+LkajW+2xC6ndcyUCsNuRxq/RbargB6XO6twI9gsz94vAoeuQ8E+ZyR2JLolEAAd3/sqwAWbEo1pEsb4dvDChL+8OxJyOtN6ZF2oZhVIhsU1nnSaahrw5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c1/q2+To2f38mOBq7ANFlU6W1tftzIgouB+2fgIbnmOPNq8qEmmx1ZaTORPcrwqbWtzdEvpydlla6I0ziQAbLmHGWTcamzI5EAHPpg7QM9QMhbeoFhaMg+Af+8oP+s+nWMeIHxN2zaPiJ2Q7SssW7mx0y4yZ1ZMA3wUrNkwDUhw=
Received: by 10.115.60.1 with SMTP id n1mr2309827wak.1194875866315;
        Mon, 12 Nov 2007 05:57:46 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Mon, 12 Nov 2007 05:57:46 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64622>

I'd like to do this sequence, but I can't figure out how without
editing the config file. There doesn't seem to be a simple command to
move the origin.

git clone linus
move origin to digispeaker.git
git pull

What's the simplest way to do this?

-- 
Jon Smirl
jonsmirl@gmail.com
