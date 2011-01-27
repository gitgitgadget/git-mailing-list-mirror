From: Thomas Hauk <tom@shaggyfrog.com>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Thu, 27 Jan 2011 15:22:09 -0800
Message-ID: <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com> <AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 00:28:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PibGs-0003Go-8l
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 00:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab1A0X2w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jan 2011 18:28:52 -0500
Received: from smtpauth21.prod.mesa1.secureserver.net ([64.202.165.38]:44905
	"HELO smtpauth21.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753750Ab1A0X2v convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 18:28:51 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2011 18:28:51 EST
Received: (qmail 17489 invoked from network); 27 Jan 2011 23:22:11 -0000
Received: from unknown (216.19.178.88)
  by smtpauth21.prod.mesa1.secureserver.net (64.202.165.38) with ESMTP; 27 Jan 2011 23:22:11 -0000
In-Reply-To: <AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165596>

On Jan 27, 2011, at 12:53 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> You'll be much better off if you have project-specific repositories.

But how often do you have a project that has no external or internal de=
pendencies on any other packages or libraries? Any project I've ever do=
ne, big or small, has relied on some existing codebase. Imagine a proje=
ct that uses liba and libb, which both reference libc. To use Git, I'd =
have to have copies of libc existing in three repositories, and copies =
of liba and lib in two repositories each. What a nightmare... and that'=
s only a trivial hypothetical example.

I understand that Git was designed with a specific feature set in mind =
-- to manage Linux kernel development -- and as such isn't going to sat=
isfy everyone. But I'm having trouble figuring out how to integrate it =
as the SCM in my projects, which aren't organized any differently than =
any other projects I've seen. Surely I can't be the only person with th=
ese difficulties? Git just doesn't seem to scale when it comes to compo=
nentized projects. Do other distributed VCSs work better than Git in th=
is respect?

I'm really trying to get on the Git bandwagon, here.

--
Thomas Hauk
Shaggy Frog Software
www.shaggyfrog.com
