From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: How do I apply a single "change"
Date: Sat, 7 Jan 2006 16:51:52 -0800 (PST)
Message-ID: <20060108005152.46315.qmail@web31813.mail.mud.yahoo.com>
References: <7v7j9b8sgf.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 01:52:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvOmt-0001pT-Vp
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWAHAvy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbWAHAvy
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:51:54 -0500
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:45755 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161113AbWAHAvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 19:51:53 -0500
Received: (qmail 46317 invoked by uid 60001); 8 Jan 2006 00:51:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=aa5mL88UougqvMl55djqHbZqKsJKEmz4vZ/zKT+HSkYxWMPGOACJ2TAWLGBLtWuMq2OlJn/l1CZ4bRxrkX/+MapCK0RGaDpWQwdHnIHTryVboFOuurwaQnpPfaS/OdXkeDaOMftd8NrEM4otnyGUmEqlG69RWJwVCFzwZvWTxCQ=  ;
Received: from [68.221.7.47] by web31813.mail.mud.yahoo.com via HTTP; Sat, 07 Jan 2006 16:51:52 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j9b8sgf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14299>

--- Junio C Hamano <junkio@cox.net> wrote:

> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > ... how do I apply a single "change", identified
> > by its SHA?  Either from one branch to the other or
> > remote?
> >
> > I.e. I want to "integrate" only that change?
> 
> $ git-cherry-pick $object_name

Ok, so git searches the db (other branches, etc) and
does the job.  This worked for me.

How will I do this same thing but if the "change" is
on a remote repository?

> > Alternatively, how do I apply the absolute output of
> > "git-format-patch".  I tried but whatever I tried with
> > complained that it couldn't find any email addressess.
> > (roll eyes here)
> 
> It is unclear what you mean by absolute output, but here is what
> I regularly do:
> 
> $ git-format-patch -k -m --stdout from to | git am -3 -k

I did 
$ git-format-patch commit^ commit

and the usual 0001-blah-blah file got created.  Then
I tried to apply it, but whatever I tried it complained.
Will "git-am -3 -k" work without complaining there is
no "email field" or something?  (I cannot try it as
git-cherry-pick worked for me already.)

Thanks,
   Lunen
