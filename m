From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Sat, 25 Oct 2008 11:10:24 +0200
Message-ID: <200810251110.25704.jnareb@gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <200810242230.49238.jnareb@gmail.com> <cb7bb73a0810250048q7ad8595bt565de05ec2ec37cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "David Lang" <david@lang.hm>, "Junio C Hamano" <gitster@pobox.com>,
	"Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 11:08:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktf8P-0003Bj-On
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 11:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbYJYJHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 05:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbYJYJHO
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 05:07:14 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:1677 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYJYJHM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 05:07:12 -0400
Received: by ey-out-2122.google.com with SMTP id 6so470529eyi.37
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 02:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RPl5LM3UUIMkMRgmBlpBePiI4ZJTdL8XytAvFdKS5Jc=;
        b=wPyTnl+Hg1GhsGFG5II2VML0CIkUL5d9A3XYS37AmBTON6MEn3IQDW4TwzM1ZGBowU
         8aqaqSTRgdcxHW+YxUTq47QRsSjnyhYrF5TkqRZV2eNBLgCulNNQBWiT0Q1vnMLugwCe
         OnMUWU36g4r257SRdNq8MtRmoL84vCYIfIa7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=N5OHyqQ8fl+nJZsS3EOnquvRpE1D0t4oa7PMQz0QmNrpnLUpsnpUiqVQYiOtmpbTT9
         l3ybzV4cbPqI7LKo/u7eWo+lny2IUHX7XeeqgisxHEXJMooEEDda5ll8fsaJPk/uJ+Uw
         i+Ss38ZYYYBDkU+3BHybW+n3o1MqsVBdLwtjU=
Received: by 10.210.92.8 with SMTP id p8mr3559302ebb.12.1224925631280;
        Sat, 25 Oct 2008 02:07:11 -0700 (PDT)
Received: from ?192.168.1.11? (abwo68.neoplus.adsl.tpnet.pl [83.8.238.68])
        by mx.google.com with ESMTPS id 23sm1775899eya.7.2008.10.25.02.07.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Oct 2008 02:07:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810250048q7ad8595bt565de05ec2ec37cb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99099>

On Sat, 25 Oct 2008, Giuseppe Bilotta wrote:
> On Fri, Oct 24, 2008 at 10:30 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > Well, with all zit repositories in '.zit/' directory (similar to RCS/)
> > you could have point core.excludesfile to _common_ '.zit/excludes';
> > the pattern doesn't change from zit repository to zit repository?
> >
> > You could even use per-user ~/.zitignore (I'm not sure if git expands
> > '~' in paths; there was some patch for it, but was it accepted?) [...]
[...]
 
> The user .zitignore file is probably the best approach: we can create
> it ourselves (usually), and even if Git doesn't expand the pathname
> itself, we can just use an absolute path. I'll go that way.

First, absolute path to ~/.zitignore is a bit fragile: what if layout
of home directories for users change, for example because of increasing
number of users some fan-out is required (/home/nick -> /home/2/nick)?
Second, ~/.zitignore looks like something that user can change; if
you install zit, it can install libexec/zitignore somewhere... or just
use ./zit/excludes (with 'do not edit' comment perhaps...).

-- 
Jakub Narebski
Poland
