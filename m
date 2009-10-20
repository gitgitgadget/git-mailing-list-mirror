From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn: add support for merges during 'git svn fetch'
Date: Tue, 20 Oct 2009 15:46:24 +1300
Message-ID: <4ADD2480.7070207@vilain.net>
References: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 04:46:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N04k2-0000Uj-96
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 04:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758235AbZJTCqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 22:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756741AbZJTCqV
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 22:46:21 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:42868 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475AbZJTCqU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 22:46:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id C5ED23237F;
	Tue, 20 Oct 2009 15:46:24 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9-QZ5TBesio6; Tue, 20 Oct 2009 15:46:24 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 154143225A;
	Tue, 20 Oct 2009 15:46:24 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130755>

Sorry Eric forgot to pass --cc to send-email, I finally got around to
this ;-)

Sam.

Sam Vilain wrote:
> This series adds support for converting SVN merges - in the two
> popular formats, SVK and SVN 1.5+, into git parents.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
