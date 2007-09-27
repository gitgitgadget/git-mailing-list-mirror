From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Add --no-rename to git-apply
Date: Thu, 27 Sep 2007 21:04:18 +0200
Message-ID: <200709272104.18510.robin.rosenberg@dewire.com>
References: <11908420041596-git-send-email-robin.rosenberg@dewire.com> <7vbqbozo7t.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709271107530.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iaycu-0007Aj-Cs
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757065AbXI0TCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757302AbXI0TCM
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:02:12 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19455 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbXI0TCL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:02:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CBDBA802872;
	Thu, 27 Sep 2007 20:53:52 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12113-02; Thu, 27 Sep 2007 20:53:52 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 7B01980264D;
	Thu, 27 Sep 2007 20:53:52 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0709271107530.28395@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59312>

torsdag 27 september 2007 skrev Johannes Schindelin:
> Robin said in a follow-up mail that he needs it for a payed-for SCM 
> (let's describe it as TransparentBox here), which insists on explicit 
> renames.
> 
> But I suggest a simple script here which extracts from the diff the 
> renames, which outputs a script which renames the file(s) back and then 
> uses the TransparentBox' mv command:
> 
> sed -n -e "/^rename from/N" \
>   -e "s/^rename from \(.*\)\nrename to \(.*\)/mv \2 \1 \&\& tb mv \1 \2/p" \
>   < diff.patch
> 

I tried something like that (integrated in the script), and the bugger noticed 
it and refused to work as exepected, but now that I think about it should be
possible to fool it. I have to give it a go again and see what really actually
went wrong.

-- robin
