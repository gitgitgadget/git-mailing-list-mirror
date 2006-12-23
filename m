From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: branch.<name>.merge specifying remote branch name
Date: Sat, 23 Dec 2006 15:32:39 +0100
Message-ID: <200612231532.39363.jnareb@gmail.com>
References: <emirt5$kh3$2@sea.gmane.org> <Pine.LNX.4.64.0612230924110.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 15:30:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy7sv-0002Fm-Id
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 15:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbWLWO36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 09:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbWLWO36
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 09:29:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:18034 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbWLWO35 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 09:29:57 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3196948uga
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 06:29:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GY5kbCvg9Qc7/CsBu7wRD2SqfUsJfVKC+zdL70VMBjioLC7VsbAui5UHAI6IbAhzzDnjBrChJuxD/2CAgP3phndYZrpudmBpNbXFqUjQ+wyNOiYNXB89bO2jlIsb4A9YWGJzqjrAXAn2LGl0ewOac7pDSOZFtYFSsl2wgU5uq+E=
Received: by 10.66.219.11 with SMTP id r11mr15259819ugg.1166884195702;
        Sat, 23 Dec 2006 06:29:55 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107])
        by mx.google.com with ESMTP id 72sm14504506ugb.2006.12.23.06.29.55;
        Sat, 23 Dec 2006 06:29:55 -0800 (PST)
To: Nicolas Pitre <nico@cam.org>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612230924110.18171@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35318>

Nicolas Pitre wrote:
> On Sat, 23 Dec 2006, Jakub Narebski wrote:
> 
>> About the discussion about branch.<name>.merge specifying remote branch name
>> and relative merits of specifying remote branch name (without need for
>> tracking branch), and local branch name (which is supposedly more user
>> friendly, and branch name specifies also remote usually)...
>> 
>> Perhaps it is time to resurrect branch.<name>.mergeLocal (or localMerge)
>> idea, and both sides would be happy (well, at least when one would code
>> it ;-).
> 
> Adding more and more options doesn't make it friendlier to use.
> 
> Why couldn't both names (local and remote) be accepted by 
> branch.blah.merge?

Junio just implemented that. Although it is a bit of magic (which can bite
when you have remote which is not '.', and which has branches with the same
names like some of your local branches, and vice versa). mergeLocal would
be unambiguous...

-- 
Jakub Narebski
Poland
