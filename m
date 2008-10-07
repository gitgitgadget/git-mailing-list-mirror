From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC] rebase--interactive: if preserving merges, use	first-parent
 to limit what is shown.
Date: Tue, 07 Oct 2008 14:22:26 +0200
Message-ID: <48EB5482.7050207@redhat.com>
References: <48E8DD7E.9040706@redhat.com> <20081006102118.3e817a0f.stephen@exigencecorp.com> <20081006212021.04ba9214.stephen@exigencecorp.com> <48EB32A4.80809@redhat.com> <20081007120700.GC7209@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Haberman <stephen@exigencecorp.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 14:24:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnBbP-0001dP-5q
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 14:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbYJGMWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 08:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbYJGMWe
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 08:22:34 -0400
Received: from mx2.redhat.com ([66.187.237.31]:44763 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbYJGMWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 08:22:33 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m97CMUgv013235;
	Tue, 7 Oct 2008 08:22:30 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m97CMT1P024872;
	Tue, 7 Oct 2008 08:22:29 -0400
Received: from balrog.qumranet.com (vpn-12-27.rdu.redhat.com [10.11.12.27])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id m97CMQYh005233;
	Tue, 7 Oct 2008 08:22:27 -0400
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081007120700.GC7209@leksak.fem-net>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97701>

Stephan Beyer wrote:
> Hi,
>
> Avi Kivity wrote:
>   
>> If git rebase is to handle nonlinear history, it needs much more
>> expressive commands; not only saying which commit to pick, but also what  
>> the commit's parents shall be.
>>     
>
> git-sequencer has a "merge" command for that. I'm really sorry that this has
> not been sent to the list yet. Nevertheless I'm always glad to find testers
> for sequencer, so if you like, fetch
> 	git://repo.or.cz/git/sbeyer.git seq-builtin-dev
>
>   

But this isn't a merge; it's more of a 'pick into this branch' instead.

Maybe 'merge' can do this, but we also need to populate the todo with 
the required information (otherwise, git rebase -i without changes to 
the todo file will not be a no-op).


-- 
error compiling committee.c: too many arguments to function
