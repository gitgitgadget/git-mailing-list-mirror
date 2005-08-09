From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cannot install git RPM
Date: Tue, 09 Aug 2005 05:51:02 -0700
Message-ID: <7v3bpjxoi1.fsf@assigned-by-dhcp.cox.net>
References: <20050809104040.B9C61352B36@atlas.denx.de>
	<20050809110705.6B1FF352B36@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 14:52:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2TZg-0000h2-7b
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 14:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVHIMvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 08:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVHIMvF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 08:51:05 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:6121 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932520AbVHIMvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 08:51:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050809125103.VUHQ12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 Aug 2005 08:51:03 -0400
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050809110705.6B1FF352B36@atlas.denx.de> (Wolfgang Denk's
	message of "Tue, 09 Aug 2005 13:07:05 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wolfgang Denk <wd@denx.de> writes:

> A simple fix is of course:
>
> -> diff -u git-core.spec.in.ORIG git-core.spec.in
> --- git-core.spec.in.ORIG       2005-08-09 10:26:50.845877000 +0200
> +++ git-core.spec.in    2005-08-09 12:42:06.872310918 +0200
> @@ -40,6 +40,7 @@
>  %{!?_without_docs: %doc Documentation/*.html }
>  %{!?_without_docs: %{_mandir}/man1/*.1.gz}
>  %{!?_without_docs: %{_mandir}/man7/*.7.gz}
> +/usr/share/git-core/templates/*

Something like that using %{_datadir} is in the RC branch.

> But the resulting RPM cannot be installed either,  at  least  not  in
> standard Fedora Core 2/3/4 installations:
> ...
> Is there at least some  documentation  which  external  packages  are
> needed, and where to find these?

Patches welcome.  Sorry but I need a lot of help when it comes
to binary packaging.
