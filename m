From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Using Git with windows
Date: Fri, 6 Mar 2009 09:38:59 -0500
Message-ID: <c115fd3c0903060638lfc52073nd40e0d7379d7f593@mail.gmail.com>
References: <e878dbad0903052321l6c0d310bk2ba568138b409d36@mail.gmail.com>
	 <e878dbad0903052323m56f3d63fi69862e9dae278c00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tariq Hassanen <tariq.hassanen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 15:40:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfbE5-0003Gm-EY
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 15:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbZCFOjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 09:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754298AbZCFOjG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 09:39:06 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:45127 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbZCFOjF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 09:39:05 -0500
Received: by an-out-0708.google.com with SMTP id c2so284578anc.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 06:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uBbZdsgvLSGhTHDoxlh5WNYdDlzx3TkNACUtil3lM4k=;
        b=hYkjrT3mDW501HGlzvQhsEcUvogsF+P2PaOf3eMbuAgqKp0dtcZX3eJuChEznZIvaa
         eFH1XxEexY194nSEd6oXpQZrgmrMKXuLBdYp6wNms5E3bKGZR7qBiIYVsXsmm5e6dzy4
         WiT3vJGTTGl1OT2A9PHiLOftBxqYtqgWBRYsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VKHBIM5XveVCFRhIipqUKselvEJQj8sKdh5fJR3Od1Iry2QLcBGhxIFfk0Ll/QGSUf
         frsGRn1co0M5FNi42Ecm4uichAPZ1IB1L+w1266vtH0VtAWHfYrMSlR0PESYTC6OZOby
         RKqZNpuJUl7TM+DPGTclnt7DS5tONw/o5c7aY=
Received: by 10.100.126.15 with SMTP id y15mr1843346anc.38.1236350339395; Fri, 
	06 Mar 2009 06:38:59 -0800 (PST)
In-Reply-To: <e878dbad0903052323m56f3d63fi69862e9dae278c00@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112442>

On Fri, Mar 6, 2009 at 2:23 AM, Tariq Hassanen <tariq.hassanen@gmail.com> wrote:

> I know there are some ports for it on windows such as msysGit and it
> can also be done on Cygwin.

IMHO, Git under cygwin's pretty nice.  I tried using MSysGit as well
and didn't feel like it was quite as good as just building Git under
cygwin.  I also run Git on an Mac at home and while it's clearly
faster, Git under Cygwin still beats the pants off of SVN under
Cygwin.

> But is there a way around this if i run a linux VM with Git running
> and mount a windows ntfs partition ?

Would this really be faster?  I don't have a whole lot of experience
with virtualization, but isn't Cygwin 'basically' doing this already?
I mean, it's attempting to emulate linux system calls so that linux
software can be recompiled to run on o a Windows box.

> Any ideas? Or am i best sticking with SVN until the ports are mature enough?
> Tariq

I wouldn't bother waiting.  Git is plenty mature on Windows, either
via msys or via Cygwin.  There's no real reason to delay. :)

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
