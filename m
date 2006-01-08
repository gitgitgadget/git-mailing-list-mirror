From: Timo Hirvonen <tihirvon@gmail.com>
Subject: git-format-patch Date header
Date: Sun, 8 Jan 2006 16:40:38 +0200
Message-ID: <20060108164038.89e4439f.tihirvon@gmail.com>
References: <20060108141457.8C4E85BE8F@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 08 15:40:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evbiq-0004H5-Dv
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 15:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbWAHOkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 09:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbWAHOkh
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 09:40:37 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:39544 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752633AbWAHOkh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 09:40:37 -0500
Received: by uproxy.gmail.com with SMTP id s2so35190uge
        for <git@vger.kernel.org>; Sun, 08 Jan 2006 06:40:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=UdmZYH6dx3TWD2M68ommBYhq2Tm6lkIlm34N8kGHYDQDHduyipsffy3Y9an4sYwym8dVPARzM4ATp9IxRp+lGfB9SLC3/lVdDq5oDKq41d8JOPusqaeWa2GBMrpg0I6l4Q7JIw6Ekc9Zucew2sT9LNXJkRb/VLVOGYLl97KV/Po=
Received: by 10.66.224.6 with SMTP id w6mr7121276ugg;
        Sun, 08 Jan 2006 06:40:35 -0800 (PST)
Received: from garlic.home.net ( [82.128.203.84])
        by mx.gmail.com with ESMTP id m1sm11201655ugc.2006.01.08.06.40.34;
        Sun, 08 Jan 2006 06:40:35 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <20060108141457.8C4E85BE8F@nox.op5.se>
X-Mailer: Sylpheed version 2.2.0beta2 (GTK+ 2.8.9; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14320>


git-format-patch uses "date '+%s %z'" format for the Date header.
Sylpheed does not understand this format.  How common this convention
is?  Should we change git-format-patch to use more standard date format?

OTOH, I like the %s format because it is so simple and easy to parse :)

-- 
http://onion.dynserv.net/~timo/
