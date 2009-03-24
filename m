From: Fyn Fynn <fynfynn@gmail.com>
Subject: Default color for commit hash in git-log is unreadable on bright 
	background, and can't be changed.
Date: Tue, 24 Mar 2009 14:16:06 -0700
Message-ID: <1a04eebf0903241416g67e7abfdh6b3aa746f12b0e83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 22:20:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmE2x-0006IO-PK
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 22:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbZCXVQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 17:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754360AbZCXVQL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 17:16:11 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:39165 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbZCXVQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 17:16:09 -0400
Received: by bwz17 with SMTP id 17so2415435bwz.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=xHCzmKcJvL444sjVaXPTHlIMPCPf33wGF1k2MUNHwNI=;
        b=Xa9M2Ms6tNOmJpk3R27ZYIPe2/FUs5BfZaSZrYX0vqnprcFGfAb/W+946XDOWkBeQN
         tgqxNabUaCMVaat57uzRNOCf+Pljez2IARumiIN2aMDCwR9YRRMIZI55mOLuySS+5iMh
         nscNiijj4jqcWS0xL52NmYZHnFvIBTdVvO0L4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=mnVGggvK0Mho0toWItSfHCwyfpYHpjqYdk7meuUs9zcpiml3QrN5bkZytA68r2gsnY
         zZrR1eMFXrLdPt0onFwcLom5GgfSGGGphhPPpwxG5PKbeFz5c/B/WPVOuK4qM+8glmAr
         YPl/mZ7TCzxsm13kONkuMrhR7ofROLBeBMVmI=
Received: by 10.223.123.129 with SMTP id p1mr7516898far.0.1237929366100; Tue, 
	24 Mar 2009 14:16:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114493>

Hi folks.

I'm latest stable git (1.6.2) on a bright background terminal.

Unfortunately, the default text foreground color for the "commit
<HASH>" line of git-log is 3 - yellow. And yellow writing is not very
readable on bright background. Of course, I could customize color 3 at
the terminal letter to be darker, but that breaks everything else that
uses color 3 as a background highlight (vim, ack, etc.)

I've scoured the man pages, but haven't found any way to set the color
for that line in .gitconfig.

So, I suggest that this should be considered a bug. At the very least,
there should be an easy way to set that color for all us using a
bright background terminal - the default Gnome Terminal, the default
Terminal.app, and generally the default on many systems.

Is there any good solution for this that I missed?

Thanks,

Fynn
