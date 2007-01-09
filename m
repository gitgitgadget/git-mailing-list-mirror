From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] gitweb: git_patchset_body fixes
Date: Tue, 9 Jan 2007 11:27:01 +0100
Message-ID: <200701091127.01930.jnareb@gmail.com>
References: <351088.61033.qm@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 11:27:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4EC6-0000Jf-EG
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbXAIK07 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbXAIK07
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:26:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:46550 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbXAIK06 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:26:58 -0500
Received: by ug-out-1314.google.com with SMTP id 44so6523449uga
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 02:26:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oNbtGZUyUUbCsiqM6JRfoX/E5M89qbie8TzqweJgeqD/ElSHmJFr5Rrzl1DebPl3pX0pUoPuAy0852Uz2+tZ0on/fWVm9zzDNxc0ryaCWGrqo1cJkbEEgz5qehkKNd6cHc+AWZzzo9X1bhWEOlX9GeanBJmapKINZnybzQxLr28=
Received: by 10.67.99.1 with SMTP id b1mr35768520ugm.1168338415515;
        Tue, 09 Jan 2007 02:26:55 -0800 (PST)
Received: from host-81-190-18-145.torun.mm.pl ( [81.190.18.145])
        by mx.google.com with ESMTP id q1sm40758934uge.2007.01.09.02.26.55;
        Tue, 09 Jan 2007 02:26:55 -0800 (PST)
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <351088.61033.qm@web31801.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36340>

Luben Tuikov wrote:

> Ok, I see that Junio has committed the fixes to "next" -- thanks!
> That saved me time having to manually apply them.
> 
> Now, the results are that I see the same bug.
 
(The same bug = no closing div).

I'll try to reproduce this.


What about the other error, 

>>> The second bug is displaying a renamed file with the
>>> same name as the one of the preceding "patch". Saw
>>> this one today when I pulled.

Is it corrected by those patches?
-- 
Jakub Narebski
Poland
