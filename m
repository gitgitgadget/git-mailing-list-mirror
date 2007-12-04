From: Jakub Narebski <jnareb@gmail.com>
Subject: msysGit on FAT32 (was: What's cooking in git.git (topics))
Date: Tue, 04 Dec 2007 02:08:28 -0800 (PST)
Message-ID: <m3hciyvklt.fsf_-_@roke.D-201>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
	<7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
	<47552084.3070601@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 04 11:08:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzUhx-0006Pp-Kz
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 11:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbXLDKIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 05:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbXLDKIe
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 05:08:34 -0500
Received: from hu-out-0506.google.com ([72.14.214.233]:55160 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbXLDKId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 05:08:33 -0500
Received: by hu-out-0506.google.com with SMTP id 19so3526166hue
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 02:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=1b2SZbElMcPNbBHdg5cJtg06N6GVZ0w/PPDfXaRWlJE=;
        b=Q9b7fGlguxbMvau7pn7aUoXQS39wypXUdyAtU46CsKb2dFwFnDEPjbKkLquVtu9+dHf4Ok0pugPABUuj12vqanNTjZncYcBm7N1nYWxbN09Z3Kt40TCDSeAZ/XucuxHIH2n+fhYwvlaZTUcwf/BBQH5mbFiUjM0JU6an/AX8sLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=pTiK+WHIMl9K+kuRooCHVd4yduOfjl5EnpxLQ36khSiLPVKj7yOdbqKH2HgG6RgUXtzxknDaC46LJQm3Oa40VgdetbL/dRa6N1JtmHSZmY0D/IwaAGAZd57NnLPBinQt0kYnMrpRIpIJCjgpbeQ6lVaSdQ8SsCM6XrD+1YKorno=
Received: by 10.78.122.16 with SMTP id u16mr3755391huc.1196762909973;
        Tue, 04 Dec 2007 02:08:29 -0800 (PST)
Received: from roke.D-201 ( [83.8.233.204])
        by mx.google.com with ESMTPS id g8sm163249muf.2007.12.04.02.08.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2007 02:08:28 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB4A8Po2015734;
	Tue, 4 Dec 2007 11:08:26 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB4A7rPK015727;
	Tue, 4 Dec 2007 11:07:53 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <47552084.3070601@viscovery.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67033>

Johannes Sixt <j.sixt@viscovery.net> writes:

> BTW, we do use hardlinks on Windows; even the MsysGit installer
> creates them (as long as the filesystem is NTFS). So, the fallout you
> are expecting/hoping for will not be in the first round of MinGW port
> patches. ;)

Would it be possible to add option to an installer to _not_ install
git-cmd form for builtins when installing on FAT28^W FAT32?

-- 
Jakub Narebski
ShadeHawk on #git
Poland
