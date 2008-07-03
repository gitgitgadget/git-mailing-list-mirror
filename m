From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: Non-inetd git-daemon hangs in syslog(3)/fclose(3) if --syslog --verbose accessing non-repositories
Date: Thu, 3 Jul 2008 15:52:26 +0200
Message-ID: <200807031552.26615.brian.foster@innova-card.com>
References: <200807031400.36315.brian.foster@innova-card.com> <alpine.DEB.1.00.0807031343440.9925@racer>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 03 15:54:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEPGC-0004eC-Lg
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 15:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbYGCNxN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 09:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756537AbYGCNxL
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 09:53:11 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:56873 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbYGCNxI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 09:53:08 -0400
Received: by yx-out-2324.google.com with SMTP id 8so244410yxm.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=BfqIPDZjTcBvIjAe3StPJEObG1yCsgf9ze6vh3JZoP4=;
        b=vD91W+L84mqpRLF7cwik0xltogehnS6YM9BnO5Wm+Ux2MIhQdHZPJidW0H+iR3dI5V
         xouaAnoFCZCBKN/ZJcVa6Biqj2v71WJfyU1rhiAihUp+/MrLYbTPRgNNfYwcEZ4dIiVY
         lbpz9H/9dEclpmnx9c6NaKul/DQInuy0qeZK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=EA2T0ncXJo12LAbUW2BTyMiztBCiIw69Y6p8pmazRIsFHkV8H6uPYJ/mtIUC+bQ8jj
         aDF0t/H9ytCNQ0AQubuKt59Ue+SGgr/ty9C89oOA4YqbNXY1ZyVZxs/Ty1RXoEwrZEj+
         4CYWEToYN8KZkfuarrQgZo9GRTpCPOvPYKAZw=
Received: by 10.114.121.1 with SMTP id t1mr372880wac.55.1215093184305;
        Thu, 03 Jul 2008 06:53:04 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id 3sm172992fge.3.2008.07.03.06.52.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jul 2008 06:53:02 -0700 (PDT)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <alpine.DEB.1.00.0807031343440.9925@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87291>

On Thursday 03 July 2008 Johannes Schindelin wrote:
> On Thu, 3 Jul 2008, Brian Foster wrote:
> >[... describes that git-daemon -v syslog()s in a signal handler,
> >  which is unsupported ...]
>=20
> I reported this bug earlier [ ... ]

 Ah, yes, I've (now) found the (long!) thread,
 about log-rotation (which, as you observe, is
 not the problem).  Sorry for the duplication.

cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
