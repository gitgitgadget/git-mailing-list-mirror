From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: [PATCH] Beautifulise git-show output
Date: Wed, 5 Jul 2006 00:59:06 +0200
Message-ID: <4fb292fa0607041559t5dad90e3h5e764348a8b4c562@mail.gmail.com>
References: <11520525682686-git-send-email-beber.mailing@gmail.com>
	 <7vejx1f0fz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 00:59:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxtrL-0005BP-IG
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 00:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWGDW7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 18:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWGDW7I
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 18:59:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:50135 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932356AbWGDW7H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 18:59:07 -0400
Received: by nf-out-0910.google.com with SMTP id y38so1081477nfb
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 15:59:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=erhdu1lecO7hHlI0YIJIBMDdOaRqYy/cOELCnjc35p6Y/YIGPJS1lbFOKBAG/k6P+J4lZXklvaqZVIOFAe9yQbmkAh8Gb+7+deffh0kW5NaHuU4sMVjz1DzVBlCc28yTQ8N68E93rbnMCj8LVNgPoTvoohzYicTpvuEX09gG4mw=
Received: by 10.49.31.14 with SMTP id i14mr3693507nfj;
        Tue, 04 Jul 2006 15:59:06 -0700 (PDT)
Received: by 10.48.48.6 with HTTP; Tue, 4 Jul 2006 15:59:06 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vejx1f0fz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23327>

On 7/5/06, Junio C Hamano <junkio@cox.net> wrote:
> Why?
>
> A patch like this needs to be justified with a bit more
> explanation; the word "beautiful" is subjective.

Arg, git-send-email seems to made a bad job after git-format-patch, sorry.

So explanation don't go here. So here it is :
Git-show actually show (for example) :

    Makefile: Create Makefile for Beamer theme
    rules are : install & uninstall (be careful on this one)

    Also, I hacked presentation oral's Makefile to check them presence or not
---

 docs/presentation_oral/Makefile        |    5 +-
 docs/presentation_oral/themes/Makefile |   91 ++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletions(-)
 create mode 100644 docs/presentation_oral/themes/Makefile

I would like to have a newline after commit mesage too as there is one
before diff-stat.

-- 
# Beber : beber@gna.org
# IM : beber@jabber.fr
# http://guybrush.ath.cx, irc://irc.freenode.net/#{e.fr,gentoofr}
