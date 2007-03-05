From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 05 Mar 2007 17:54:45 +0100
Message-ID: <45EC4B55.3090505@lu.unisi.ch>
References: <esgm1m$33f$1@sea.gmane.org> <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45EC3905.7070406@lu.unisi.ch> <Pine.LNX.4.63.0703051648330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bonzini@gnu.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 17:54:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOGSc-0004dN-O0
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 17:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbXCEQyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 11:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbXCEQyu
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 11:54:50 -0500
Received: from server.usilu.net ([195.176.178.200]:36788 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750883AbXCEQyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 11:54:49 -0500
Received: from [192.168.68.211] ([192.168.68.211] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Mar 2007 17:54:46 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <Pine.LNX.4.63.0703051648330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 05 Mar 2007 16:54:46.0339 (UTC) FILETIME=[FACC4930:01C75F46]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41460>


> Well, you make a good case there. I am only mildly concerned that this 
> might not work on some obscure platforms (including Windows and SunOS), 
> and that we are not even realizing that because you do not check the 
> return value of sscanf().

I check that the %n's are written to, instead.

Paolo
