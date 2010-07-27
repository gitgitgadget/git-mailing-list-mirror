From: Jonathan Nieder <jrnieder@gmail.com>
Subject: git gui tree (Re: [BUG] git gui blame: Show History Context
 [still] broken since 29e5573d)
Date: Mon, 26 Jul 2010 20:09:11 -0500
Message-ID: <20100727010911.GA4041@burratino>
References: <vpqy6e4v1h0.fsf@bauges.imag.fr>
 <87sk3qrjk3.fsf@fox.patthoyts.tk>
 <7vtyo4a096.fsf@alter.siamese.dyndns.org>
 <vpqzkxkorzr.fsf@bauges.imag.fr>
 <20100722082310.GB13386@burratino>
 <87iq43wbz3.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, spearce@spearce.org,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Jul 27 03:10:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdYgn-0002KZ-QH
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 03:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374Ab0G0BK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 21:10:26 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54895 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab0G0BKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 21:10:25 -0400
Received: by gwb20 with SMTP id 20so304726gwb.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 18:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xh4yFI8Q5vDynWnL2Hn4BZNzKOvNGETfzq1TK+33P6g=;
        b=ERooPvRylF3Vpglg962jDuG9bBcD7b7k2LeVcSxYsrE2S5xpyh6IzMdh22yWUWXmAE
         zmjaPe7ITwvXeoDNxUPx40B8/kT7BFi7ROCvrrdU4Q0kK/C+mIV5UFSYdu55SBbfmmA+
         77SBRV/JDLZgoonOWIcd22V/XK8VUfT9BrQ50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hcLrVlRGUQdYXN2jrzFml3ZovDOzUfDOqDqhH26ME9WJMcnh2pHYcwTJjgUu/gWfar
         2j10wiuap8S1c2PbUU8x1CgATfb3/G0ZREv+xaUCafln3sl0HbWvnki3vlvWJ125opFs
         YgqIJ/MMmGJsG4zIG4THsh2hegoQCkulN4Cb4=
Received: by 10.150.48.25 with SMTP id v25mr10180099ybv.145.1280193025035;
        Mon, 26 Jul 2010 18:10:25 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id q1sm6424281ybk.20.2010.07.26.18.10.23
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 18:10:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87iq43wbz3.fsf@fox.patthoyts.tk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151908>

Pat Thoyts wrote:

> I pushed git-gui + my patches to git://git.patthoyts.tk/git-gui
> (http://www.patthoyts.tk/gitweb.cgi?p=git-gui;a=summary)
> so if someone wants to pull from that it is Shawn's repository plus 3.

Quick thoughts:

Were those patches reviewed?  I assume so, but I do not see a
Reviewed-by or anything so I do not know who to blame if they
go awry.

Here[1] is another candidate patch, though it has not received
much attention, unfortunately.

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/723900/focus=150231
