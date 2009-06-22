From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] clone: add --perm option to clone an shared repository
Date: Mon, 22 Jun 2009 12:19:44 +0200
Message-ID: <4A3F5AC0.20207@gnu.org>
References: <1245586672-10894-1-git-send-email-roylee17@gmail.com> <4A3F3E08.10602@gnu.org> <alpine.DEB.1.00.0906221134090.4168@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Roy Lee <roylee17@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 22 12:20:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIgdg-0001O4-Fb
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 12:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbZFVKT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 06:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbZFVKTz
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 06:19:55 -0400
Received: from mx2.redhat.com ([66.187.237.31]:52482 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbZFVKTy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 06:19:54 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n5MAJswR006494;
	Mon, 22 Jun 2009 06:19:54 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n5MAJrfJ015556;
	Mon, 22 Jun 2009 06:19:53 -0400
Received: from yakj.usersys.redhat.com (dhcp-lab-149.englab.brq.redhat.com [10.34.33.149])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n5MAJqkZ001682;
	Mon, 22 Jun 2009 06:19:52 -0400
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <alpine.DEB.1.00.0906221134090.4168@intel-tinevez-2-302>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122026>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 22 Jun 2009, Paolo Bonzini wrote:
> 
>> Roy Lee wrote:
>>> The term 'shared' used here is in the same context with git init.
>>> Unfortunately the 'shared' option has been taken, so I took the "perm"
>>> as a place holder in this patch. Any comments?
>> I think it would make sense to add "perm" to git-init too (and possibly
>> deprecate --shared).
> 
> Agreed.  After we teach everybody on this planet that "perm" means 
> "shared", and "shared" does not.

Or instead of teaching everybody on this planet that "shared" means "set 
permissions for sharing" in one context, and "use hard links and set up 
.git/objects/info/alternates, which by the way may be dangerous" in 
another. :-)

But you made me think, and maybe it is better to remove argument-less 
--shared instead.  What Roy introduced seems much more useful in practice.

Paolo
