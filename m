From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [RFC/PATCH] Force using Tcl/Tk 8.4 on Mac OS X
Date: Tue, 7 Sep 2010 21:56:07 +0200
Message-ID: <1jogy2y.tfhl6g1eq9mylM%lists@haller-berlin.de>
References: <87r5h5pdwz.fsf@fox.patthoyts.tk>
Cc: git@vger.kernel.org, spearce@spearce.org (Shawn O Pearce),
	dsteffen@apple.com (Daniel A Steffen)
To: patthoyts@users.sourceforge.net (Pat Thoyts),
	das@users.sourceforge.net (Daniel A. Steffen)
X-From: git-owner@vger.kernel.org Tue Sep 07 21:56:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot4HD-0002QV-Bz
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 21:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114Ab0IGT4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 15:56:13 -0400
Received: from mail.ableton.net ([62.96.12.115]:39036 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757970Ab0IGT4M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 15:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=R3Ow87yoKQBE5cc0mncGLAmC9A/owkiK/GTx437m3aQ=;
	b=Yxe6bcgicDN3gNpuHm1xP+cppi51krwyxDcwBRy/TPIvStUYqPGvj0Xx1RIgrAxMs0i+JMBJYWNiwCbqbq2z4u+amysJQbeRCqA7BABo05uufK5usHIWPPDFLXMQpwVn2fxcqqRquWrloJ5XrZNRPArYQhLCGzdPqWOvtIdxPLc=;
Received: from [10.1.15.235]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1Ot48Q-0006wM-AM; Tue, 07 Sep 2010 21:47:14 +0200
In-Reply-To: <87r5h5pdwz.fsf@fox.patthoyts.tk>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155735>

Pat Thoyts <patthoyts@users.sourceforge.net> wrote:

> This removes the Cmd-J accelerator from the "Revert Changes" menu
> item. I assume that just changing the menu command to 
>  {after idle [list do_revert_selection]}
> doesn't work either?

No, but "after 100" does for me; "after 10" does not, and "after 50"
does some of the time.  I'm not sure if this would be suitable as a
workaround then.

-Stefan


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
