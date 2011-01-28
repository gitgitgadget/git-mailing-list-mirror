From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] merge: default to @{upstream}
Date: Fri, 28 Jan 2011 19:53:41 +0200
Message-ID: <AANLkTikToBdcqPRx3Gu53r9vS6mwhoi1DS4GV63nOcxH@mail.gmail.com>
References: <1296231457-18780-1-git-send-email-felipe.contreras@gmail.com>
	<1296233099.12855.14.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Jan 28 18:53:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PisW4-0004zB-Hl
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 18:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305Ab1A1Rxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 12:53:43 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57469 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab1A1Rxm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 12:53:42 -0500
Received: by bwz15 with SMTP id 15so3454956bwz.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Pcf0ha/go0TnbAhpNb7XLqsiLuvJ1V9wLuivpMU9gFA=;
        b=OrgQy6lGYT1MMKnMsC5oQ5IpDJf1zdP3CixVtb7P9qgu/j6pvnY01TuTPedxI6cgMI
         e03srV5UZUcxpMm3/t9cVe+R1JIPaN37yqNzhXVToAWXBtyrzju4HF+mzwLg8Phj9OzW
         YZPfLW8aUDGc5PlcNP6Hkdzm+m94vRNCkUcXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HL/YevAMm83tLnN0/6e029QUF6DmFgoNMoXhdq1GBTecBa+CHYkdADvebpLxAPN7W3
         XcAzFu0yFCzVPcUpKSzSjYK0Qjs9J9eyPMWkrB92PfoniTNFqf+qzE29NXMR/20WNzIo
         2cib5dPxRiKvq2V+97mUBsUEm6zUGpY+g2Dyg=
Received: by 10.204.70.137 with SMTP id d9mr2731938bkj.141.1296237221593; Fri,
 28 Jan 2011 09:53:41 -0800 (PST)
Received: by 10.204.102.9 with HTTP; Fri, 28 Jan 2011 09:53:41 -0800 (PST)
In-Reply-To: <1296233099.12855.14.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165629>

On Fri, Jan 28, 2011 at 6:44 PM, Drew Northup <drew.northup@maine.edu> wrote:
> Honestly, I'd prefer that this NOT be merged in. When I mess up the
> command line I am typing I don't want some sort of hidden magic to kick
> in--I want it to tell me that I did something stupid by printing out the
> help message. This is standard to a large number of commands that by
> default expect a certain number of operands and I don't see any good
> reason why git merge should be any different.

git checkout (defaults to HEAD)
git diff (defaults to HEAD)
git fetch (defaults to origin)
git format-patch (defaults to HEAD)
git log (defaults to HEAD)
git pull (defaults to origin)
git show (defaults to HEAD)

How is this different from 'git pull'? If you are not sure about the
'git merge' command, then type 'git help merge' instead. Just like if
you are not sure about the 'git pull' command. If you type any of
these two, a merge would happen, and you can revert it easily with
'git reset --hard HEAD^'.

-- 
Felipe Contreras
