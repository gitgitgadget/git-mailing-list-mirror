From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: Re: Bug in Git-Gui - Creates corrupt patch
Date: Mon, 02 Mar 2009 15:34:20 +0100
Message-ID: <49ABEE6C.3000500@tuffmail.com>
References: <20090225090322.301cdb77@family.dyweni.com> <49A567C9.5050203@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: 4jxDQ6FQee2H@dyweni.com, spearce@spearce.org, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 02 15:36:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le9FZ-0003H2-RK
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 15:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbZCBOeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 09:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbZCBOeV
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 09:34:21 -0500
Received: from mxout-08.mxes.net ([216.86.168.183]:2516 "EHLO
	mxout-08.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbZCBOeU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 09:34:20 -0500
Received: from [192.168.0.125] (unknown [82.210.157.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id 92245D051E;
	Mon,  2 Mar 2009 09:34:16 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081227)
In-Reply-To: <49A567C9.5050203@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111942>

Johannes Sixt pisze:
> 4jxDQ6FQee2H@dyweni.com schrieb:
>> 3. Using git-gui, try to stage *only* the last line marked for removal
>> (should be '-	}').
>>
>> I get 'fatal: corrupt patch at line 22'.
> 
> "Stage/Unstage line" does not work for files that have
> 
> \ No newline at end of file

I've just stumpled across this problem. Does above imply that reported problem is not considered as a bug?

If so I believe that git gui should enforce new lines at the end of a file or at least provide more meaningful error msg.

-- 
Best regards,
Grzegorz Kossakowski
