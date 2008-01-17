From: "Paul Umbers" <paul.umbers@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Thu, 17 Jan 2008 13:13:56 -0700
Message-ID: <a5eb9c330801171213l2c06c4e4s718324f5b66f0db6@mail.gmail.com>
References: <20080114202932.GA25130@steel.home>
	 <20080116071832.GA2896@steel.home>
	 <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com>
	 <20080116183124.GA3181@steel.home>
	 <a5eb9c330801161048x4b5a88dcsebd7cf9754f72ba6@mail.gmail.com>
	 <20080116191737.GD3181@steel.home>
	 <a5eb9c330801161344i1da447c7sb447bf6274d408e8@mail.gmail.com>
	 <20080116234527.GA3499@steel.home>
	 <a5eb9c330801171037v333becc2lbc5873383d07a358@mail.gmail.com>
	 <alpine.LFD.1.00.0801171046040.14959@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 21:14:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFb87-0006qc-1e
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 21:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbYAQUN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 15:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbYAQUN6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 15:13:58 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:63006 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbYAQUN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 15:13:57 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1270437wah.23
        for <git@vger.kernel.org>; Thu, 17 Jan 2008 12:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=X5gCK3GbkG01bqZwOsVxxFiFqVMa+TlJF5vzAzMXN50=;
        b=Z273UVN7eXLNGPdBMzIBqzweKKwcSRc1OqsARfmqom5XBWZGK4oxGEi8ISDCTa75PLfezn1RwhDu/6YoqlgDcdJQJ0DRufpHoItm8APIdwqqvzKVL8qDp8+eTXsP8ySMw5NmlfTlyc9/GH3hhMXoQqvsVbT9tVjWHnE41ajGC4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WazdHlIMHVG05as7LqojLoZIgHh0cBau0LLvwz7Nqs65tWgz8q23DqOU2KqovtGo3IMRz7Yn6mcT3VKtE7TrosmDQrzPP8hipmP3rFKw11josXxW/hIcWJsyQVWDg/QIM+xfTeKwanh/WlLGm0Feb+ILoTHRpm5NMT1IaZ6G4JA=
Received: by 10.114.124.1 with SMTP id w1mr2852983wac.131.1200600836177;
        Thu, 17 Jan 2008 12:13:56 -0800 (PST)
Received: by 10.114.133.7 with HTTP; Thu, 17 Jan 2008 12:13:56 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801171046040.14959@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70915>

Quite possibly. We have Embassy Trust Suite and Symantec Endpoint
Security installed on all our work machines, while I use ClamWin at
home and don't have this problem. The symptoms would indicate that it
is an environmental difference and this is certainly a candidate.

I've disabled as many of the Symantec features as I can without
uninstalling it (which I don't have permissions to do), and I still
get the same problem. So, if it is Symantec then it's at a level
deeper than I can go. Not sure about the Embassy suite, I'll have a
play and see what I can find but it's tricky as the sysadmins here
don't like us developer-types playing with security settings on our
machines. Go figure.

I've also tried a complete (including registry keys) reinstall of
cygwin (as per Nicholas' email) and still have the problem. I'll try a
summary posting to the cygwin group as suggested to see if they know
of anything over there. If there's anything else I can do in the
meantime, please let me know. I'll be closing my eyes real tight and
hoping that next time I open them I have a Linux desktop in front of
me :-)

Thanks for all your help guys,
Paul

On Jan 17, 2008 11:51 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 17 Jan 2008, Paul Umbers wrote:
> >
> > Incidentally, I've tried this on two other machines at work with the
> > same results. The steps to reproduce are annoyingly simple: download
> > cygwin installer & execute (accept all defaults), select the packages
> > specified for the binary windows install on the git wiki, try to
> > create a git repository and add files. Frustrating - especially since
> > my desktop at my last job worked just fine.
>
> Is there perhaps some odd virus scanner or something that interferes with
> filesystem operations? It sounds like you have consistent problems on
> *some* machines, but others cannot reproduce them, which makes me wonder
> if there is some setup issue. Maybe your company machines have some DLL or
> something that interferes subtly with cygwin.
>
> (Eg there might be another cygwin install hidden off somewhere?)
>
> The "virus scanner" thing was just a random thought, but under windows
> it's not unheard of to have things that intercept filesystem accesses for
> things like that. Virus scanners, "security features", rootkits from Sony
> or other sources of trouble etc - you name it.
>
> That kind of environmental difference would explain why you didn't see it
> on another machine, and why others seem to not be able to reproduce it
> either.
>
>                         Linus
>



-- 
Computer Science is no more about computers than astronomy is about telescopes.
--- Edsger W. Dijkstra

Paul Umbers MSc MBCS MIAP
paul.umbers@gmail.com
