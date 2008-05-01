From: edpark <edpark@gmail.com>
Subject: Re: Files need updating following a clone?
Date: Wed, 30 Apr 2008 17:54:57 -0700 (PDT)
Message-ID: <eb5498bc-9169-4f03-a725-f8ff98f9b39a@x19g2000prg.googlegroups.com>
References: <65e5553a-a630-4b1a-9c81-f0ed7d9d7361@c19g2000prf.googlegroups.com> 
	<1c5969370804301732i282064f7r55858d54a6796791@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 02:55:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrN5T-0005Nw-UR
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 02:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbYEAAzE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Apr 2008 20:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbYEAAzD
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 20:55:03 -0400
Received: from ug-out-1516.google.com ([66.249.92.163]:36693 "EHLO
	ug-out-1516.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbYEAAzB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Apr 2008 20:55:01 -0400
Received: by ug-out-1516.google.com with SMTP id n30so83594ugc.1
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 17:54:57 -0700 (PDT)
Received: by 10.150.11.9 with SMTP id 9mr59272ybk.7.1209603297533; Wed, 30 Apr 
	2008 17:54:57 -0700 (PDT)
In-Reply-To: <1c5969370804301732i282064f7r55858d54a6796791@mail.gmail.com>
X-IP: 68.27.222.166
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; 
	rv:1.9b4) Gecko/2008030317 Firefox/3.0b4,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80884>

Hi Matt, thanks for pointing that out.
Yes, it turns out that we are using different systems.  The original
commit (to Github.com) was on a Mac but then there were a few commits
made from a Windows based system (through Parallels).
It's only on a windows based system that Git will claim that files
need to be updated; this doesn't happen on a Mac.
Hope this helps someone figure out what's going on ..


On Apr 30, 5:32=A0pm, "Matt Graham" <mdg...@gmail.com> wrote:
> On Wed, Apr 30, 2008 at 7:12 PM, edpark <edp...@gmail.com> wrote:
> > This is really strange and I'm wondering if anyone here can help me
> > =A0out.
>
> > =A0I just cloned a remote repository and when I execute a 'git stat=
us'
> > =A0right after it says that some files need to be updated:
>
> > =A0utsd.txt: =A0 needs update
>
> > =A0If I just cloned a remote repo how did these files get modified?=
 =A0How
> > =A0can I make git realize that these files aren't modified?
> > =A0Further, if I clone to a different machine then the git on that
> > =A0machine doesn't indicate that any files were modified (??).
>
> What systems are you using? =A0Someone recently posted a probably
> unrelated issue when mixing macs and windows.http://article.gmane.org=
/gmane.comp.version-control.git/80548/match=3Dm...
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majord...@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
