From: Eric Kidd <git@randomhacks.net>
Subject: filter-branch: Remove original/* (was Re: [RFC] What's the best UI 
	for 'git submodule split'?)
Date: Fri, 13 Feb 2009 21:45:09 -0500
Message-ID: <431341160902131845g58d99635ie0735b433802d6be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 03:46:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYAYB-0003EB-M2
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbZBNCpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbZBNCpM
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:45:12 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:44532 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbZBNCpL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:45:11 -0500
Received: by yw-out-2324.google.com with SMTP id 5so731552ywh.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 18:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i7jX60IumkX7s2OJsgYA0whlT0S9I5HBPTgoBIl3f8o=;
        b=RDNm9m9CQCNGLdMQ9qmzJhjUIP70KWqffJpvjyHF4CVrFG6ZrDojeUSxtoT0Dd0IKV
         tgEHx7vbl/dbIn3D0SFY8xB33gigaHsLpLtPQxk+Tpa4qTa/8d/JQYP3ZV4T/uET0c0q
         DWHuT6SQB1m2N6KW8tmCEF/pVrpH6mPvkEMq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        b=bIRaIWLao6YxgyYM0DmUGra0p5jOc1+LP8sYgVLA75D5L4qZY7TbmqaY9Ki3JxhDJv
         bhucfhHQjomRyF4YVq0lQHksgh/qO5UhyCQ8EoP2JqT8ohy1eLtLPTUIJNeWGwCoZLuM
         o01vso49Gwp/m/Fkg7xQcus+wIciSXjDhGoOY=
Received: by 10.150.189.2 with SMTP id m2mr1647791ybf.114.1234579509703; Fri, 
	13 Feb 2009 18:45:09 -0800 (PST)
X-Google-Sender-Auth: 8cdb2e2623d9be59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109809>

On Thu, Feb 12, 2009 at 4:59 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Thu, 12 Feb 2009, Eric Kidd wrote:
>
> >   rm .git/refs/original # or just use --force below
>
> BTW I wanted to get rid of this for a long time now, but I cannot seem to
> find the time to work on it.  The 'original' refs should not be needed, as
> that's a job for the reflogs (yeah, people tried to convince me back then,
> but I finally got it, okay?)

Removing the original/* directory would certainly make my life easier.
But the reflog only stores backups for branch heads, not tags, right?
If there's a good way to handle this, I'd be happy to send a patch.

Cheers,
Eric
