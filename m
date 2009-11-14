From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git svn fetch loses data
Date: Sat, 14 Nov 2009 20:38:03 +0100
Message-ID: <fabb9a1e0911141138r5279650ge57db2413e2321a4@mail.gmail.com>
References: <7d4f41f50911140907n285d72dcp7bbe802900f8bae5@mail.gmail.com> 
	<fabb9a1e0911140925r3f7b7806s65da03c046bf5ab4@mail.gmail.com> 
	<7d4f41f50911141129n967374ap7d92296c5723e31e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Victor Engmark <victor.engmark@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 20:38:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9OS6-0003ZJ-Op
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 20:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbZKNTiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 14:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbZKNTiT
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 14:38:19 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:47770 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbZKNTiS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 14:38:18 -0500
Received: by fxm21 with SMTP id 21so1547285fxm.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 11:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Um12R6Oe/2wfAKuxZ2jr1SPD+51RTlaBGDXQtgHfn5s=;
        b=bpBOExtV77517G0SyhEotAZA3PAbORI5AEEdXDQ8JEASdpFP4NXJKp/Bjml0mUHk7K
         zngwMbLuDjUgpOFBPhptSqXAjJoowI3Z16vNg87UFH9rhmxvOnijpz9J7VxrphfpVvk2
         V+QGOIhNaOBF3o0K2/z+9O37OuzacBX6H5/Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aJwGctGxrScbn4HtKSHeYgBEtQzF9QeZZApM5WOUZ9C19kpsSOhfM6hElad0SwYvmn
         4lVt/iFR58GKYa3aKWnU76yFnh2FQJDt6qw1c+WVSdolk1LMtkgheSN2AW94lyqKrr/9
         pxPlf6QJAGDWl/nJ3UiCKaPRlEXshtejRqmlM=
Received: by 10.216.89.11 with SMTP id b11mr384089wef.171.1258227503121; Sat, 
	14 Nov 2009 11:38:23 -0800 (PST)
In-Reply-To: <7d4f41f50911141129n967374ap7d92296c5723e31e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132883>

Heya,

On Sat, Nov 14, 2009 at 20:29, Victor Engmark <victor.engmark@gmail.com> wrote:
> Do I need to run something after fetch to see them?

Your working copy is probably not up to date anymore, try:

$ git rebase git-svn

-- 
Cheers,

Sverre Rabbelier
