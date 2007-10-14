From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 14 Oct 2007 11:20:30 +0100
Message-ID: <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
	 <Pine.LNX.4.64.0710130130380.25221@racer.site>
	 <853awepyz6.fsf@lola.goethe.zz> <20071013202713.GA2467@fieldses.org>
	 <Pine.LNX.4.64.0710140135020.25221@racer.site>
	 <alpine.LFD.0.999.0710131810550.6887@woody.linux-foundation.org>
	 <20071014014445.GN27899@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 12:20:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih0aS-0001mz-HF
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 12:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbXJNKUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 06:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbXJNKUc
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 06:20:32 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:39344 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbXJNKUb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 06:20:31 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1174858rvb
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Urr9w88Fa5l3g76QkV4/zV2n1jB3d5joz/7DaQfF4qg=;
        b=InTr/fPmhJWpsoc6B+PEpt6IhsMY6H5jRZxU+gMS0ilUwqLkfmn0oXXIBBsCT+WdQFzJ5tsGjsweNMv1DsZrEVHo8LgAtt1ldn85uGHBhX8EtIRjrInwqZ+VnRYkVbC5p6nffnyekp4bwN+VRzr67WB3ELEgcM5FQMRpCbV6ykw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cdauI040G9P69lraX7HarSTBkKlJz5vX2sYfjvl5lvBIVKOTXdZb9t7G+dJ67KpxhiLq5+mMDsSaNQurxv2/dQ2lRru+FECWQ7tegmKhf88uRR1g3hem1shITek0UqtXvZ6VS6K65BazHnJCsiabat+/6n13q6Z25KTf2ZbdaPs=
Received: by 10.141.211.13 with SMTP id n13mr2262554rvq.1192357230432;
        Sun, 14 Oct 2007 03:20:30 -0700 (PDT)
Received: by 10.141.23.10 with HTTP; Sun, 14 Oct 2007 03:20:30 -0700 (PDT)
In-Reply-To: <20071014014445.GN27899@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60824>

On 14/10/2007, Shawn O. Pearce <spearce@spearce.org> wrote:
> But just saying "MY GOD FIX THE UI" is not a wishlist item (yes,
> that was a real survey answer).  It provides the community no
> chance to understand what parts of the UI we need to work on, and
> what parts the end-user is OK with or just hasn't even tried to use.

My interpretation of that answer is that your average user
(specifically Windows user) is more focused on a graphical interface,
and will mean GUI when they say UI.

The core plumbing in git is solid. The porcelain, with the 1.5 series,
makes git simpler to use from the command line. Now, the GUI available
for git is seriously lacking.

If you look at the GUI tools available for CVS, SVN, Perforce and
others, these offer you the complete functionality of those tools from
within them. They provide command line tools for those that need them,
but also come with a GUI application that allows the user to manage
their files within the source control system they are using (e.g.
WinCVS and P4V), shell integration (e.g. TortoiseCVS/SVN), IDE
integration and others.

At the moment, git has a good timeline view of commits through the
GUI, but have found the mingw version to be slow in places (I can't
remember when, but was likely before some performance improvements in
that area were made) and haven't tried out the Linux version yet. This
is a good starting point to build on, but to be more useful it needs
to extend to all of git's functionality.

- Reece
