From: Ismail Donmez <ismail@uludag.org.tr>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 23:29:52 +0200
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
Message-ID: <200511182329.52368.ismail@uludag.org.tr>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182245.01713.ismail@uludag.org.tr> <7v7jb5hcm2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 18 23:29:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdDoo-000260-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 22:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVKRVac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 16:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVKRVac
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 16:30:32 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:60895 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751001AbVKRVab (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 16:30:31 -0500
Received: from dsl.dynamic8599158195.ttnet.net.tr (unknown [85.99.158.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id E86EDAB1F1
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 23:30:24 +0200 (EET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <7v7jb5hcm2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12272>

On Friday 18 November 2005 23:25, you wrote:
> Ismail Donmez <ismail@uludag.org.tr> writes:
> >> I agree that UTF-8 is a good idea, but that's a totally different
> >> argument.
> >
> > Maybe you could officially require all commit messages to be UTF-8 then
> > the problem would be just solved for future commits at least. Until then
> > it should be workarounded in gitweb I guess.
>
> No, that's something I will *not* do.
>
> Linus is right --- he is always right but he is slightly more
> right than he usually is in this particular case ;-).
>
> We allow any 8-bit data in commit log messages.  We even make it
> easier to use utf-8 than other encodings, and we encourage use
> of utf-8 for obvious reasons.  But we do not go further than
> that.  Any patch to change commit-tree.c to reject binary data
> in a commit log message that utf-8 validator chokes at *will* be
> rejected.
>
> Go back to the list archive.  Dig out messages on this topic.
> Summarize the ones that say why we encourage utf-8 in textual
> commit log messages, submit a patch to add that to
> Documentation/howto/ or perhaps Documentation/tutorial.txt, to
> further encourage people to use utf-8.  Just do not forbid non
> utf-8 text nor binary data in general.

Your produced XML is NOT valid then. You put encoding=utf-8 and then put 
latin-1 encoded data in it. You SHOULD NOT do that. Either put latin-1 as 
encoding in the RSS because you say its the way data should be else encode 
non-utf stuff to be utf-8.

Regards,
ismail
