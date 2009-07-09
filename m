From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: 'git svn fetch' keeps giving a error after freezing
Date: Thu, 09 Jul 2009 14:46:27 +0200
Message-ID: <h34ors$g55$1@ger.gmane.org>
References: <h31vg6$b38$1@ger.gmane.org> <20090709093412.GA30076@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 14:47:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOt1z-0001kk-Mv
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 14:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759163AbZGIMrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 08:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758317AbZGIMrL
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 08:47:11 -0400
Received: from main.gmane.org ([80.91.229.2]:51524 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759139AbZGIMrK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 08:47:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MOt1o-0005kN-BM
	for git@vger.kernel.org; Thu, 09 Jul 2009 12:47:08 +0000
Received: from dsl-245-91-189.telkomadsl.co.za ([41.245.91.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 12:47:08 +0000
Received: from graemeg by dsl-245-91-189.telkomadsl.co.za with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 12:47:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-245-91-189.telkomadsl.co.za
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <20090709093412.GA30076@nan92-1-81-57-214-146.fbx.proxad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122971>

Yann Dirson wrote:
> I ran an "svn clone -s http://svn2.freepascal.org/svn/fpc" yesterday,
> and it went through all 13373 revs without a problem.  The freeze you
> talk about must have done something weird to the git-svn metadata.
> 


That is weird. Two of you got it right without issues.... I'm trying 
again, using a new repository directory and see what happens. Like you 
said, maybe the original one got corrupt or something.

I'm using the following command:

$ git svn clone -s --authors-file=/mnt/samba/git/fpc-users.txt \
      http://svn2.freepascal.org/svn/fpc fpc_new.git

Lets hope it goes through this time. I'll report on my progress later. 
If this doesn't work, I'll try it without the --authors-file option.

If it doesn't go well, any chance you still have that FPC repository 
lying around? Would it then be possible for you to repack the repository 
and archive (zip, bzip, 7zip etc..) the repository so I could download 
the whole thing from you? But this is ONLY if my new attempt doesn't work.

I'm hoping all will go well though, otherwise I am totally stumped as to 
why I can't clone it myself.

Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
