From: Brice Lambson <bricelam@live.com>
Subject: Re: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Mon, 15 Apr 2013 20:11:49 +0000 (UTC)
Message-ID: <loom.20130415T220316-790@post.gmane.org>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com> <20100904082509.GC10140@burratino> <7vbp8aqtuz.fsf@alter.siamese.dyndns.org> <1353857940941-7571889.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 15 22:20:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URpsr-0004TT-L8
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 22:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542Ab3DOUUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 16:20:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:54530 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715Ab3DOUUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 16:20:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1URpsh-0004GZ-C9
	for git@vger.kernel.org; Mon, 15 Apr 2013 22:20:03 +0200
Received: from 131.107.192.25 ([131.107.192.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 22:20:03 +0200
Received: from bricelam by 131.107.192.25 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 22:20:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 131.107.192.25 (Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/6.0))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221309>

Mr_and_Mrs_D <the.ubik <at> gmail.com> writes:



> 

> I am on windows 7 Pro - mingwin

> 

> I decided to turn autocrlf to false and use .gitattributes instead and was

> bitten by this bug :

> 

> http://stackoverflow.com/questions/13531988/git-line-endings-renormalize-
does-not-seem-to-checkout-the-right-line-endings

> 

> It took me 2 days to figure this out

> 

> Please fix

> 

> --

> View this message in context: http://git.661346.n2.nabble.com/PATCH-v6-
Add-core-eol-config-variable-tp5140844p7571889.html

> Sent from the git mailing list archive at Nabble.com.

> 



+1, this is a significant issue downstream in Git for Windows:



https://github.com/msysgit/git/issues/57



Effectively this renders .gitattributes useless for the scenario of 
enforcing normalized line ending characters.
