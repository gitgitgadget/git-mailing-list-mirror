From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: send-pack related
Date: Wed, 29 Sep 2010 12:31:47 +0530
Message-ID: <AANLkTimERk2EULRk9XFnNjN7ugbN7ywg23H2a5R9YB2=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 09:01:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0qfq-00049b-84
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 09:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab0I2HBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 03:01:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55835 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab0I2HBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 03:01:49 -0400
Received: by wwd20 with SMTP id 20so459652wwd.1
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=prEVlEz4uApSHV2Gq68fp0AMpRlL51A0evxQkLSROcM=;
        b=NpreGirUI5LaxIyjiYev2TiWJ/6D4FsMxcJed7ei3o652R9O89iNGNIKlIv83hQKDe
         /y5AUq7aNBEQx8+oHtjKNbC1z6I7sr4vMXsL1ojudvzpwnWG8u+fnDkCAjy2UgV2Xk/M
         aM8rLm61bamknN5DzQ0CTAJHmGQHAfbQ5vXts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=QCypLA5ofMTNfa/ocM80M8pPbMruVZiNP/EMfIpjLKeeuRBY3M+GRyF/0n11X58HUY
         52riPcjde934lLRh94z2hlsajL41kfF8I8322E8OZ8vgaic9g/j2E1TXrnX4UsTk5JHk
         pnCY4zLXSPo+2BJHw3BweZcARk60W6otAqQp8=
Received: by 10.216.138.65 with SMTP id z43mr1029481wei.12.1285743707831; Wed,
 29 Sep 2010 00:01:47 -0700 (PDT)
Received: by 10.216.134.83 with HTTP; Wed, 29 Sep 2010 00:01:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157536>

I have a repo A ; AM is mirror of A.
I clone based on Mirror AM. However I would like Git to transparently
update A instead of AM
Solution I am using is pushurl. However I need to configure each client for it.

Is there a way I can configure AM in such way that I ship changes A.

I have tried following in pre-receive; didn't work as intended

git send-pack --all localhost:/home/mvaidya/playground/m2

Thank You
-Mahesh
