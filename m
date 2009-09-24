From: Howard Miller <howard@e-learndesign.co.uk>
Subject: How does gitosis know who the key belongs to
Date: Thu, 24 Sep 2009 15:51:44 +0100
Message-ID: <26ae428a0909240751k3a799750h121935a79439b389@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 16:56:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqpjx-0008JO-JL
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 16:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbZIXOzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 10:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbZIXOzX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 10:55:23 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:38047 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbZIXOzX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 10:55:23 -0400
Received: by an-out-0708.google.com with SMTP id d40so1491952and.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=UyrvaQRZ6EhbSaMrl380Koa6WAdyqbKfMjdvgn34J/c=;
        b=iRorftDggTA8Gyz1xhKeb/hQfBp/2vy1Fx+ykdI7hZfjILv7n+nuyXV7sjzctZE/k3
         1qB5eZJq2ooz9e9AkrP9mSCiE0czhlHO8oZvFisWvEGcUVvAx4uGk/iL3TCu22GJ8rTD
         O5BNczvAenMYwNiz2n3Ung/HsofaLurWJxiQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=bLIsYj2McqNqfD9mUPkZHEqdgzW1/oKazHyCq3L0bo4+m/dwSVlhU3xqhaEVIr4I+O
         Al5J6izp6uijSDTLrOMytpXovH7St5wbV47SWMQ73p6djregxUQ2ECA0UQdam4fPWead
         JEfDKvMBgPowrawe/TWZ47GT40KpTY1pdU/Ro=
Received: by 10.101.154.5 with SMTP id g5mr4345792ano.178.1253804065115; Thu, 
	24 Sep 2009 07:54:25 -0700 (PDT)
X-Google-Sender-Auth: e8bfcb2977615d59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129045>

Hi,

This is probably another one of my stupid questions.

Gitosis obviously uses keypairs but the config file addresses the user
by name/host. How does gitosis connect the two together? Is it any
more complicated than the user detail at the end of the public key?

The second part of my question then is is it possible to use the same
private key on more than one host?

Cheers,

Howard
