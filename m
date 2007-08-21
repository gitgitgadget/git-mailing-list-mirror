From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Centralized processes in git
Date: Tue, 21 Aug 2007 08:40:37 +0800
Message-ID: <46CA3485.4080207@midwinter.com>
References: <31FEEAE6-58A6-4A74-9DB7-E6F9D56D1C48@rlb3.com> <20070820192947.GD8542@efreet.light.src> <46CA3398.9060803@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robert Boone <robert@rlb3.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Aug 21 02:40:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INHnd-00032v-IE
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 02:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbXHUAkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 20:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626AbXHUAkm
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 20:40:42 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:44725 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754936AbXHUAkm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 20:40:42 -0400
Received: (qmail 18547 invoked from network); 21 Aug 2007 00:40:41 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=W0aK5ck2/mPNCoDx+CdZNFkj5oOsgHZ29TrESpKuAUtDxLz0cu6yb1Lor6CXujMk  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 21 Aug 2007 00:40:41 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <46CA3398.9060803@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56270>

Steven Grimm wrote:
> the repository-altering commands would grab a shared lock.

I guess that's a bit confusing -- what I mean to say is that the 
repository-altering commands that today do not lock the repository would 
grab a shared lock such that, in the absence of something else grabbing 
the exclusive lock, they will continue to effectively not lock the 
repository. IOW, by grabbing the shared lock they will continue to 
exhibit their current behavior under normal conditions.

-Steve
