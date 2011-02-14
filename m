From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/7] push: describe --porcelain just like commit and status
Date: Mon, 14 Feb 2011 20:42:31 +0100
Message-ID: <201102142042.31887.j6t@kdbg.org>
References: <cover.1297695910.git.git@drmicha.warpmail.net> <3b6a87b585eea1722bd31bc9cf5ba2c80e37aefa.1297695910.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 20:42:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4Ju-0002s7-IN
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab1BNTmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 14:42:36 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:5512 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751153Ab1BNTmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 14:42:35 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 30D8CA7EBD;
	Mon, 14 Feb 2011 20:41:29 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 58B6A19F5AF;
	Mon, 14 Feb 2011 20:42:32 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <3b6a87b585eea1722bd31bc9cf5ba2c80e37aefa.1297695910.git.git@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166754>

On Montag, 14. Februar 2011, Michael J Gruber wrote:
> -		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output",... 
TRANSPORT_PUSH_PORCELAIN),
> +		OPT_BIT( 0,  "porcelain", &flags, "show porcelain output format",...

IMO, this is a step in the wrong direction. It is not at all clear 
that "--porcelain" means "output _for_ porcelain"; it is much more likely to 
be understood as "output _is_ the porcelain". Your new text even supports 
this latter understanding. The original description "machine-readable output" 
is unambiguous and cannot be misunderstood.

-- Hannes
