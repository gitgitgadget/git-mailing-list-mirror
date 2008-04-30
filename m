From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: Importing a strange svn repo layout w/ git-svn
Date: Tue, 29 Apr 2008 23:44:25 -0700 (PDT)
Message-ID: <alpine.DEB.1.00.0804292325580.2603@alchemy.localdomain>
References: <alpine.DEB.1.00.0804300011390.29172@rose.makesad.us> <481808A7.6080908@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 08:45:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr649-000674-7i
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 08:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbYD3God (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 02:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755135AbYD3God
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 02:44:33 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:43584 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754193AbYD3God (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 02:44:33 -0400
Received: from alchemy (localhost [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rose.makesad.us (Postfix) with ESMTP id 96559334150;
	Wed, 30 Apr 2008 02:44:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by alchemy (Postfix) with ESMTPS id 305876D362;
	Tue, 29 Apr 2008 23:44:26 -0700 (PDT)
X-X-Sender: paulproteus@alchemy.localdomain
In-Reply-To: <481808A7.6080908@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80801>

On Wed, 30 Apr 2008, Paolo Bonzini wrote:

>
>> Is there a way to get git-svn to handle this situation?  Perhaps git-svn 
>> has a "suffix $DIR to the repository URL" option that I missed.  If not, is 
>> it conceivable it could?
>
> See the CONFIGURATION section of git-svn(1).

Oops, thanks!  I read through the command-line options of the man page, 
but not all the way down to the CONFIGURATION where this is in fact 
clearly discussed.

That solved my issue!

-- Asheesh.

-- 
There's nothing very mysterious about you, except that
nobody really knows your origin, purpose, or destination.
