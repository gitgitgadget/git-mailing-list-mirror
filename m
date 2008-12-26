From: demerphq <demerphq@gmail.com>
Subject: Why does git-describe warn about something that you can't control?
Date: Fri, 26 Dec 2008 12:50:41 +0100
Message-ID: <9b18b3110812260350q6870700du982ec3a7a91950e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 12:52:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGBEi-0002Y7-Q8
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 12:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbYLZLuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 06:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753797AbYLZLuo
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 06:50:44 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:53654 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbYLZLun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 06:50:43 -0500
Received: by qw-out-2122.google.com with SMTP id 3so2743901qwe.37
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 03:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=zKCkqUWuZLypoZ/lyjCSQqHvI2raHCFaZN4Ge2GNAPk=;
        b=euFj8/P+ZeLoAZdxk9okq+LICD54XUbo5vhM48JlQTtc+h1r2f2epamt/a+YrFGaSz
         tGvhhOtQQLQAr5B8RwlH6ZgxwrBLAeoXsxtMg0KvLNP9Yf1hjNeYcc4Kw+ZMIIgxAP7j
         92H2DqFw6GLt1XHi5PM3vadMYj1p9GMK2iiYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=cjg+ZBsU7k8EERAjpBBnV8rao+ZtyZtAbTlHits8nJPX7h92lDv4Mecr6fbNjTCAwC
         n+3lh9tmtMR/2/B98dpg8a1L3+NOI9xVvL48MQDR8CNwzWfmn19fdCE/tyqPga/axkfI
         xpx2zvk5dTyBJGbht51sj7AJYtuw9hm2tBMm4=
Received: by 10.214.149.15 with SMTP id w15mr9645192qad.94.1230292241051;
        Fri, 26 Dec 2008 03:50:41 -0800 (PST)
Received: by 10.214.217.13 with HTTP; Fri, 26 Dec 2008 03:50:41 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103935>

On the perl.git repo if I use git-describe --all on some commits I get
warnings like this:

$ git describe --all 3417e4f8422bcf13f799ce1acef44b27ccbef3d8
warning: tag 'perl-5.005_04' is really 'tags/perl-5.005_04' here
perl-5.005_04

Except there doesnt seem to be any explanation for why the warning is
being produced (it almost, but not quite looks random for the commits
im looking at), how to silence it, or how to force git-describe to for
instance use "tags/perl-5.8.0" instead so the warning is not
generated.

I think this behaviour is confusing, either the warning should go
away, or it should be improved and complemented by a switch to force
git-describe to use the qualified tagname instead, or at the very
least a switch to silence the warning (which is really annoying when
you are doing git-describe on hundreds of commits in a go).

Details for the perl repo are in my signature.

Yves
-- 
git clone git://perl5.git.perl.org/perl
