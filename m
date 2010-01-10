From: Dave Dulson <dave@dulson.com>
Subject: [PATCH] 0/2 Add tag message to gitk
Date: Sun, 10 Jan 2010 22:45:12 +0000
Message-ID: <2ee0b0aa1001101445xf2d19fatd79587b6d7e393f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 23:46:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU6Xu-0007VH-Ru
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 23:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab0AJWpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 17:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754574Ab0AJWpQ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 17:45:16 -0500
Received: from mail-ew0-f214.google.com ([209.85.219.214]:48224 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab0AJWpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 17:45:14 -0500
Received: by ewy6 with SMTP id 6so21251053ewy.29
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 14:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=p02KdfOn+rKBTOfjglITT37OramxlZHFaA5adpmWG8E=;
        b=lBAE5wjG12A701S8n1o8vGTBAtqWeimE0bY65As1qGHcdgBoorRu/8OlzrR8BvORdI
         5UA53F4X6jGH6Bz6ztcI1LBCS9LxZTY/pt7FIXspF+mB42v5brikUO1rcNKByxeLokUy
         4aGjXgL0NRTOs6gIAhLhLAcz7dJOhZ1soscfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        b=uiM4lxTjs6qvXqQcVBeWFuBrc/zO5g0WKnum8e4lGjpQgojOUX77mgwOWkXEvYx9k1
         DlVL2lrASN2rZRWt2rhzWHiJQ2T7Dg7opcbJGddfId5rq7tzSvcryXIw0JffZOlWTx3t
         yzCrGJpgLdfXb6nX+ZwD/w3f5/cCBb0Jb7pTU=
Received: by 10.216.90.65 with SMTP id d43mr1367107wef.41.1263163512756; Sun, 
	10 Jan 2010 14:45:12 -0800 (PST)
X-Google-Sender-Auth: 57a87881346d14a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136590>

It would be nice to be able to create a full tag from gitk, so these
patches add that ability. I'm not sure about 2/2, but can't see what
using $tagobjid adds - hopefully Paul or similar will be able to weigh
in.

Cheers,

Dave
