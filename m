From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/5] Fix rebase with file move when diff.renames =
 copies
Date: Sat, 24 Jul 2010 16:59:10 -0500
Message-ID: <20100724215910.GA5780@burratino>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
 <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net>
 <20100722075133.GA9292@burratino>
 <681325.9577.qm@web30002.mail.mud.yahoo.com>
 <20100723170103.GA2507@burratino>
 <624201.94995.qm@web30003.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sun Jul 25 00:00:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocmla-0006Jl-87
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 00:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab0GXWAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 18:00:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42739 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab0GXWAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 18:00:15 -0400
Received: by iwn7 with SMTP id 7so1486588iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NwWmE3yYy9fq6yWCjcZmFeZu+wy55abLOyYq0zvKA5I=;
        b=mMx0C2rAbIicPUv1nJ1TB2QgxE3xrUvV8TEZ51ke0GGF/uQt4/soaLZOKhzai0b1GD
         ON4Pu6rlZaXpHzI77HFelrqhnEcJga83JjBHG6I50+CdTadAP5iZJZKqDSiybgR7zShf
         VGNG2ypEe+0lUw/x31yD1DcCrYU7DLzuEKHW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q0pMAd4xu9fRS0F1htec6JOZiHk/F5/dSuDXl/BhTKKG8JekXtIYLg0wI0Jh41CS0B
         lcdMXO+NvtFB9WcJ7ywsUjLSvyN8sQvZTJ2nqhMiNLtGBOAlnjoMaVPHrTRujCjnCcHV
         4kYW8Fpi3ieAazhYM9zBvznhiJlJ2yOMuAfM4=
Received: by 10.231.14.200 with SMTP id h8mr5330955iba.188.1280008814792;
        Sat, 24 Jul 2010 15:00:14 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm1766408ibh.10.2010.07.24.15.00.13
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 15:00:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <624201.94995.qm@web30003.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151679>

David D. Kilzer wrote:
> On Fri, July 23, 2010 at 10:01:03 AM, Jonathan Nieder wrote:

>> Something like this series would fix both.  Please feel free to pick
>> it up and take it in whatever direction you like.
>
> Is this comment to me or Junio?  As a part-time contributor, I'm not sure what 
> my options are here.  :)

It is to the world at large, or more precisely, anyone who is interested.

I only meant that I am not planning to keep track of what happens to
those patches in the future.  Ideally someone else (maybe you ;-))
will take care of pinging if a patch gets forgotten or improving the
patches if some obvious change suggests itself.

Thanks for the initial ping, by the way.
