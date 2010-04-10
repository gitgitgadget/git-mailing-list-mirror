From: Khaled al Habache <khellls@gmail.com>
Subject: Strange case with stash
Date: Sat, 10 Apr 2010 21:04:53 +0300
Message-ID: <v2w918f64e01004101104xd4f1b4eciec01d2e87691ee72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 20:05:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0f3b-0000g5-K1
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038Ab0DJSFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:05:15 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:43179 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab0DJSFO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:05:14 -0400
Received: by wwi17 with SMTP id 17so1443834wwi.19
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 11:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=a4EDIfxXOFqtTTJtSiyVkPHoMeqWEzZLCsHOqL310bA=;
        b=Pqs8rCLSnz2jImnkBhhxHyfZQGv1vPxC+7b74waHjxrDp6SKS3vePiW1Q2ptD9iHzr
         qa78MmThY44yydDVAOunFR0mmRVI68j/dslctcGIswNuLgxkK75AB/s0yWQTxJumeSw1
         gUsAzqQfwszXz4qxbbTEE161nMj2O+5XGCX2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=tbjnoDtYP1eY6UZiKWxYnxjoj9egW5uME4+tlgdiRzvbnraMQgyFXVB4J/4c4cOuvJ
         kTnSgi3meOdHMdf5DFxv7dnYrYcOpk9kml2lFELndHbH3n9gNEyvzaoD41UxQcQkqwN/
         XfR8d0gcS6ZVyx/2n+c0txLPk6oMIiQ/Fpkz0=
Received: by 10.216.182.207 with HTTP; Sat, 10 Apr 2010 11:04:53 -0700 (PDT)
Received: by 10.216.85.133 with SMTP id u5mr1006511wee.91.1270922713115; Sat, 
	10 Apr 2010 11:05:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144560>

Hey,

I have faced this scenario, which is best described
http://stackoverflow.com/questions/2613956/strange-git-case, I hope
you guys investigate it cause it wasted 5 hours of my time, and I
don't wish that happens again to anyone using Git.

-------------------------------
Khaled alHabache
Software Engineer

Blog:
http://www.khelll.com

Rails Magazine:
http://www.railsmagazine.com/team

Twitter:
http://twitter.com/khelll

Mobile:
+963933727070
+962785257212
