From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 14:04:07 -0300
Message-ID: <4659BA07.4080307@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <Pine.LNX.4.64.0705251113280.4648@racer.site> <46588DA4.5020109@xs4all.nl> <Pine.LNX.4.64.0705262311380.4648@racer.site> <46592B92.9060403@xs4all.nl> <Pine.LNX.4.64.0705271149450.4648@racer.site>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 19:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsMCN-0006jQ-Fn
	for gcvg-git@gmane.org; Sun, 27 May 2007 19:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795AbXE0RGT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 13:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755691AbXE0RGT
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 13:06:19 -0400
Received: from main.gmane.org ([80.91.229.2]:34902 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755367AbXE0RGS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 13:06:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HsMC6-00066x-KX
	for git@vger.kernel.org; Sun, 27 May 2007 19:06:14 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 May 2007 19:06:14 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 May 2007 19:06:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <Pine.LNX.4.64.0705271149450.4648@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48567>

Johannes Schindelin escreveu:

>>       ((Tcl_Obj **) objv) += (async + 3);
> 
> Ah yes, I was using MinGW's own GCC, which is GCC 3.something.
> 
> It is a new "feature" of GCC 4.x to disallow constructs like these. 
> (Probably because GCC people think that other people are not intelligent 
> enough to understand such constructs, and therefore prohibit their use.)

I very much doubt that. GCC uses type information to determine whether 
pointers might be aliased.  I think disallowing such constructs helps with
compiler optimization.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
