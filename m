From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 23:13:28 +0200
Message-ID: <20080428211328.GC22815@cuci.nl>
References: <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org> <alpine.DEB.1.00.0804281937240.19187@eeepc-johanness> <20080428190047.GG26880@genesis.frugalware.org> <20080428192837.GB21950@cuci.nl> <alpine.DEB.1.00.0804282052050.19187@eeepc-johanness> <20080428204323.GA22815@cuci.nl> <alpine.DEB.1.00.0804282153290.19187@eeepc-johanness> <20080428210003.GB22815@cuci.nl> <alpine.DEB.1.00.0804282209230.19187@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:14:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqagQ-00056K-GX
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965602AbYD1VNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965541AbYD1VNa
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:13:30 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:38267 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965487AbYD1VN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 17:13:29 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 20F30545E; Mon, 28 Apr 2008 23:13:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804282209230.19187@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80615>

Johannes Schindelin wrote:
>On Mon, 28 Apr 2008, Stephen R. van den Berg wrote:
>> Johannes Schindelin wrote:
>> >On Mon, 28 Apr 2008, Stephen R. van den Berg wrote:
>> >> - rotatelog rotates logfiles in /var/log and communicates with syslogd
>> >>   to make sure syslogd starts new logfiles in /var/log
>> >> - And then git-daemon hangs on which system/library call?

>I can do better than that.  I attached to the process, and like I said, it 
>hung in close().

On which descriptor?  (I.e. what does the descriptor point to?)
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
