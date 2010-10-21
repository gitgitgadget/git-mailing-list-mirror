From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [completion] Request: Include remote heads as push targets
Date: Thu, 21 Oct 2010 14:10:45 -0500
Message-ID: <20101021191045.GC11759@burratino>
References: <4CC05E4B.1010106@xiplink.com>
 <4CC06439.8040003@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 21:14:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90b1-0004fW-HY
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 21:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544Ab0JUTOe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 15:14:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64515 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab0JUTOd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 15:14:33 -0400
Received: by wyb33 with SMTP id 33so72656wyb.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+F1QMZelPJehOlJd2P0iHkxuXTaqnV+/a6sK6lJfOEY=;
        b=uejpooGf8iEdiYFkLblDiz1cTYjSXA3PovnBZpcuSaSl2+8Bv2KW+io0EH/9p1oXx7
         xgJac4k4T1IRV+9jCNGShfpyg4/kfv8kjURqVk00qIDod8R1EPmE2GSFweWBfOYQGk2U
         Yhl45gyqGgVpnKC2v14dH6/YvpXElZtLJ+YPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Hi7mGmsEEKcL+dpklqAJvco54Di3UJE2ZhEL9WdibrUUlNC/pfy3bMPBPNJc+8VghH
         xZe604LHnzCmJdcDcbLEcW+xw/2VDgWWn4sEIwvL0Z/MBgYQks0w+1CiBtYpaE+tqa2S
         dJME9ag+QGGit6AtR6sq54RPs6p6EOeERTw+4=
Received: by 10.227.148.2 with SMTP id n2mr1467268wbv.216.1287688471886;
        Thu, 21 Oct 2010 12:14:31 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id f14sm1636317wbe.8.2010.10.21.12.14.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 12:14:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CC06439.8040003@xiplink.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159544>

Marc Branchaud wrote:

> Hmmm, perhaps this is really a bug.

Compare:
http://thread.gmane.org/gmane.comp.version-control.git/159448

G=C3=A1bor, would it be possible to summarize the problem with a simple
test case that could be used to get help on this from the (upstream
or distro-specific) bash maintainers?
