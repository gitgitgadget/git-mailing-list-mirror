From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Tue, 05 Jan 2010 21:49:14 +0100
Message-ID: <4B43A5CA.7090104@kdbg.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <4B421766.4040506@kdbg.org> <7vhbr1bagk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 22:12:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSGhp-0002d2-4z
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 22:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab0AEVMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 16:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700Ab0AEVMl
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 16:12:41 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:59258 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752711Ab0AEVMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 16:12:40 -0500
X-Greylist: delayed 1397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2010 16:12:40 EST
Received: from bsmtp.bon.at (unknown [172.18.12.54])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 7227CCEC46
	for <git@vger.kernel.org>; Tue,  5 Jan 2010 21:50:06 +0100 (CET)
Received: from [77.116.28.239] (77.116.28.239.wireless.dyn.drei.com [77.116.28.239])
	by bsmtp.bon.at (Postfix) with ESMTP id 2D5A2A7EB4;
	Tue,  5 Jan 2010 21:49:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vhbr1bagk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136209>

Junio C Hamano schrieb:
> While you are technically correct that the change you made in t4030 is not
> justified by the commit log message in the sense that the "hexdump" script
> will go through run_command() interface and is not subject to the special
> rules filter writers need to keep in mind, the patch text itself is a good
> change, isn't it?

The patch text is good, but since it will not make a difference (and there 
are a ton of other places that use /bin/sh successfully), the change is 
not warrented at this time, IMO.

> As "run-command: convert simple callsites to use_shell" is the one that
> changes the filter_buffer(), do you want to have t0021 patch before that
> one, to prepare the test for the coming change?

Well, the test will break on Windows only after "run-command: optimize out 
useless shell calls", and I wrote the commit message accordingly. If you 
move it before that one (and if you are picky) the commit message should 
be changed as well.

-- Hannes
