From: Eugene Sajine <euguess@gmail.com>
Subject: Re: gitweb - bare repos integration - owner info in description file
Date: Mon, 12 Oct 2009 17:48:14 -0400
Message-ID: <76c5b8580910121448q67edd935wb189c8a6f9af2f2e@mail.gmail.com>
References: <76c5b8580910091350o5cd90d3dobe2a21c18fa56dfd@mail.gmail.com>
	 <m3ab00gr25.fsf@localhost.localdomain>
	 <76c5b8580910091532yd6c6fc4ib942a29c827f3a6c@mail.gmail.com>
	 <200910102045.13374.jnareb@gmail.com>
	 <alpine.DEB.1.00.0910120201350.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 00:08:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxT3g-0004FJ-3r
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 00:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933331AbZJLVsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933329AbZJLVsx
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:48:53 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:39360 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933314AbZJLVsv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:48:51 -0400
Received: by yxe26 with SMTP id 26so3821828yxe.4
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=TJ84xne8qpnLz052b9Y58vGeSRqjYBMBx+drNN+vmq0=;
        b=i9Br7yGfbgl6aOqyhZ/TiiORMgFXKLq1Z1RhHG9VlkLe++yTVwKeuMf5umgZmkZPTs
         7wx5njvGYg+1CcSYgprh4ktLo0AeFCgcNovM1IVjdSikijFUb18p3tpATosklmLWecg5
         h+ERnGw/tlQvRUcAwtGq+fDIVYeWk4qybcu2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nEmSKbxltWZ7fB5xqf/Ip0tKKTLghaF1lsJomhIMklFfnCxreH45hXtCST/myUX7ko
         Nrnf6mh/ZFOpTkkXr1B6NLsoZ8i3lXV9rQikx2sdm1YftjsxmxNJLBmSk10KazZXoXwv
         zcMJvQNxozj7DLYzm7E/v9//7bNNQxrrCPsQs=
Received: by 10.90.58.2 with SMTP id g2mr3851619aga.73.1255384094992; Mon, 12 
	Oct 2009 14:48:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910120201350.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130082>

Hi,

Somebody from development camp recently complained here that there is
no many end users "chiming" about issues in the mailing list. Well,
don't tell i didn't try;)

First I tried to use gitweb.url, gitweb.description and gitweb.owner
files and none of them worked... gitweb is unable to pickup the info
from those files.

Although it successfully interactively picks up info from description
and cloneurl files. I didn't find a substitution for gitweb.owner...

I might be sent to RTFM again, but i would like to bring an attention
to the fact that setting up bare repo with these simplest parameters
as well as setting up gitweb is a USABILITY NIGHTMARE for beginners. I
would even say more: while gitweb is very flexible and powerful, all
its flexibility and power is hidden behind unusable management
interface, which IMHO requires a lot of improvements . Rebuilding to
configure? Perl look-and-feel for configuration variables? I think
this is not the way to configure web applications no matter how smart
and flexible application should be. There are some problems with XML,
I don't care. Let's use simple property file. 1 property file! and let
gitweb read it. don;t like this solution, propose yours..

But leaving the emotions aside and once again -

On Sun, 11 Oct 2009, Jakub Narebski wrote:

>And this would be best left for a custom script creating repositories
>and their git hosting related configuration.  Such script of necessity
>would have to be site-specific, or at least contain site-specific
>configuration, like:
 >* whether to use gitweb.owner or filesystem uid + GECOS is enough
 >* whether to use gitweb.description or description file
 >* whether to use gitweb.url, cloneurl file, or let gitweb autogenerate
  >clone / fetch URL from base URL

I don't get it. I'm talking specifically about gitweb bundled into git
package by default. It was bundled as i understand to provide full
solution (I don't see any other reason). What the heck is wrong with
continuing to move in this direction? I'm not talking about to enforce
gitweb usage, but just simplify the setup and configuration of a tool
provided by default...
If the user chooses default solution, what is wrong with providing
some usable way of doing things?
Don't want to use git clone, fine. But, please, please save me from
rebuilding gitweb, creating manually those files and putting info
inside... It is 21st century or what?;)


 >* gitosis / gitlite configuration, if needed, or setup of public keys
  >for SSH authentication

Are they included into git bundle? I didn't see those tools there...

 >* project README.html file, if used
>etc.

Yes, I might be stubborn, but is just because i feel that i can
contribute into making git better, although I'm not a developer. And i
think usability is the thing which all beginners would thank you
for... i understand that this issue is not the end of the world and i
will finally overcome the burden, i will develop my script and stuff,
I hope somebody would support me in this:)

Thanks,
Eugene
