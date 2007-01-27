From: "Chris Lee" <clee@kde.org>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 11:36:50 -0800
Message-ID: <204011cb0701271136m655815f6o1501de2bf699b362@mail.gmail.com>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	 <20070127080126.GC9966@spearce.org>
	 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	 <45BB9C8B.8020907@fs.ei.tum.de>
	 <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 20:36:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAtM8-0006dg-JO
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 20:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbXA0Tgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 14:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbXA0Tgw
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 14:36:52 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:5102 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbXA0Tgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 14:36:51 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1223512wxd
        for <git@vger.kernel.org>; Sat, 27 Jan 2007 11:36:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=nQ4ixdWrxf2E+f2Qf7k83h+fxXe6kfzf8GxPLcEWb9o5K1eOROPi3yal0LetYMOvmUUkTqNC8xkcxg/bMARlXk6yhv1uFlSbR2+dhs+hmsSxokb5vWTAXEtFV7ThxS1VYap7ko9w5V2MxQvomBe/3B+7AtVJpRi7bZDywFFYor8=
Received: by 10.90.75.10 with SMTP id x10mr5031168aga.1169926610115;
        Sat, 27 Jan 2007 11:36:50 -0800 (PST)
Received: by 10.90.81.16 with HTTP; Sat, 27 Jan 2007 11:36:50 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: 356fee971eff4cb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37990>

On 1/27/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Do you have the converted repo somewhere to be cloned for? It's going to
> be a lot more interesting for scalability testing than anything else.

I don't have access to any servers that I could drop a 3GB packfile
onto and expect them to serve it. And I don't have a connection at
home that I could use to upload the 3GB pack from quickly - it would
take days, at least. If anybody wants to hook me up with a hosting
provider or a machine that just the git devs can access, I'd be
willing to tie up my upstream bandwidth for a few days so you all can
have access to it.

> The thing is, one of the reasons the git object database is small is that
> it compresses really well, and I suspect that for the KDE repo, what
> you're seeing is really a combination of:
>
>  - the KDE people were idiots in the first place to make it into one big
>    repo

No argument from me about this one. The only defense I can really
think of is that, in KDE, we *have* moved entire applications and
libraries around between modules, and it is really nice to be able to
have the full history for them.

> So please point to a kde conversion archive to play with (maybe you have,
> I missed it).

I can provide you with instructions on how to reconstruct one, but
you'll have to rsync over about 38GB of KDE's Subversion archive to do
it. (Not fun.) If someone else wants to give me a dumping ground where
I can upload my 3GB converted repo, I'd be happy to start pushing it.

Also, please note, the 3GB packed repo is only about 2/3 of the full
KDE repo - I cut off the import at revision 409202, because that was
when the KDE svn admins decided to move a bunch of modules from
/trunk/ to /trunk/KDE/ and it screws up everything. So a *full* KDE
history import would definitely be more than 4GB, packed.

-clee
