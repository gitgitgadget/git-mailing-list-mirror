From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Lightweight tag ?
Date: Sun, 11 Jan 2009 19:44:30 +0100
Message-ID: <38b2ab8a0901111044x5db21d74i25ff7a26bb702a5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 19:46:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM5Jw-0000GB-07
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 19:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbZAKSof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 13:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbZAKSoe
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 13:44:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:46440 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbZAKSod (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 13:44:33 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3780912fgg.17
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 10:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=P4l+hxaWQvM9cJwKA5n6xEs2n2umOWtLqgYkpuUNQfI=;
        b=AOzk0gfRX99imaxsHyvRYay1RNHdt2TTfdRS/SxI50kzvLf+VsoKx1gf9AAIOaq5IK
         r3QDPRTik40dPDrJWWLKndi0fNH8Mvzzwm1pn70YDzxsJM+VxDwSOQNVUd5N0QgRtc8l
         CEgCg7DBvf0tS0flb1/g0uomVsZu7HFLpCjSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Zb7h37S6vz7vXNtTnbaCbWUPDbNfJNtiSqOKsmR+JDy93/BCgOQNeW3FvLldhG8Kno
         8rHlkXxOmwvV+OHov0HOOkUkRa94COM6skNsvXRrGqKAvql+W7mfe0PRYADjMjtj3pQY
         oOQxlsJV0Pn6NLVrTrlklkjx/ZpnpLfLQdIkM=
Received: by 10.86.59.18 with SMTP id h18mr14748851fga.45.1231699470898;
        Sun, 11 Jan 2009 10:44:30 -0800 (PST)
Received: by 10.86.29.14 with HTTP; Sun, 11 Jan 2009 10:44:30 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105197>

Hello,

I'm puzzling about the lightweight.

My problem is that I don't see their point !

They behave the same way like the annotated tags: when pushing to a
repo the lightweight tags are pushed as well, and pulling from a repo
with lightweight tags give the same results (all of this with the
--tags switch).

I would have thought that these kind of tags are local to a
repository but it doesn't look so.

So could anybody give me a useful use case for lightweight tags ?

And how can I create local tags ?

Thanks
-- 
Francis
