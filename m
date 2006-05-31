From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: t9001 fails because Net::SMTP is missing
Date: Tue, 30 May 2006 22:07:29 -0400
Message-ID: <118833cc0605301907i152fc0b0s6788a11ad05e7f10@mail.gmail.com>
References: <Pine.LNX.4.63.0605302125310.11586@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v8xojyqu3.fsf@assigned-by-dhcp.cox.net>
	 <7v4pz7yqpd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 31 04:07:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlG7a-0007A1-2P
	for gcvg-git@gmane.org; Wed, 31 May 2006 04:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWEaCHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 22:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWEaCHc
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 22:07:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:43558 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751139AbWEaCHb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 22:07:31 -0400
Received: by nf-out-0910.google.com with SMTP id p46so75860nfa
        for <git@vger.kernel.org>; Tue, 30 May 2006 19:07:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iDmZCp0YIfSsGxDb5+3y+0SFh/3BKZ35MLXUew4C2D3t0IMhuYD4GmSknZSI6ktFZQk0HarkbchARYBcbdQCIg7ZP+kdw4vfSd44rLp6ZwLkjeRgXmej//BAoF22h7sBMEPixAooaoJ6a/B1fpmZwoj/PQ9olnoYHWZDxQOzrzE=
Received: by 10.48.235.15 with SMTP id i15mr282290nfh;
        Tue, 30 May 2006 19:07:29 -0700 (PDT)
Received: by 10.67.15.12 with HTTP; Tue, 30 May 2006 19:07:29 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v4pz7yqpd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21053>

You just need more perl magic...  Try this.

#!/usr/local/perl -w

eval 'use strict';
print "Hmm [$@]\n";

eval 'use Oink';
print "Hmm [$@]\n";
