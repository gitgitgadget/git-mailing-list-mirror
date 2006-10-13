From: Pazu <pazu@pazu.com.br>
Subject: Re: [PATCH] Removes the <?xml?> declaration from gitweb.pl
Date: Fri, 13 Oct 2006 10:01:12 -0300
Message-ID: <ego2nk$3nm$1@sea.gmane.org>
References: <20061011172553.GA1147@linux-mips.org> <egjnk5$bpn$2@sea.gmane.org> <200610120745.00909.robin.rosenberg.lists@dewire.com> <200610122321.18630.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 13 15:02:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYMg5-00041x-RM
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 15:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWJMNCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 09:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbWJMNCL
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 09:02:11 -0400
Received: from main.gmane.org ([80.91.229.2]:43963 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751649AbWJMNCK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 09:02:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GYMfg-0003vV-E0
	for git@vger.kernel.org; Fri, 13 Oct 2006 15:01:52 +0200
Received: from 200.213.42.52 ([200.213.42.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 15:01:52 +0200
Received: from pazu by 200.213.42.52 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 15:01:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.213.42.52
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
In-Reply-To: <200610122321.18630.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28840>

Jakub Narebski wrote:

> So what should be our decision? Honor IE quirks ;-) and either remove
> XML declaration, or use Transitional DTD? Add back SPC to &nbsp; conversion
> in esc_html? Ignore broken browsers?

My bad here. In my first email I said that using the Transitional DTD 
would fix the problem, but I was wrong. It doesn't matter the DTD you 
use, if you add a <?xml?> declaration, IE will get it wrong and activate 
quirks mode.

-- Marcus
