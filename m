From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 3/4] git-commit: Refactor creation of log message.
Date: Tue, 05 Feb 2008 07:07:33 +0100
Message-ID: <47A7FD25.7040401@gnu.org>
References: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org>	<14fc1ba3f94a773ab2e5b8cdf0c230962f32180d.1200933409.git.bonzini@gnu.org>	<alpine.LSU.1.00.0802041646461.7372@racer.site>	<47A747EB.9020909@gnu.org> <7vzluggp0q.fsf@gitster.siamese.dyndns.org> <7vzlugf3la.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 07:08:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMGyf-0001SL-2K
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 07:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbYBEGHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 01:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbYBEGHl
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 01:07:41 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:24672 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYBEGHk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 01:07:40 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2133852fga.17
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 22:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=/RIdouDIJsxKxhDSkYu1asfltq7pnByDwpuRw21XiOM=;
        b=kXls8DB8HGdxYElloR+zyKigsjDpdksMPlYMSQ1/349U99MPwNMMXAonUGlrJUIo1Ndc/0dAWcvrUg/ZATs8Z4zyaUBxSmrdAHun9ZCDPIl3NtMDx+iQFmXwU9GcBHQEkdfy+8nTr+a3hxu5KzxxlcgaINw43D7HW0hpginaTMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=IDI2UQklLzJkQk0HOhzsVM9yiJBTFZYYy26pnV/Io3rDETAEgtWDg3DloCPXe0h2YNMCSwKFY/lc9Bennjq1tIvPLokqvdo9ia296Q8vpBdmwnCJOkOVnQZwhK7EwO5FWiSLS1atJCE0G63vxiOYLFKLoLXNdtEBvDQXhXqiuvk=
Received: by 10.86.97.7 with SMTP id u7mr7436567fgb.39.1202191656926;
        Mon, 04 Feb 2008 22:07:36 -0800 (PST)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id e11sm19206544fga.5.2008.02.04.22.07.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Feb 2008 22:07:36 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <7vzlugf3la.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72627>


>> I think this _could_ error out if your index is unmerged.
> 
> I just tried.  This would annoy me.

Right, you beat me to it.  It would annoy me too.

Paolo
