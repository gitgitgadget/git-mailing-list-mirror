From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit: per branch cover letters
Date: Fri, 25 Jan 2008 09:57:50 -0500
Message-ID: <9e4733910801250657p2d7fdc66o8a631d7587125949@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 15:58:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIQ0a-0002rR-Mn
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 15:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbYAYO5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 09:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbYAYO5w
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 09:57:52 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:16718 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbYAYO5v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 09:57:51 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1114625wah.23
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 06:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=1QFSWkl6FRLOiVajalQpWMdIVTWqWXhmE15Ymq3U2RA=;
        b=O2Az5VcjT9sDyzESS7JQpyYZrzY37FziigevK6ERvNq+ml13Qe9KF8PIGZ0qlQVt2+99MUutacHH4YrApnYsNaUoGu/FCWk1FXJEohhKHXXV3Gdwh+NiOzQnp4WhUMjICiaqflvlWTXsJuFlJD3/dpbswFN7Qb+9kWrpo6njkc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AzoEuDoWaKoGUB6kGKigL09Lgkz1+dh+z5vdJTluMzn3HoS8MDyvJF8nuE3VhOjQ+lH7InkX6NZ6JiEyRVxo22vFp8JDxQiFaG9CGG8OqIGC6wH/mPtqwEd3UjUeReBGspfLkOg2x6u+IqeqK2YRLxsitO9WMl2lQR0HT5MC6I4=
Received: by 10.114.77.1 with SMTP id z1mr142445waa.56.1201273070987;
        Fri, 25 Jan 2008 06:57:50 -0800 (PST)
Received: by 10.114.93.14 with HTTP; Fri, 25 Jan 2008 06:57:50 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71711>

It would be convenient to have per branch cover letters that are
stored by stg and get automatically applied when a patch set is
mailed. Use 'stg edit'  to alter them. The first time you email a
series you would get an editor to write the cover letter if you hadn't
already done it. You could track the "to=" this way also.

Another useful feature would be a config option that says something
like "prompt for new version" when mailed.  Now each time you mail the
series it throws you into the cover page editor with an incremented
patch version. You can just quit out of the editor if you don't want
to increment the version.

I didn't know I wanted features like this until I made a patch that
has gone through 25 versions.

-- 
Jon Smirl
jonsmirl@gmail.com
