From: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
Subject: Re: [PATCH 1/6] GITWEB - Load Checking
Date: Fri, 11 Dec 2009 16:53:34 +0300
Organization: Gulfsat
Message-ID: <20091211165334.453921b5@pbmiha.malagasy.com>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
	<1260488743-25855-2-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 15:00:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ62V-0006hC-7X
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 15:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbZLKN7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 08:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758244AbZLKN7o
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 08:59:44 -0500
Received: from smtp-out.malagasy.com ([41.204.104.33]:46772 "EHLO
	smtp-out.malagasy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757920AbZLKN7n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 08:59:43 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Dec 2009 08:59:40 EST
Received: from camel.malagasy.com (camel.malagasy.com [41.204.104.34])
	by smtp-out.malagasy.com (Postfix) with ESMTP id 0AE378C147;
	Fri, 11 Dec 2009 16:57:14 +0300 (EAT)
Received: from localhost (spamassassin.malagasy.com [41.204.104.47])
	by camel.malagasy.com (Postfix) with ESMTP id E5451FEA9;
	Fri, 11 Dec 2009 16:53:38 +0300 (EAT)
X-Virus-Scanned: par antivirus.malagasy.com
X-Spam-Flag: NO
X-Spam-Score: -2.793
X-Spam-Level: 
X-Spam-Status: No, score=-2.793 required=7 tests=[AWL=-0.194, BAYES_00=-2.599]
Received: from camel.malagasy.com ([41.204.104.34])
	by localhost (spamassassin.malagasy.com [41.204.104.47]) (amavisd-new, port 10024)
	with ESMTP id ZH1NP+6zf5n7; Fri, 11 Dec 2009 16:57:08 +0300 (EAT)
Received: from pbmiha.malagasy.com (sysadmin-cnc.malagasy.com [41.204.104.9])
	by camel.malagasy.com (Postfix) with ESMTP id 8AB89FE9C;
	Fri, 11 Dec 2009 16:53:33 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=pbmiha.malagasy.com)
	by pbmiha.malagasy.com with esmtp (Exim 4.69)
	(envelope-from <mihamina@gulfsat.mg>)
	id 1NJ5w6-0001Ef-MM; Fri, 11 Dec 2009 16:53:34 +0300
In-Reply-To: <1260488743-25855-2-git-send-email-warthog9@kernel.org>
X-Mailer: Claws Mail 3.7.2 (GTK+ 2.18.3; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135088>

> "John 'Warthog9' Hawley" <warthog9@kernel.org> :
> +    open($load, '<', '/proc/loadavg') or return 0;

What about systems not having /proc/loadavg

-- 
       Architecte Informatique chez Blueline/Gulfsat:
    Administration Systeme, Recherche & Developpement
                +261 34 29 155 34 / +261 33 11 207 36
