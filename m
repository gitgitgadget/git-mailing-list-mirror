From: John Freeman <jfreeman@cs.tamu.edu>
Subject: Re: clone fails: Could not get the current working directory
Date: Wed, 24 Sep 2008 08:30:50 -0500
Message-ID: <48DA410A.2080504@cs.tamu.edu>
References: <48D59A30.5020403@cs.tamu.edu>	 <81b0412b0809230539x340bd579q3489d5e257b9740@mail.gmail.com>	 <48D8EDDA.3050804@cs.tamu.edu>	 <81b0412b0809230712u4a1cbe0fo69f558cbe9a26aae@mail.gmail.com>	 <48D90125.3090703@cs.tamu.edu>	 <81b0412b0809230801l2e6b1a71v1210317fe636aeba@mail.gmail.com>	 <48D95C96.4030906@cs.tamu.edu> <81b0412b0809240430y682d6dd9wef801c33a6ee2f85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 15:32:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiUTf-0002rb-NF
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 15:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbYIXNbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 09:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbYIXNbN
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 09:31:13 -0400
Received: from smtp-relay.tamu.edu ([165.91.22.120]:14196 "EHLO
	sr-2-int.cis.tamu.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751704AbYIXNbM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 09:31:12 -0400
Received: from localhost (localhost.tamu.edu [127.0.0.1])
	by sr-2-int.cis.tamu.edu (Postfix) with ESMTP id 3FCA8266A4;
	Wed, 24 Sep 2008 08:31:11 -0500 (CDT)
X-Virus-Scanned: amavisd-new at tamu.edu
Received: from [192.168.10.200] (r74-192-200-91.bcstcmta02.clsttx.tl.dh.suddenlink.net [74.192.200.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sr-2-int.cis.tamu.edu (Postfix) with ESMTPSA id 75B96263D6;
	Wed, 24 Sep 2008 08:31:10 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <81b0412b0809240430y682d6dd9wef801c33a6ee2f85@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96632>

Alex Riesen wrote:
> General question: What does Sun's pwd do?
>   

It works like you'd expect.  There are no permission problems.  Even in 
directories for which I don't have read access, it will show the path.

- John
