From: Trekie <trekie@sinister.cz>
Subject: Re: [RFC] adding support for md5
Date: Fri, 18 Aug 2006 12:52:38 +0200
Message-ID: <44E59BF6.2070909@sinister.cz>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 12:49:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE1uR-000649-C0
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 12:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWHRKs7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 06:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWHRKs7
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 06:48:59 -0400
Received: from smtp.ispservices.cz ([193.86.244.30]:65191 "EHLO inetgw.ido.cz")
	by vger.kernel.org with ESMTP id S1751363AbWHRKs6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 06:48:58 -0400
Received: from [192.168.171.2] ([192.168.171.2])
	by inetgw.ido.cz (8.13.7/8.13.7) with ESMTP id k7IAmnK0002146;
	Fri, 18 Aug 2006 12:48:50 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060814 SeaMonkey/1.0.3
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25648>

Hi,

I'd like to point out that while finding collision for SHA1 according to
the Wikipedia needs 2^63 operations and AFAIK no collision has been
found yet, finding collision for MD5 can be achieved in a minute and
less (see http://cryptography.hyperlink.cz/2006/tunnels.pdf for details).

David Brodsky
