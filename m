From: Alex Davidson <descenterace@hotmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Sat, 26 Apr 2014 03:43:51 +0100
Message-ID: <BLU0-SMTP3741FBD4980A29338AC8BA8D1450@phx.gbl>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com>
	 <20140425231953.GB3855@sigill.intra.peff.net>
	 <535b0db7e5e31_ba2148d310f4@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 04:47:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdseG-0000h7-Ir
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 04:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbaDZCrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 22:47:19 -0400
Received: from blu0-omc3-s16.blu0.hotmail.com ([65.55.116.91]:5183 "EHLO
	blu0-omc3-s16.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751176AbaDZCrS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 22:47:18 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Apr 2014 22:47:18 EDT
Received: from BLU0-SMTP374 ([65.55.116.72]) by blu0-omc3-s16.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 25 Apr 2014 19:42:11 -0700
X-TMN: [SX6SgxXk3MRMALnej28v5AjQwoAZd+K7]
X-Originating-Email: [descenterace@hotmail.com]
Received: from [192.168.0.146] ([82.37.171.168]) by BLU0-SMTP374.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 25 Apr 2014 19:42:09 -0700
In-Reply-To: <535b0db7e5e31_ba2148d310f4@nysa.notmuch>
X-Mailer: Evolution 3.4.4-3 
X-OriginalArrivalTime: 26 Apr 2014 02:42:09.0379 (UTC) FILETIME=[1E9D6B30:01CF60F9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247142>

On Fri, 2014-04-25 at 20:36 -0500, Felipe Contreras wrote:
> Jeff King wrote:
> > If you are waiting on me, I do not have much else to say on this topic.
> > @{publish} as specified by Felipe is not useful to me, and I would
> > continue to pursue @{push} separately as "the remote-tracking branch of
> > where you would push to". I think there is room for both concepts.
> > 
> > As for the patches themselves, I have not reviewed them carefully, and
> > would prefer not to. As I mentioned before, though, I would prefer the
> > short "@{p}" not be taken for @{publish} until it has proven itself.
> 
> Presumably you want to save it for @{push}. While I'm not against to having
> just @{publish} for now, I'm farily certain most people would be using
> @{publish} and not @{push}, as that's what `git branch -v` would show, and it
> would be closely similar to @{upstream}. Therefore it would make sense to use
> @{p} for @{publish}

TL;DR: Presumably you want to grab it for @{publish} without evidence to
support a decision either way. 


The thing with shortened forms and abbreviations is that they assume a
mode of thought. Human communication assumes a lot of shared context,
hence the disconnect between code (explicit) and intent (often dependent
on context of conversation). Abbreviation is a form of compression using
context as an implied key.

Users who do not share your context will not find your abbreviation
intuitive. If a consensus context cannot be identified, abbreviation may
be interpreted as an attempt to impose a context. In other words, 'of
the many valid workflows enabled by git we obviously prefer this one
because we have provided more shortcuts for it'.

Attempts to impose context are not unreasonably perceived as political.

Saying that you are 'fairly certain' that most people would be using A
over B 'and therefore' we should support A smacks of political
manoeuvring rather than scientific experimentation.

The scientific approach is to provide both long options and record how
they are used, rather than gravitating towards an abbreviation of a
preferred option which may receive limited use.
