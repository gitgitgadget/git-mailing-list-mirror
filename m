From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] git-svnimport: added explicit merge graph option -G
Date: Sun, 24 Jun 2007 10:27:48 -0700
Message-ID: <467EA994.6030105@midwinter.com>
References: <7vk5tt25n7.fsf@assigned-by-dhcp.cox.net> <20070624084427.GA7715@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Stas Maximov <smaximov@yahoo.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 19:27:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2VsR-0007fu-Rf
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 19:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbXFXR1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 13:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbXFXR1w
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 13:27:52 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:47317
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1751692AbXFXR1w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 13:27:52 -0400
Received: (qmail 11422 invoked from network); 24 Jun 2007 17:27:51 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=JJUkUQTtb5dl32IPcZznrcn24xnIKFnGMV5kqKy5LxHYBbzoNx0dDd7gaTcLXlEz  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 24 Jun 2007 17:27:51 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <20070624084427.GA7715@xp.machine.xx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50805>

Peter Baumann wrote:
> Sure, you have to transform the native revision specifieres into
> the GIT commit id's if you only have e.g. "merged r4711:4720 into trunk",
>   

IMO the major point of this patch is precisely to *avoid* having to do 
that transformation. If you're already going to the trouble of 
converting svn identifiers into git identifiers, then you don't need 
another tool; you just stick the IDs in the grafts file and you're done.

I agree that this functionality is useful in general, though.

-Steve
