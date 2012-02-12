From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt method for querying users
Date: Sun, 12 Feb 2012 17:11:44 +0100
Message-ID: <201202121711.45920.jnareb@gmail.com>
References: <4EF9ED58.8080205@tu-clausthal.de> <20120103184022.GA20926@sigill.intra.peff.net> <4F37E2B0.9060007@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Sun Feb 12 17:12:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwc2I-0003Pr-Bb
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 17:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab2BLQLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 11:11:50 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35798 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab2BLQLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 11:11:49 -0500
Received: by eaah12 with SMTP id h12so1506243eaa.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 08:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=u47ZMC5teNdsW+Uw2MsE3TQ6lpwoebCqGtBpxjErrpE=;
        b=ZfEgED6oZltLWLZceEsoyFgjkhn7jtqct6RZMB20R7sEpcH47klXoQa/RzfG77nWhF
         bawEWGTQwVBbKQm2cuozP9Ail8MA0jvIzyaxtEq0o0PiwVZirXRhkd2NSKCTtACH3xrP
         l35mfZFJBP5pw5dq+QIthuw/5NZEiDJH7F37s=
Received: by 10.213.33.7 with SMTP id f7mr1462054ebd.121.1329063107976;
        Sun, 12 Feb 2012 08:11:47 -0800 (PST)
Received: from [192.168.1.13] (abwh127.neoplus.adsl.tpnet.pl. [83.8.231.127])
        by mx.google.com with ESMTPS id e12sm50202545eea.5.2012.02.12.08.11.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 12 Feb 2012 08:11:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4F37E2B0.9060007@tu-clausthal.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190577>

Sven Strickroth wrote:
> Am 03.01.2012 19:40 schrieb Jeff King:

> > There is one difference between how git and ssh use the ASKPASS
> > variable. In git, we try it _first_, and fall back to asking on the
> > terminal.  For ssh, they first try the terminal, and fall back to
> > askpass only when the terminal cannot be opened.
> 
> I checked out subversion (svn co
> http://svn.apache.org/repos/asf/subversion/trunk subversion) and
> performed a "grep ASKPASS * -R": Only match in
> "contrib\client-side\emacs\psvn.el". So I doubt if subversion really
> supports SSH_ASKPASS.

Doesn't Subversion use SSH directly?  If it is so, the question is
about how SSH itself supports SSH_ASKPASS.

-- 
Jakub Narebski
Poland
