From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 23:00:03 +0200
Message-ID: <20080428210003.GB22815@cuci.nl>
References: <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org> <alpine.DEB.1.00.0804281937240.19187@eeepc-johanness> <20080428190047.GG26880@genesis.frugalware.org> <20080428192837.GB21950@cuci.nl> <alpine.DEB.1.00.0804282052050.19187@eeepc-johanness> <20080428204323.GA22815@cuci.nl> <alpine.DEB.1.00.0804282153290.19187@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:01:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqaT0-0008Bz-59
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbYD1VAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935289AbYD1VAF
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:00:05 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:55064 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934521AbYD1VAE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 17:00:04 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 0ADEE545E; Mon, 28 Apr 2008 23:00:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804282153290.19187@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80610>

Johannes Schindelin wrote:
>On Mon, 28 Apr 2008, Stephen R. van den Berg wrote:
>> - git-daemon logs happily for a while
>> - rotatelog rotates logfiles in /var/log and communicates with syslogd
>>   to make sure syslogd starts new logfiles in /var/log
>> - And then git-daemon hangs on which system/library call?

>It seems that this happens, yes.

Could you hang an strace off of git-daemon and check what system call it
hangs on at that point in time?
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
