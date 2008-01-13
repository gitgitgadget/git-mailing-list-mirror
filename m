From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Digging through old vendor code
Date: Sat, 12 Jan 2008 23:09:27 -0500
Message-ID: <9e4733910801122009k5658488bx69c04a5cbf7d832a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 05:09:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDuAV-0000LK-Um
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 05:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbYAMEJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 23:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbYAMEJ2
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 23:09:28 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:57799 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbYAMEJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 23:09:27 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2796038wah.23
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 20:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=KGAVT9lxc1TqM4yVJo33Md3Db8QqF9QKjvKl/lQcq/U=;
        b=M1NBL2N+g8TqMKhoXzP2fS/kUhLcyvdn/EMSxwohAut8AKkMtSvcJf9K2doW9XbDlZfFASMvnQu6J9kSxqiOWcWZGTFho0Fz01mcozhPwPtWaWVTelSqJebJT9bKW/fAJ6XCMMrH9C60ZzWlSDdG85shrb7ejqzHaxeDMZZhmoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i1lNbLdau4/LKEbSO3xm7Hed3V79bI5RxBY+x1WNBNwgOVALZcPimbYZznpYQuRhvx50NrXlRSwh7sCA88lSlYrtsMpvDgb8i2oLvwYl2CisCJUzocrw1Pl57VrLCLnDktmctglmygMhxNT6Z4kyMQW62q0JIoE+W5iaO4cR7Us=
Received: by 10.114.168.1 with SMTP id q1mr181248wae.96.1200197367125;
        Sat, 12 Jan 2008 20:09:27 -0800 (PST)
Received: by 10.114.200.7 with HTTP; Sat, 12 Jan 2008 20:09:27 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70367>

I have a file that a vendor has modified. It's a serial driver so I
know which directory the original file came from. Is there a way to
ask git to search through all of the past versions of all of the files
in this directory and give me the top two or three choices as to what
file the vendor originally copied before staring to edit? This is the
same problem as picking the best diff base.

-- 
Jon Smirl
jonsmirl@gmail.com
