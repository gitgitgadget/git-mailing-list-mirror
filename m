From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: git-gui hangs on read
Date: Thu, 24 Apr 2008 08:54:10 +0200
Message-ID: <48102E92.3090601@isy.liu.se>
References: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com> <20080422001311.GS29771@spearce.org> <b3889dff0804220634u58a5ed21yf8a4f369471c6534@mail.gmail.com> <20080422232530.GK29771@spearce.org> <480EF84A.4020308@isy.liu.se> <b3889dff0804230716n1b5dde1ctb7b0c1dd83f2d1ff@mail.gmail.com> <480F4C6E.9070400@isy.liu.se> <20080424010015.GS29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Benjamin Collins <ben.collins@acm.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 24 08:55:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JovMC-0007Dj-QI
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 08:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbYDXGyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 02:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbYDXGyO
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 02:54:14 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:47818 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbYDXGyN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 02:54:13 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 45C5125A3E;
	Thu, 24 Apr 2008 08:54:12 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 18880-07; Thu, 24 Apr 2008 08:54:11 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id B108C25A3D;
	Thu, 24 Apr 2008 08:54:11 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080424010015.GS29771@spearce.org>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80297>

On 04/24/2008 03:00 AM, Shawn O. Pearce wrote:
> Just turn the d**n spell checker off:
> 
> 	git config --global gui.spellingdictionary none
> 
> That will keep us from evening trying to launch aspell, and since
> its global (in your ~/.gitconfig) it should default into every
> repository you have, or create.

Thanks, even better!  Though, I can't seem to find this option (and 
other ones indicated by the source) documented anywhere.  Where would be 
the place to put such information?  For git options the place seems to 
be the git config help, but given that the git gui is maintained 
independently the choice is less obvious to me.

/Gustaf
