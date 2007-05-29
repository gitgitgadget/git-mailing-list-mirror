From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 12:54:07 +0200
Organization: eudaptics software gmbh
Message-ID: <465C064F.B9CE9379@eudaptics.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 12:53:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HszKe-00046E-LI
	for gcvg-git@gmane.org; Tue, 29 May 2007 12:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbXE2Kxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 06:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756172AbXE2Kxa
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 06:53:30 -0400
Received: from main.gmane.org ([80.91.229.2]:59284 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756098AbXE2Kx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 06:53:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HszKK-0004zE-8p
	for git@vger.kernel.org; Tue, 29 May 2007 12:53:20 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2007 12:53:20 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2007 12:53:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48680>

Han-Wen Nienhuys wrote:
> Johannes Sixt escreveu:
> > * git without an correct git subcommand should list 20 or so commands,
> > but it doesn't. The list is just empty.
> 
> there was a problem in generate cmd list,  (I have sort in /bin/ ). I
> recommend to add

Strange. Here, MSYS aliases /usr to /, hence /usr/bin/sort is the same
as /bin/sort.

(For the curious ones: The MinGW port has to replace occurrences of
'sort' by '/usr/bin/sort', otherwise Windows's 'sort' would be picked up
in shell scripts, because the latter usually comes first in
%PATH%^W$PATH. Same for 'find'.)

-- Hannes
