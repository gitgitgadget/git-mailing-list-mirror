From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] clone: add --perm option to clone an shared repository
Date: Mon, 22 Jun 2009 10:17:12 +0200
Message-ID: <4A3F3E08.10602@gnu.org>
References: <1245586672-10894-1-git-send-email-roylee17@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roy Lee <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 10:17:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIeiZ-0001gQ-8X
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 10:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbZFVIRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 04:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbZFVIRV
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 04:17:21 -0400
Received: from mx2.redhat.com ([66.187.237.31]:53792 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbZFVIRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 04:17:20 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n5M8HMme007058;
	Mon, 22 Jun 2009 04:17:22 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n5M8HLBW010169;
	Mon, 22 Jun 2009 04:17:22 -0400
Received: from yakj.usersys.redhat.com (dhcp-lab-149.englab.brq.redhat.com [10.34.33.149])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n5M8HKHj011720;
	Mon, 22 Jun 2009 04:17:21 -0400
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <1245586672-10894-1-git-send-email-roylee17@gmail.com>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122019>

Roy Lee wrote:
> The term 'shared' used here is in the same context with git init.
> Unfortunately the 'shared' option has been taken, so I took the "perm"
> as a place holder in this patch. Any comments?

I think it would make sense to add "perm" to git-init too (and possibly 
deprecate --shared).

Paolo
