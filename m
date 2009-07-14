From: E R <pc88mxer@gmail.com>
Subject: odd behavior with export LESS=i
Date: Tue, 14 Jul 2009 12:18:52 -0500
Message-ID: <3a69fa7c0907141018l4f6fb773o219b6a18effc393d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 19:26:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQlli-0000so-6g
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 19:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847AbZGNR0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 13:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755828AbZGNR0A
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 13:26:00 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:58469 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbZGNRZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 13:25:59 -0400
Received: by yxe14 with SMTP id 14so4419089yxe.33
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 10:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=GQZNLUQ6DZwfGFKcHN6Bbuii2IvGKmsYX/1E+VgXITc=;
        b=L2P9a12iWCIBsTgLvG17u1y225ER0IbMEwNuQUUdgoOBr91pmNPCZkdsIj7L7elx72
         K32y3RqZQWedGPnI8ID6YjY7Ab2l6S2HlJoy6jCZlOl8bual8+TYnx8/2gp/6IDfxTkb
         Y1YmKsbaii/w3uJUFjQaf7zDnCA3qyh8sruBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=USvK19gcUkf1qudXCLt6HlqkoV8wb4OR6FV8Mr+fd85E3o126VQZa7SSdGzM7vGeUH
         GM4zBCARHrqLoU7bdmQieW19znTKfwnotVqi2cGw1QEkavidlS+js82eAOvQaNrREQHQ
         vWo5Xpa3q2MjU73zW5k+p+MhHf4zifhm63mtc=
Received: by 10.151.110.8 with SMTP id n8mr10604304ybm.334.1247591932576; Tue, 
	14 Jul 2009 10:18:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123257>

Is this a problem with less or with git?

>From the shell if I run:

export LESS
LESS=i git log

then I see things like ESC[33m instead of colored text.

If I run:

unset LESS
git log

then I get colored text.

Note that the environment variable LESS is used to pass default
command line switches to less.
