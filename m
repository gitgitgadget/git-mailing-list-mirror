From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: jgit and ignore
Date: Sun, 01 Mar 2009 15:58:59 +0100
Message-ID: <49AAA2B3.40808@gmail.com>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com>	 <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl> <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com> <49AA884D.1050806@pelagic.nl> <49AA8ECD.4090302@gmail.com> <49AA91F0.7050008@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sun Mar 01 16:03:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdnCN-00089F-2N
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 16:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbZCAO7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 09:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754931AbZCAO7L
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 09:59:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:20414 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705AbZCAO7K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 09:59:10 -0500
Received: by fg-out-1718.google.com with SMTP id 16so840172fgg.17
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=xuGRrXHs5S1EGqAWv+6MCp3DwqjIBzxdQ2mIgv3W2Zo=;
        b=f7CrjLF7b2BrXNy1GfqZlcFFQBe/W0FRfLHUSUrk1y6kOh906yq6GJx8UJ9vTE5jpb
         SosOi+Lb9I66ylWN4VFrrYZdpTTxNW3jxCvLMvoPQmA684foHeALPxqj8ue+0NrZW69i
         pyBcUuGIIcLanXhxcY5qdm2zrHuAS7akjSQwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=m31WYfyhDqh6oCU2qzNG1/ljFcYPXDIudubOYEidswm0xYVGmNIJGfpRqgLbFb0gPD
         XmmdNTsfM5L/boSs2dEaIKeC5RmYzSZnnTSdfrgzy1H6OagUIPDrjg822AQNaEBSPqoL
         NoUg+7Gqmvk5aY1sij7hdgIB/IhRP9oONMzeU=
Received: by 10.86.72.15 with SMTP id u15mr5738309fga.8.1235919546892;
        Sun, 01 Mar 2009 06:59:06 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id e20sm4761681fga.36.2009.03.01.06.59.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 01 Mar 2009 06:59:06 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <49AA91F0.7050008@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111849>

=46erry Huberts (Pelagic) wrote:
> Tor Arne Vestb=F8 wrote:
>> In my opinion, EGit should default to using Eclipse's built in ignor=
es,
>> but then detect the presence of a global core.excludesfile, in which
>> case it would notify the user ("I see you have a core.excludesfile")=
 and
>> let the user switch to using that one instead.

[snip]

=46irst of all, I do appreciate you working on the ignore feature :)

> I do not agree with your propasal however.
> We then would have different behaviour between how 'git' behaves with=
in
> Eclipse (by means of the plugin) and how 'git' behaves within the
> command line. That alone can cause much more confusion.

I see what you mean, and I agree that in general the command line git
porcelain and the Eclipse git porcelain should work in similar ways.

But, with that said, I think of EGit as a standalone Eclipse-plugin
implementation of the git porcelain -- not just a wrapper around the
command line porcelain.

To me that means that EGit should focus just as much on integrating wit=
h
Eclipse properly as it does on keeping command line porcelain
interoperability.

The core.excludesfile is one such case, and I think my proposal is a
good compromise.

> Your proposal can also be implemented differently by (for example)
> building a UI that allows the user to edit the global ignore file.

That would be going out of scope of Eclipse as a framework, and also
does not solve the problem for those users who have a list of global
team ignores, and expect the Git plugin to just work with those ignores=
=2E

> The Eclipse global team ignores simply are too broad: think of the
> situation where I also have non-git project (like svn) in my workspac=
e.

Not sure I understand? Isn't that exactly why you would have Eclipse's
global ignores specified in one place -- so that they could be shared
between version control systems instead of replicated in each repo?

Let' say you have a CVS project, a SVN project, and a Git project in
your workspace. The CVS and SVN projects would pick up ".bak" as an
ignore pattern from your team ignores, but the Git project would not.

To make the Git project pick it up, you would have to either add it
(repatedly for more than one project) to the .gitignore of that project=
,
or open an editor outside of Eclipse to edit your ~/.gitconfig.

Either ways seem redundant and awkward to me.

Tor Arne
