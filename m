From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 19:31:40 +0200
Message-ID: <4A0B03FC.9020101@op5.se>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org> <20090512161638.GB29566@coredump.intra.peff.net> <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain> <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 13 19:31:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4IJ9-0005e0-MD
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 19:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758358AbZEMRbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 13:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757555AbZEMRbo
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 13:31:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:39388 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301AbZEMRbn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 13:31:43 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1061059fga.17
        for <git@vger.kernel.org>; Wed, 13 May 2009 10:31:43 -0700 (PDT)
Received: by 10.86.74.1 with SMTP id w1mr1475043fga.53.1242235903017;
        Wed, 13 May 2009 10:31:43 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id l19sm3624594fgb.27.2009.05.13.10.31.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 10:31:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119074>

Linus Torvalds wrote:
> 
> Of course, it probably makes sense to have a whole "git_readdir()" that 
> does this thing in general. That "create_full_path()" thing makes sense 
> regardless, though, in that it also simplifies a lot of "baselen+len" 
> usage in just "len".
> 

In a flash of premonitory insight, libgit2 has 

	gitfo_foreach_dirent(path, callback)

which would probably be well suited for this kind of thing.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
