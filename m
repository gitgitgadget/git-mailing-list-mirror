From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-core-arch: Missing dependency
Date: Fri, 11 Nov 2005 19:20:31 +0100
Message-ID: <4374E0EF.2020801@op5.se>
References: <200511111446.jABEk6QM023362@pincoya.inf.utfsm.cl> <7vy83vnl7r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 11 19:22:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EadVv-0000TY-Oq
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 19:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVKKSUc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 13:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVKKSUc
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 13:20:32 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:47023 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750965AbVKKSUc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 13:20:32 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 3730B6BD02
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 19:20:31 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vy83vnl7r.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11623>

Junio C Hamano wrote:
> Horst von Brand <vonbrand@inf.utfsm.cl> writes:
> 
> 
>>The command git-archimport makes use of tla, but the relevant package(s) are
>>not on the requirements
> 
> 
> Thanks.  Should the fix be like this?
> 
>  Group:          Development/Tools
> -Requires:       git-core = %{version}-%{release}
> +Requires:       git-core = %{version}-%{release}, tla

Just to be anal;
Requires doesn't usually include the %release, since that's supposed to 
represent changes in the spec-file rather than the source (although 
patches included in the spec-file often counts as a new %release, but 
that's no reason to make it so in the official spec).

I really have to sobner up and get cracking on that spec-file thingie 
stuff. Or some such.

Cheers for the beers and review of the peers.

Hooray for firday. ;)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
