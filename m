From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Sun, 10 Oct 2010 09:11:19 +1100
Message-ID: <5A2A5584-FB25-46C2-8891-B667C46011D3@cordelta.com>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com> <20101008081509.GA2845@kytes> <4CAED762.7040708@gmail.com> <74AF320B-5D82-4622-A7BF-61C847D4059A@cordelta.com> <AANLkTi=zS+oj1iHMh-gKVD=2dG5tLwA+bia9E6U3o=zW@mail.gmail.com> <20101008170939.GG9212@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 00:11:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4hdh-0008H9-H2
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 00:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093Ab0JIWLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 18:11:24 -0400
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:50717
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752479Ab0JIWLX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Oct 2010 18:11:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAFKFsEzLWHsF/2dsb2JhbACiOwhxszCIToVHBA
X-IronPort-AV: E=Sophos;i="4.57,309,1283695200"; 
   d="scan'208";a="255597623"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 10 Oct 2010 09:11:20 +1100
Received: (qmail 31485 invoked from network); 10 Oct 2010 09:11:20 +1100
Received: from d110-33-95-167.mit3.act.optusnet.com.au (HELO ?192.168.1.1?) (110.33.95.167)
  by 203.88.123.185 with SMTP; 10 Oct 2010 09:11:20 +1100
In-Reply-To: <20101008170939.GG9212@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158631>

Should I resubmit this patch with the complete justification?

Add an extra paragraph like:

v1.7.3-rc0~75^2 (Teach fast-import to import
subtrees named by tree id, 2010-06-30)
has a shortcoming, it doesn't allow the root to be set.
Extend this behaviour by allowing the root to be
referenced as the empty path, "".

>  v1.7.3-rc0~75^2 (Teach fast-import to import
> subtrees named by tree id, 2010-06-30)
