From: Andreas Ericsson <ae@op5.se>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Tue, 06 Apr 2010 17:32:05 +0200
Message-ID: <4BBB53F5.9010106@op5.se>
References: <loom.20100406T161552-321@post.gmane.org> <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Vitaly <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 17:32:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzAln-000488-WF
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 17:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895Ab0DFPcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 11:32:46 -0400
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:34448 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751665Ab0DFPcp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 11:32:45 -0400
Received: from source ([72.14.220.155]) by na3sys009aob107.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS7tUG/bQtsEjo9UXmw911vJamldKEOAE@postini.com; Tue, 06 Apr 2010 08:32:45 PDT
Received: by fg-out-1718.google.com with SMTP id 22so943320fge.11
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 08:32:42 -0700 (PDT)
Received: by 10.87.2.15 with SMTP id e15mr13002fgi.23.1270567928063;
        Tue, 06 Apr 2010 08:32:08 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id e11sm11732148fga.3.2010.04.06.08.32.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 08:32:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <4BBB5346.6070607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144149>

On 04/06/2010 05:29 PM, Vitaly wrote:
> I didn't try this, but I'll give it a try, thanks.
> 
> And what does this stage mean?
> 

It means the server is busy creating a packfile to send
over the wire. If you pack the repository before cloning
from it, deltas from the packfile will simply be copied
into the new pack. This will provide a huge speedboost,
so make sure to repack the repository on the server every
once in a while.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
