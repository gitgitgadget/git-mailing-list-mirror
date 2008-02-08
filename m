From: Mike Hommey <mh@glandium.org>
Subject: Re: Why does git depend on two versions of libcrypto?
Date: Fri, 8 Feb 2008 11:03:47 +0100
Organization: glandium.org
Message-ID: <20080208100346.GA20601@glandium.org>
References: <20080208104612.724d82ce@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Feb 08 11:04:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNQ5p-0004k4-AK
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 11:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756AbYBHKDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 05:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932752AbYBHKDv
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 05:03:51 -0500
Received: from smtp28.orange.fr ([80.12.242.100]:47011 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932422AbYBHKDu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 05:03:50 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2812.orange.fr (SMTP Server) with ESMTP id A52077000853
	for <git@vger.kernel.org>; Fri,  8 Feb 2008 11:03:48 +0100 (CET)
Received: from vaio.glandium.org (APuteaux-153-1-42-109.w82-124.abo.wanadoo.fr [82.124.6.109])
	by mwinf2812.orange.fr (SMTP Server) with ESMTP id 62E1C70000C7;
	Fri,  8 Feb 2008 11:03:48 +0100 (CET)
X-ME-UUID: 20080208100348405.62E1C70000C7@mwinf2812.orange.fr
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1JNQ5D-0005mj-Mp; Fri, 08 Feb 2008 11:03:47 +0100
Content-Disposition: inline
In-Reply-To: <20080208104612.724d82ce@pc09.procura.nl>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73065>

On Fri, Feb 08, 2008 at 10:46:12AM +0100, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> Don't know if this is a git question or a OpenSUSE question, but why does git
> depend on libcrypto.so.6 and not on libcrypto.so.0.9.8, like the rest does?
> 
> Isn't that asking for trouble?
> In my case, they're both linked to the same lib, so I guess I'm safe.
(...)
> ldd[03] on /usr/lib64/libcrypto.so.0.9.8  <= /usr/lib64/libcurl.so.3.0.0
> ldd[02] on /usr/lib64/libcrypto.so.6      <= /usr/bin/git

The answer is here. git was obviously built against a different version
of OpenSSL than curl. This is an OpenSUSE problem.

Mike
