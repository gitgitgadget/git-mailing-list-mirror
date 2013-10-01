From: "Lucas Sandery [three am design]" <lucas@threeamdesign.com.au>
Subject: gitk next/prev buttons
Date: Tue, 01 Oct 2013 12:01:01 +0930
Message-ID: <524A33E5.7090001@threeamdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 01 05:30:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQqfH-0004ag-D5
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 05:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592Ab3JADaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 23:30:20 -0400
Received: from smtp1.adam.net.au ([202.136.110.253]:46427 "EHLO
	smtp1.adam.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489Ab3JADaT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 23:30:19 -0400
X-Greylist: delayed 3554 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2013 23:30:19 EDT
Received: from 219-90-161-123.ip.adam.com.au ([219.90.161.123] helo=[192.168.8.181])
	by smtp1.adam.net.au with esmtp (Exim 4.63)
	(envelope-from <lucas@threeamdesign.com.au>)
	id 1VQpjp-00077I-Gm
	for git@vger.kernel.org; Tue, 01 Oct 2013 12:01:01 +0930
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235640>

The "next" and "prev" buttons are lacking consistency and logic. For RTL 
languages previous is almost always on the left, and next on the right. 
The words are contradictory, "next" actually goes to backwards 
chronologically, and "prev" goes forward. Could the positions of the 
buttons be switched and the text be replaced with "earlier" and "later"? 
This would make the reference time not just order, and would mean the 
updated UI would not be confused with the previous one.

Also, the arrow-only next/previous buttons (beside the commit ID) should 
really point up and down. Horizontal directions are ambiguous for 
navigation of a vertical list.
