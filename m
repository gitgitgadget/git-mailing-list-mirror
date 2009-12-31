From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] MinGW: Use pid_t more consequently, introduce uid_t 
	for greater compatibility
Date: Thu, 31 Dec 2009 15:14:32 +0100
Message-ID: <bdca99240912310614k46af8df1s181d258766c5a5ad@mail.gmail.com>
References: <hhbldr$di8$1@ger.gmane.org> <4B3A7000.4050308@kdbg.org>
	 <bdca99240912291649h1c727072q3b1e4099cab426df@mail.gmail.com>
	 <4B3CAC2D.5050500@kdbg.org>
	 <alpine.DEB.1.00.0912311511350.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 31 15:14:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQLnS-0003Cc-Na
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 15:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbZLaOOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 09:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbZLaOOe
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 09:14:34 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:36454 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbZLaOOe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 09:14:34 -0500
Received: by fxm25 with SMTP id 25so6700502fxm.21
        for <git@vger.kernel.org>; Thu, 31 Dec 2009 06:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=z3OC2RhB2CD6OmT3FeNdwg8o3b6LvfwbMJhKWrEYTb8=;
        b=xERXyupqYGzWWZmCztmB5fApBEbbSIo135WH8sLc0ZjBLjljx8KIdhCAG0PV3A95gH
         j7KD9ClgIPXQBONsOfloIo8nE9O39I4zbzz9TpxPAEyxT6NStcmM/T5FNc+txaZ/IWcF
         0HQZigYVJ9CFA3YzsyMfkIA47TyQjlT1f6ZMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ckp3IJvhmXKy/i7lW1SSgrHg31i/1Curl0c7oP6itcID8e3b+HRN8l0CrEC9MJ+Cpw
         +mqKZrAyalBhjVbPyAOe6+j76fOcO0FmlpHcR2a1LM1E5owxIhBFx9r6s/FkQ3aJZwbC
         fKFrTW4Fai0zm+53oDjSWj4EVOG0e29x8dK3s=
Received: by 10.87.40.9 with SMTP id s9mr25553362fgj.11.1262268872545; Thu, 31 
	Dec 2009 06:14:32 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0912311511350.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135951>

On Thu, Dec 31, 2009 at 15:12, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>> > I wanted to include Hany's Dos2Unix tool (hd2u) into msysGit.
>>
>> We have dos2unix. What's wrong with it?
>
> hd2u can handle mixed line endings, and it has a dry run mode IIUC.

Right. One of the best features over dos2unix IMHO is that hd2u can
detect line-endings (and any problems like mixed / stray line-endings)
without actually modifying any files. This makes it a very nice tool
to detect any line-ending issues in the working tree of cross-platform
projects due to wrong autocrlf configurations.

-- 
Sebastian Schuberth
