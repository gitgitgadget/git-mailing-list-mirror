From: aaron smith <beingthexemplarylists@gmail.com>
Subject: suppress fatal pathspec errors from "git add"?
Date: Thu, 31 Dec 2009 13:24:59 -0800
Message-ID: <d7ac1a680912311324i85b7a5anadaf2ac13f215873@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 22:25:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQSW5-0005ZJ-Hk
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 22:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbZLaVZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 16:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbZLaVZA
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 16:25:00 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:35157 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbZLaVY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 16:24:59 -0500
Received: by pwj9 with SMTP id 9so8104986pwj.21
        for <git@vger.kernel.org>; Thu, 31 Dec 2009 13:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=qSfL9AmbswQqcrIGXQvjVAqMFyO5iCbN/y144NislL8=;
        b=h1RkJDokLemDuKroyOByk3t4abQJ0Ezmq1zI8bHVzqLYHOWrL188Ps94uVLXofCA/5
         QGqFe9OrfuWOSWymBlZ2beBjbyfryMk5RU0YEuyIX2Zt2lV9qLvK36aUQxOF3S4HBzIW
         qr3vtYQO+xiNqxtALTyIB0mGeRO//XbOjngcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=lQrV6kZmRR5A2CiX5BpVdKaG/3WUsVWc6JXSMgGu0CARoxF/KRlgO4Lr3YoMtiW2/8
         mo8+f+zRRRXL7Lbd7GrioQgTjlFf8XTm2RdZctlS3k/Rabh2ZnXRGzWO9cWXBR/hGB0l
         qm2lifVfcENIS7SdJQCr2WvKR9daLghANN5tY=
Received: by 10.142.7.40 with SMTP id 40mr13324787wfg.120.1262294699304; Thu, 
	31 Dec 2009 13:24:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135976>

I'm looking through the add documentation, I don't see a way to
suppress fatal pathspec errors? For example, if I'm adding 5 files,
but one of them is mis-spelled, can I have git just supress the errors
and add the other four?
thanks much!
