From: PJ Hyett <pjhyett@gmail.com>
Subject: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 15:04:34 -0800
Message-ID: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 00:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRx0K-0004hw-2I
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 00:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbZA0XEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 18:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbZA0XEg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 18:04:36 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:60254 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbZA0XEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 18:04:35 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6636696rvb.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 15:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=cAluiicxdqfVA511wiG49FS2xQsoZDA9YCwjl3jd3Xw=;
        b=Os//ypTGWPYgW/eu61JevyUlU5YE53n/6stwdEyNakkbt8y4jQC4dEwOPZQ8lSPxbR
         IdKnEli3AcOZc9DTXuqRRmsBUb6aQa/OvAtsbJaQYLlAsGyOThUmTdO3cncFFtry89Cb
         n5jbO5zjTpUYqp/ajf6oIZaNyJQxqEo5oBxqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=nzLIYW7nKmZCY3xG3o8zbHSr7kyU9rxxu2KAbk1MueR++eN7b20kS4wv5na+dT+04P
         dqPgGpHKvw5WcUU+kryEpIF7+O6v6SidUEPO6SvydYcZo5YbiF3aMUsIhnlAdZdQSR0t
         4FhUGZE0bUpxmnTm/Br9knHpNHbENBzkdZNDQ=
Received: by 10.141.86.14 with SMTP id o14mr1974142rvl.233.1233097474329; Tue, 
	27 Jan 2009 15:04:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107417>

Hi folks,

We upgraded our servers to Git 1.6.1 yesterday and almost immediately
starting hearing reports of "Fatal: Bad Object Error." I have
experienced this myself, so I'm 99% certain this isn't user error. I'm
also using 1.6.1 locally.

I ran into this error after trying to push code to GitHub after a
series of simple commits, I was doing absolutely nothing out of the
ordinary.

Please see our support thread for more examples:
http://support.github.com/discussions/feature-requests/157-fatal-bad-object-error-when-doing-simple-push

All of the error messages are the same. Can anyone please shed some
light on this, I don't see any other recourse but to downgrade Git
until this is resolved.

Thanks,
PJ
