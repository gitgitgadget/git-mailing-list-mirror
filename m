From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: branch description
Date: Tue, 15 Apr 2008 12:51:49 -0400
Message-ID: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 19:18:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JloOa-0000u7-Po
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 18:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759626AbYDOQvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 12:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759587AbYDOQvv
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 12:51:51 -0400
Received: from rv-out-0708.google.com ([209.85.198.248]:23660 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758835AbYDOQvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 12:51:50 -0400
Received: by rv-out-0506.google.com with SMTP id k29so917925rvb.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=UjcHo7z0L3X+tLNKue2J5dWP1lBw8+Q7jpHjmjQidHQ=;
        b=Fz7cQgaPguvzN6+K0xj3BpU/rceKyQmcxsd3Hnr5Z/6nZfbdODjyB3Ueu8betpOO/l+nbfvXxoDV57NWvACUxcWOGCZY7wJILMNmN2ttu7yvtODT1/5aE94BGnplXCcepvY010lW7jDciZFLONEcGMaPfbllVpuMUJL6hzR/wm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IXD/HouV2maOdPw2G+8lSmHNMWomdJ1iwKp6R5matAACOgZN53qu7eh+peRWwvyvh3knlE0jE08GMjmHfSMBEO8pm97SbPfSXsy8tHsAvvUZ5dEWPiCauiK4duiGKIruTZ1UGBoAGUuiWuLwRY1AxbG/E7RhHI2sW+nn6mCsr04=
Received: by 10.141.129.14 with SMTP id g14mr4428429rvn.274.1208278309820;
        Tue, 15 Apr 2008 09:51:49 -0700 (PDT)
Received: by 10.141.66.3 with HTTP; Tue, 15 Apr 2008 09:51:49 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79608>

Hi,

I find it useful to use fairly short names for branches.  However,
sometimes I would like to have a full sentence to actually describe
what the branch is for, without having the peruse the actual commits.

This is both for when I later can't remember why I made a certain
branch, or for when people clone and look at a list of branches
wondering what the differences are between them.

This information could of course be kept on a web page, but it would
be nice to have it in the repo.
Is there any such branch annotation command?
Ideally I'd like to see a sentence displayed next to the branch name
when I use "git-branch".
Perhaps, git-branch --info or something.


Steve
