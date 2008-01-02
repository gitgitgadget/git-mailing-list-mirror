From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Retroactively change email signature?
Date: Wed, 2 Jan 2008 15:37:51 -0500
Message-ID: <9b3e2dc20801021237v4d5d236fn3d2643502b9bb78f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 21:38:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAALz-0006N6-0F
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 21:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035AbYABUhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 15:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756595AbYABUhx
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 15:37:53 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:34681 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756419AbYABUhw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 15:37:52 -0500
Received: by rv-out-0910.google.com with SMTP id k20so5402471rvb.1
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 12:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=jv6ZlZdOO3waV9JHHZRj48qx0ckuSzMO1HKXPsxUtE8=;
        b=njyxDPtRKKBUVN88j/md42rFtVItAU06/dBV9OAvOEh7fLNMJp1OXru7KdWna5Szkq9OsG5fNzG6eDZ3hFS4cYcv9aYM4KdY2Fwo+KbD60evrHeDO7Sl56gCAvo6HsoNeBe+OUiStCi0Y+d2jhush2y55SmMTXsoxs6h28ymFOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=V7kqmiYpY5pStOk2nQxI0CVyeGlGXDB5wmU6mUrB6bzgtLDXMKfIdMCATLnAlLxBg/D1rtkhz2auJvmKnALTs9tcJj0OrBCqdoWRgJ1Y4Q+2QpJezvs+oOYQG7AtaVZpGAgsXGMtvLg9qBNBqOmxPdRYyInU9UpXMFLC28its7o=
Received: by 10.141.20.7 with SMTP id x7mr7586869rvi.207.1199306271772;
        Wed, 02 Jan 2008 12:37:51 -0800 (PST)
Received: by 10.140.188.1 with HTTP; Wed, 2 Jan 2008 12:37:51 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69490>

Hi,

I imagine that changing old commits is considered one of the great
evils of source control, but I have a small problem:
I have a habit of testing my code on several different computers and
operating systems.  Sometimes when setting up a new computer for
testing (and thus, for development, since testing always results in a
few commits), I have forgotten to use git-config to configure my name
and email address.

Since git doesn't warn when I've forgotten to do this, my git-log is
now sprinkled with various email addresses, some which are just my
username@hostname.  This is completely useless to people who might
view my public repository.

Is it possible to retroactively change the author and email of several
commits?  Perhaps some sort of search-and-replace for the commit
metadata?  Even for older commits, I'd like to change the email
addresses to my current address.

If it's not possible it's not the end of the world, but I thought it
wouldn't hurt to ask.

thanks,
Steve
