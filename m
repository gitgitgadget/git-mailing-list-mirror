From: Pascal Obry <pascal.obry@gmail.com>
Subject: smtp server on windows
Date: Sat, 04 Sep 2010 16:03:12 +0200
Organization: Home - http://www.obry.net
Message-ID: <4C8251A0.1020809@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 04 16:03:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrtKh-0007pp-34
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 16:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab0IDOCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 10:02:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54654 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab0IDOCz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 10:02:55 -0400
Received: by wwj40 with SMTP id 40so4120529wwj.1
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :organization:user-agent:mime-version:to:subject:x-enigmail-version
         :content-type:content-transfer-encoding;
        bh=PavrYv70P8OFX8yBYTrguBVr07O/ZUKQeFNYmhK24s8=;
        b=uzwYbU0KvtzS6baA0QjN4oM70UxnVKQPSXLPrP4mrfSenWFXnl/yJTfm+qx4/FSOaB
         GbrjMs+THjn/wHbf4ArXJCgQZxJ2bF2oxvgHa3gNz7dKC87/yKdJ8uHM/rBD3rJQynLy
         EyKxx2zdfG7ntxsvAl2MZyBPtklqfMUl+xYh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=NX13FSBW47YeW9VddKnn9vi9ehlbfyzjQ0vWxoX8zoDdK2dqizdrMN/aThlOSw0rJv
         xJrtohqOBvxONA3uiYo0wOWsy2bMry5KXx/OvSZ3WD+DKU9mYAUKJw9K5DyKjycEdQW6
         zE7XIuA3oIFhdAp7G3FJZYt7TAUxp8dbN7stE=
Received: by 10.216.182.202 with SMTP id o52mr1878504wem.29.1283608973304;
        Sat, 04 Sep 2010 07:02:53 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
        by mx.google.com with ESMTPS id k83sm2006425weq.14.2010.09.04.07.02.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 07:02:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155326>


Hi there,

One simple SMTP server on Windows (using Cygwin) is msmtp.

I'd like to use two different SMTP accounts depending on the repository
I'm working (this is to get the proper identify on the from header).

I have two accounts configured and working in my ~/.msmtprc named gmail
and wanadoo.

I have on my .git/config to send e-mail (and this is working):

[sendemail]
        smtpserver = /usr/sbin/msmtp

This is using the default account as specified in my .msmtprc. I want to
use a specific account (say gmail) for this repository, I tried:

[sendemail]
        smtpserver = /usr/sbin/msmtp --account=gmail

but this fails as smtpserver is expecting a simple executable. Is there
a way to pass some parameters to an smtpserver specified on a Git
configuration?

Thanks.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
