From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Tue, 17 Feb 2009 18:00:17 +0000
Message-ID: <e2b179460902171000s605675dct1f499a9425c3ebb2@mail.gmail.com>
References: <200902142056.42198.trast@student.ethz.ch>
	 <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch>
	 <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org>
	 <200902151711.45099.trast@student.ethz.ch>
	 <20090215181818.GA2291@coredump.intra.peff.net>
	 <e2b179460902170129s7ae613cehe237619be5e84936@mail.gmail.com>
	 <20090217163413.GB31297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 19:02:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZUGb-0001PO-Bp
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 19:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbZBQSAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 13:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbZBQSAU
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 13:00:20 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:48041 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbZBQSAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 13:00:19 -0500
Received: by qyk4 with SMTP id 4so3961237qyk.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 10:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0MSMhznY1kgvg7akx/DeGoLnHrjwS4bVGZkVdyNhHxA=;
        b=autXIfk6SEMhcXNx4jH08zjXejiarM907wlbkH/Um8YXtyfzpq4ZrWa1LJNZN8Rcjg
         RNj1t9DXNORyLjYsdVOoRTnZ84T35M8QjhUtd/gGJjcnUItutciUT00/Mlid9Axowe70
         LUAAwJOUXsE8UQz0VBJFrH5cwWrtjN+YpUs2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kFL8QPgm9GhFpmrwnVaMBK0USyT0eYVLsoBKSB3JFeZHn2hvZrg6fcun2yk9HjXBge
         GReKcAR14SZd8NrK4qhr8fT34X98XSymXQCcYD+jqztx3vipNG/CELYeRnf8tWvTizIm
         qOQ67Zz/LJblfLf4RVVAXWOHFMsI8YOLs6hYc=
Received: by 10.224.80.202 with SMTP id u10mr10586666qak.353.1234893617711; 
	Tue, 17 Feb 2009 10:00:17 -0800 (PST)
In-Reply-To: <20090217163413.GB31297@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110428>

2009/2/17 Jeff King <peff@peff.net>:
> On Tue, Feb 17, 2009 at 09:29:57AM +0000, Mike Ralphson wrote:
>> posh? http://packages.debian.org/lenny/posh
>
> Hmm. I tried "make SHELL_PATH=/bin/posh test", and posh segfaulted during
> t0005. So I don't think it's quite ready for mainstream use. ;)

Works ok for me as far as t3404-rebase-interactive on next, though
what I actually grabbed in the end was 0.6.16[1], which claims to fix
a segfault bug[2], but then it also claims to be 0.6.12 as well, so
who knows? 8-)

Maybe a Debian user would like to report a repeat of [3]?

Mike

[1] http://packages.debian.org/sid/posh
[2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=515278
[3] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=397596
