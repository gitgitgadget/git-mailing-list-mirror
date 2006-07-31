From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git merge (resolve) _is_ stupid
Date: Mon, 31 Jul 2006 10:12:29 -0700 (PDT)
Message-ID: <20060731171229.24870.qmail@web31802.mail.mud.yahoo.com>
References: <7v7j1u88ol.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 31 19:12:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7bJk-00034X-VU
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 19:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWGaRMc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 13:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWGaRMb
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 13:12:31 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:8062 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030257AbWGaRMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 13:12:31 -0400
Received: (qmail 24872 invoked by uid 60001); 31 Jul 2006 17:12:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vJLL7TfFig1Tkw8nYJr3faRYI7A3Zn9fEWG0eRtv8k6/lZMRsQZSXH+vM4grEtrNtc1Q7hArdnQGc/B0iuRx5v3h0IfNukNohfYUjSS/fIpWzixFQYnuDSHMBunKLloHnrXPrYB8PimgG1vEqoI8NaG4cod8r9NcEHETLWnwwAM=  ;
Received: from [71.80.231.253] by web31802.mail.mud.yahoo.com via HTTP; Mon, 31 Jul 2006 10:12:29 PDT
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7v7j1u88ol.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24528>

I had seen something similar:

Merging linux-scsi into my own branches whereby both had a
particular patch (03aba2f79594ca94d159c8bab454de9bcc385b76),
git-merge complained that a resolve is needed.

After manually "resolving" the result was identical to
either branch (linux-scsi and my own), so in fact the
diff was 0.

I found this strange, but due to lack of time couldn't
pursue it further.

    Luben
