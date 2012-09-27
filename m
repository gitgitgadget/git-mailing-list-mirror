From: Laszlo Papp <lpapp@kde.org>
Subject: Option for git bisect run to automatically clean up
Date: Thu, 27 Sep 2012 17:55:30 +0100
Message-ID: <CAOMwXhOv7oGXhtWu0apmDD7x+Vnh0jkc2QrnSPmc-=KCQQ08Yg@mail.gmail.com>
References: <CAOMwXhN=SpwGPaSr1p8K_y4yinuWA0hhynwpqi=5+xT-ZMVbYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 18:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THHNE-0001xI-AU
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 18:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777Ab2I0Qzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 12:55:31 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33614 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab2I0Qza (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 12:55:30 -0400
Received: by ieak13 with SMTP id k13so4998187iea.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 09:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=wyIF/Jrp4HBbJeA70lw5QyEnymdHOC/kzjimt9i+nDo=;
        b=K/0pSj9wqFtCbyo8ic/SAxGsBTupoiGGIoZ/0gdGi1YaW3D7JwZ8/JtACSJZzyW4Nx
         h32FL3mJ7eFuxIWxQwkJ5r+aZz349ISziSCShtrJz5gZZOjn2cU+9u0Ugw+XH0t9W7Md
         ggphOhOKndZArIcgKKICmatpfDgiMpnYYtNy+nj+6GbYcsH708OdxB3PtgnW3aIjSHRX
         lVR75YprMgg0Xx7VlihAwIqDc3BwKB7KnO2eCphW0d7E1smB7t36OKWVUUeYuRRjoFhV
         hlWcKK1+DYO575rFcAjPJsY2y1BQz6cTNxBY1UsTeX1LFVtiFq0s7J4iEdcFhbO6VUa3
         +4vg==
Received: by 10.43.45.200 with SMTP id ul8mr3477708icb.36.1348764930402; Thu,
 27 Sep 2012 09:55:30 -0700 (PDT)
Received: by 10.64.129.70 with HTTP; Thu, 27 Sep 2012 09:55:30 -0700 (PDT)
In-Reply-To: <CAOMwXhN=SpwGPaSr1p8K_y4yinuWA0hhynwpqi=5+xT-ZMVbYQ@mail.gmail.com>
X-Google-Sender-Auth: prSEFTTFTDmUYlDfFFYdR-sXz98
X-Gm-Message-State: ALoCoQllsV7A0w5xPtJec9MgOBPNni//znSQRhIwdUtACsycU7cE8X3vTuOjHVtUluBITvlbq+74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206487>

Hi everybody,

I have just run into a problem when I had to issue an explicit cleanup for
tracked files after a configure run in the Qt5 project. I have tried to
suggest to the people to bring up this idea on the mailing list in order to
get this further on. Unfortunately I did not have time to do so, especially
for the follow-up. I have also been told it is not a good way of asking on
IRC which surprised me a bit, but I am now bringing this up, and I try to
also make the follow-up. Hope it is ok.

Unfortunately my time is limited so I cannot contribute with that patch
myself, but I think it would be a cool convenience feature. Help is
appreciated. Thank you in advance!

Laszlo
