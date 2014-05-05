From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [msysGit] Re: [PATCH 10/12] MINGW: compat/poll/poll.c: undef
	NOGDI
Date: Mon, 5 May 2014 14:15:15 +0200
Organization: <)><
Message-ID: <20140505121515.GA21638@camelia.ucw.cz>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org> <1398762726-22825-11-git-send-email-marat@slonopotamus.org> <20140430114125.GA23046@camelia.ucw.cz> <20140503070050.GA8580@seldon> <20140504185244.GA17183@camelia.ucw.cz> <20140504205552.GA15590@seldon> <20140505073547.GB20599@camelia.ucw.cz> <53673e7b65c4d_78fd70f2ec46@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marat Radchenko <marat@slonopotamus.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:58:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhyw-0005Yp-30
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632AbaEEMPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 08:15:18 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36074 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756617AbaEEMPR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 08:15:17 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 213071C009E;
	Mon,  5 May 2014 14:15:16 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s45CFFMx021646;
	Mon, 5 May 2014 14:15:15 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s45CFFBp021645;
	Mon, 5 May 2014 14:15:15 +0200
Content-Disposition: inline
In-Reply-To: <53673e7b65c4d_78fd70f2ec46@nysa.notmuch>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248162>

On Mon, May 05, 2014 at 02:32:11AM -0500, Felipe Contreras wrote:
> Stepan Kasal wrote:
> > +ifneq ($(uname_M),x86_64)
> > +	# MinGW-W64 < x.y headers do not provide MsgWaitForMultipleObjects with NOGDI
> 
> MinGW-w64 != x86_64; it provides a i686 compiler as well.

thanks for correcting me.  The diff was just a quick sketch.
Every workaround should say what bug is working around, otherwise it
is destined to become a superstition in the future.

Stepan
