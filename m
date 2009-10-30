From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 23:10:21 +0100
Message-ID: <4AEB644D.8020006@kdbg.org>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com> <20091030202628.GA26513@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Erick Mattos <erick.mattos@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:11:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zgj-0000sj-CF
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 23:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbZJ3WKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 18:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932950AbZJ3WKb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 18:10:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:16728 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932980AbZJ3WKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 18:10:25 -0400
Received: from [77.117.168.120] (77.117.168.120.wireless.dyn.drei.com [77.117.168.120])
	by bsmtp.bon.at (Postfix) with ESMTP id EC237A7EB0;
	Fri, 30 Oct 2009 23:10:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091030202628.GA26513@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131764>

Jeff King schrieb:
> But this mutual exclusivity implies to me that the option should
> probably be "--timestamp=old|new".

Even better:

	--timestamp=now
	--timestamp='2008-09-03 13:09:12 +0200'

I'd have needed this just yesterday...

-- Hannes
