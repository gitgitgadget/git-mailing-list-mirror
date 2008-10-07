From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC] rebase--interactive: if preserving merges, use first-parent
 to limit what is shown.
Date: Tue, 07 Oct 2008 11:57:56 +0200
Message-ID: <48EB32A4.80809@redhat.com>
References: <48E8DD7E.9040706@redhat.com>	<20081006102118.3e817a0f.stephen@exigencecorp.com> <20081006212021.04ba9214.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 12:00:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn9Lb-0003fv-P9
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 11:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbYJGJ6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 05:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbYJGJ6D
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 05:58:03 -0400
Received: from mx2.redhat.com ([66.187.237.31]:54456 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbYJGJ6B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 05:58:01 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m979vxSs018835;
	Tue, 7 Oct 2008 05:57:59 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m979vwBp027049;
	Tue, 7 Oct 2008 05:57:58 -0400
Received: from balrog.qumranet.com (vpn-12-104.rdu.redhat.com [10.11.12.104])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id m979vubr022318;
	Tue, 7 Oct 2008 05:57:57 -0400
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081006212021.04ba9214.stephen@exigencecorp.com>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97686>

Stephen Haberman wrote:
> However, t3404 makes a good point that if the right hand of the merge
> has parents that are going to get rebased, the right hand side does
> need to be included/shown/rewritten.
>
>   

But, won't those commits get linearized?  Won't git rebase pick the 
commits into the left-hand side of the merge instead of into the right 
hand side?

If git rebase is to handle nonlinear history, it needs much more 
expressive commands; not only saying which commit to pick, but also what 
the commit's parents shall be.

-- 
error compiling committee.c: too many arguments to function
