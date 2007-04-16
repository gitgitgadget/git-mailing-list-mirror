From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 2/2] Add --ignore-notfound option to exit with zero status
 when no files are removed.
Date: Mon, 16 Apr 2007 01:13:45 -0700
Message-ID: <46233039.2040208@midwinter.com>
References: <20070416000408.GA19107@midwinter.com>	<7v4pnh18hr.fsf@assigned-by-dhcp.cox.net>	<4622C0AC.8090904@midwinter.com>	<7vps65yvc1.fsf@assigned-by-dhcp.cox.net>	<20070416074648.GA18719@midwinter.com>	<20070416075324.GA18961@midwinter.com> <7vps64vjfc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 10:13:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdMLP-0007ST-6A
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbXDPINs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbXDPINs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:13:48 -0400
Received: from tater.midwinter.com ([216.32.86.90]:53231 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964974AbXDPINr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 04:13:47 -0400
Received: (qmail 21258 invoked from network); 16 Apr 2007 08:13:47 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=dz4vIIDJ6NCWgGEvSVJO2tSsG4bW7SF9YC/h9EQcY/0RVHwOTzHcY2E5xOAsjt3A  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 16 Apr 2007 08:13:47 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <7vps64vjfc.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44620>

Junio C Hamano wrote:
> ls-files has --error-unmatch so we may want to make the name
> consistent by saying --ignore-unmatch?  I particularly do not
> care about the minute naming issues _right_ _now_, but we might
> regret it in the long run.
>   

Sure, UI consistency is a good thing. Feel free to amend.

-Steve
