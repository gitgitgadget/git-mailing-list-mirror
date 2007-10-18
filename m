From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: bug: origin refs updated too soon locally
Date: Wed, 17 Oct 2007 18:43:49 -0700
Message-ID: <8E28A8CC-DC3B-4C97-8B14-742DAA8D3CE2@cs.indiana.edu>
References: <8CEF6150-4BE7-4B4D-B58C-12CE4671007E@cs.indiana.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Thu Oct 18 03:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiKQh-0000gy-DH
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 03:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759363AbXJRBn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 21:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759900AbXJRBn4
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 21:43:56 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:47822 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759006AbXJRBnz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 21:43:55 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.80) with ESMTP id l9I1hsgA023171;
	Wed, 17 Oct 2007 21:43:55 -0400
Received: from [10.11.38.38] ([207.173.77.239])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id l9I1hoU5015126
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 17 Oct 2007 21:43:54 -0400
In-Reply-To: <8CEF6150-4BE7-4B4D-B58C-12CE4671007E@cs.indiana.edu>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61451>

I take it back.  A git-pull is not a workaround if the ref moved on  
the remote end.

-- Perry


On Oct 17, 2007, at 6:35 PM, Perry Wagle wrote:

> If I clone a remote repository, make a few commits, push them to  
> the remote repository, and the update hook on the remote repository  
> rejects them (exit 1), the local origin refs are still updated as  
> if the push had gone through.  The workaround is to do a pull to  
> set the origin refs back.
>
> -- Perry
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
