From: Jakub Holy <jakub.holy@iterate.no>
Subject: git-svn: Please improve confusing error message "needs update" (when
 actually commit is needed) in rebase
Date: Fri, 24 Feb 2012 10:55:22 +0100
Message-ID: <CAFXq=J4j=BGccJXL91UpnvESU2ijHP=4HQSS4J0R34zOU54gPw@mail.gmail.com>
References: <CAFXq=J7hoUtb06LBAPhrbdmtHB8FGWpmUoz2yF-UJz8G=_smPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 10:55:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0rsJ-00047s-Gc
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 10:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674Ab2BXJzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 04:55:24 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42037 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751468Ab2BXJzY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2012 04:55:24 -0500
Received: by lagu2 with SMTP id u2so2607686lag.19
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 01:55:22 -0800 (PST)
Received-SPF: pass (google.com: domain of jakub@iterate.no designates 10.112.103.168 as permitted sender) client-ip=10.112.103.168;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jakub@iterate.no designates 10.112.103.168 as permitted sender) smtp.mail=jakub@iterate.no; dkim=pass header.i=jakub@iterate.no
Received: from mr.google.com ([10.112.103.168])
        by 10.112.103.168 with SMTP id fx8mr747171lbb.14.1330077322775 (num_hops = 1);
        Fri, 24 Feb 2012 01:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iterate.no; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=g8NypwDfz+zqm7gQAB9uh+Sc80ohd1sguWRxRpcH3gI=;
        b=P9B3Lu0fffMQlrywFFAQRIbLEUo0NqvhXK/FxY9pKI23Ubu9CzwPNig3PVlJHXxTbZ
         u5E9JvEN9Dm8j2Iw33jYoUGECYVObeg2J1e+ArWV3NB+WXQ7MF1gu9D3AcpqU69TABQo
         EVprasl9QoH6evY4qrGdvBnurbjn9eDwDG8tY=
Received: by 10.112.103.168 with SMTP id fx8mr617529lbb.14.1330077322655; Fri,
 24 Feb 2012 01:55:22 -0800 (PST)
Received: by 10.152.130.9 with HTTP; Fri, 24 Feb 2012 01:55:22 -0800 (PST)
In-Reply-To: <CAFXq=J7hoUtb06LBAPhrbdmtHB8FGWpmUoz2yF-UJz8G=_smPA@mail.gmail.com>
X-Gm-Message-State: ALoCoQkx18IPX5nM/VM132YCiOMVo86wuiKAAbEh52JxGhWu+mQYDH0iPnP8NDtq9k5j/ket8ADn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191423>

Hi,

I hope this is the right way to submit this enhancement request.

When I run rebase with uncommited local changes, I get rather unclear error
message:
$ git svn rebase -v
mymodule/src/main/java/example/MyModifiedFile.java: needs update
rights-lib/src/main/java/example/AnotherModifiedFile.java: needs update
update-index --refresh: command returned error: 1

If the message was something like "You have uncommited changes in your
workspace, commit them before running rebase." (followed by a list of the
files) it would be much easier for newcomers like me to understand what has
to be done.

I tried to understand what has to be changed in the code but it exceeds my
low level of knowledge :-(

Thank you!

Best regards, Jakub Holy
--
Jakub Holy
Solutions Engineer | +47 966 23 666
Iterate AS | www.iterate.no
The Lean Software Development Consultancy




--
Jakub Holy
Solutions Engineer | +47 966 23 666
Iterate AS | www.iterate.no
The Lean Software Development Consultancy
