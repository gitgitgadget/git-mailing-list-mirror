From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 3/5] chain kill signals for cleanup functions
Date: Fri, 30 Jan 2009 09:13:00 +0100
Message-ID: <4982B68C.2070207@viscovery.net>
References: <20090122042643.GB31427@coredump.intra.peff.net> <20090122060235.GC30133@coredump.intra.peff.net> <20090130075552.GA27716@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 09:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSoWI-0006ul-S3
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 09:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbZA3INL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 03:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbZA3INI
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 03:13:08 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7393 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbZA3INH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 03:13:07 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LSoUm-0003Jw-NR; Fri, 30 Jan 2009 09:13:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 77F5969F; Fri, 30 Jan 2009 09:13:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20090130075552.GA27716@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107778>

Jeff King schrieb:
> One fix would be to just "signal(SIGINT, SIG_DFL)" at the top. But I
> think it makes the test cleaner to just switch to a more reliable
> signal. The patch would look something like what is below. But I need to
> know what exit code Windows generates for SIGTERM. Johannes?

The same as with SIGINT: 3.

-- Hannes
