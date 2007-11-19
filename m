From: gerhard.oettl.ml@ogersoft.at
Subject: Re: [user] git-svn and svn cp
Date: Mon, 19 Nov 2007 14:34:35 +0100
Message-ID: <474190EB.2090701@ogersoft.at>
References: <47416F68.9070908@ogersoft.at> <vpq3av25sg0.fsf@bauges.imag.fr> <86k5oez9f5.fsf@lola.quinscape.zz> <vpqzlxa2y2f.fsf@bauges.imag.fr> <EB96D9F3-D69C-4D46-961C-27885CBC0E52@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Nov 19 14:33:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu6kH-0003fq-2Z
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 14:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbXKSNco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 08:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbXKSNcn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 08:32:43 -0500
Received: from h082218134240.host.wavenet.at ([82.218.134.240]:33755 "EHLO
	h082218134240.host.wavenet.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751911AbXKSNcn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2007 08:32:43 -0500
Received: from [192.168.1.101] (85-124-70-106.work.xdsl-line.inode.at [85.124.70.106])
	(authenticated bits=0)
	by h082218134240.host.wavenet.at (8.13.8/8.13.8/SuSE Linux 0.8) with ESMTP id lAJDWS5m020822
	for <git@vger.kernel.org>; Mon, 19 Nov 2007 14:32:41 +0100
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <EB96D9F3-D69C-4D46-961C-27885CBC0E52@lrde.epita.fr>
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65441>

Benoit Sigoure schrieb:
> On Nov 19, 2007, at 1:56 PM, Matthieu Moy wrote:

> I think this is irrelevant to the question he asked.
> 
> Now I think that the fact that SVN does "lightweight" copies by 
> recording that such modification was in fact an `svn cp' / `svn mv' 
> isn't important for git-svn, because the data end up in the Git 
> repository which handles copies and moves much much better than SVN 
> does.  

I hoped this and it was one of the motivations for looking at git  ;-)

But why is so much traffic necessary to transfer data that is already 
_complete_ present in the local git repository?
Traffic that seams not to be necessary when using the "not so good" svn.


gerhard
