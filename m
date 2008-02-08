From: "Ian Dees" <undees@gmail.com>
Subject: Re: Completion message for git-clone?
Date: Fri, 8 Feb 2008 08:23:23 -0800
Message-ID: <ad4f9af90802080823g64b44d27lb870e849e106743b@mail.gmail.com>
References: <ad4f9af90802071909s4dad180as26b2dd8b7600342f@mail.gmail.com>
	 <m3ejbn4vis.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, jnareb@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 17:24:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNW1C-000487-FJ
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 17:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbYBHQX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 11:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754522AbYBHQX2
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 11:23:28 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:8025 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbYBHQX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 11:23:27 -0500
Received: by wr-out-0506.google.com with SMTP id c48so3621868wra.23
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 08:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QOpNUNu65ott/nFzH2T3jUI79EBL3tpJlVRcJNM8idY=;
        b=PHRRNsiQ8v+8un+flMBDLuHrVTKC07gBlCW0LwLTbI6Og1lpORrjQpdwIv8MxmhHKi1OXN5e1AtmRn2IsThh9SyAKyZHJoaQAZGvdPzx5Z6533eY3V/xNsbD+/IUziZlSA4c3iybmGvGPBdGhffAll8tEvbNCPDeHn7Rm3leu4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TZSJiYp58PpZtRX2ll0m5NAM+ZgvnBsoTFuIN1VVdC9ktc4+Kr++XvLs/flzvDX1ZYFSUsMLNC/w2+FN1+L60Qv8Ej14t1AfAMYOJ2ZwD0GP0e8KWvomVB+nX3rPD6NumpMobxCgXLTlncoIwX/J61Akq6O14NqApkx1fMwntBM=
Received: by 10.142.225.11 with SMTP id x11mr7076970wfg.115.1202487803130;
        Fri, 08 Feb 2008 08:23:23 -0800 (PST)
Received: by 10.142.238.18 with HTTP; Fri, 8 Feb 2008 08:23:23 -0800 (PST)
In-Reply-To: <m3ejbn4vis.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73104>

Hi, all.

Thanks, Jeff and Jakub, for the clarifications.

Jakub writes:

> Nevertheless git-clone waits to be rewritten in C anyway, so
> there is no much initiative to improve shell version

I agree with you.  If it's about to be replaced, there's not much
point in making a wording change to the shell script.

> Perhaps git should check if there is anything to clone _before_
> git-init, or do not remove empty directory after failing to fetch.

I'm not sure that's necessary, as long as that new message is there in
1.5.4.  I'll hang tight for my distro to pick it up.

--Ian
