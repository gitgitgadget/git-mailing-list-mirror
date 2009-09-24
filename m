From: Howard Miller <howard@e-learndesign.co.uk>
Subject: How does gitosis know who the key belongs to
Date: Thu, 24 Sep 2009 15:49:04 +0100
Message-ID: <26ae428a0909240749s7bafcc70m9bce93b28eebe36d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 16:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqpjv-0008JO-VJ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 16:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbZIXOvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 10:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbZIXOvl
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 10:51:41 -0400
Received: from mail-ew0-f227.google.com ([209.85.219.227]:57001 "EHLO
	mail-ew0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbZIXOvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 10:51:40 -0400
Received: by ewy27 with SMTP id 27so1838065ewy.40
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=UyrvaQRZ6EhbSaMrl380Koa6WAdyqbKfMjdvgn34J/c=;
        b=cF+EMaOYYWiMTNgt6Fp1yuCL6Crm933GYwa52wXkz54EkFz1xgQKR++CzTAO3sDlbm
         IdreCkEn7Mw1M02Fi7DXolLIKP5xfi6Fo5OgP0cE48d/dKMNhTJN3Ey3LYX3LsLrTga5
         O8A4xofB48BN/ghTHf1fTpkB0h4DM9N2/utvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=wQpBw4/1l6hjGmtGEIwIdYjHDaelmciEHNMSVUqC+MDb13ZRQ3/OODKwnBZFayxGfU
         6El5hveiOEzosNGAp4JEBQlSJmLYXIxb4EKEoKYuEYZboOELA4wcCOz9PyrcQxXQvCD4
         50SSA4Z0PY8w8NkOlCUmMDzEIeX9CNzSbHknY=
Received: by 10.216.70.19 with SMTP id o19mr782436wed.125.1253803903518; Thu, 
	24 Sep 2009 07:51:43 -0700 (PDT)
X-Google-Sender-Auth: 5d20561d3d8dfaf1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129044>

Hi,

This is probably another one of my stupid questions.

Gitosis obviously uses keypairs but the config file addresses the user
by name/host. How does gitosis connect the two together? Is it any
more complicated than the user detail at the end of the public key?

The second part of my question then is is it possible to use the same
private key on more than one host?

Cheers,

Howard
