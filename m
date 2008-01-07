From: Paul Mackerras <paulus@samba.org>
Subject: Re: What's in git.git (stable frozen)
Date: Tue, 8 Jan 2008 08:58:29 +1100
Message-ID: <18306.41093.376963.228802@cargo.ozlabs.ibm.com>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
	<7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
	<7vfxxtu5ov.fsf@gitster.siamese.dyndns.org>
	<7v63y8ble8.fsf@gitster.siamese.dyndns.org>
	<7vhchq11n2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, stimming@tuhh.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 22:59:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBzzu-0001Ah-Q8
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbYAGV6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 16:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753125AbYAGV6k
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:58:40 -0500
Received: from ozlabs.org ([203.10.76.45]:40089 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034AbYAGV6j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 16:58:39 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id D7302DDF00; Tue,  8 Jan 2008 08:58:38 +1100 (EST)
In-Reply-To: <7vhchq11n2.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69818>

Junio C Hamano writes:

> Subsystem people (except Shawn, whose git-gui 0.9.1 is already
> in) are requested to tell me to pull from them, if they have
> accumulated changes that should be in the final release.  I am
> hoping that I can tag -rc3 in a few days (say by the end of my
> Wednesday).

I'd like you to do a pull from the gitk.git master branch, but it
looks to me like there will be a conflict on the Makefile.
Unfortunately the Makefile that Christian Stimming gave me along with
the i18n changes is quite different from the one you currently have in
the gitk-git subdirectory.  I'm not quite sure what to suggest since
it isn't clear to me exactly what Christian's Makefile (which doesn't
actually work) is trying to do.  I guess the best thing would be to
copy your Makefile over and then add the i18n stuff.

Apart from the i18n changes, there is one more commit (b039f0a6) that
improves the appearance slightly when running under Tk8.5.

Paul.
