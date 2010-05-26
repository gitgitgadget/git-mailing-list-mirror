From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH 0/7] Various updates to make core.ignorecase=true work
 better
Date: Wed, 26 May 2010 12:26:02 -0600
Message-ID: <4BFD67BA.2050105@workspacewhiz.com>
References: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 26 20:26:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHLJ1-0002XQ-0J
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 20:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352Ab0EZS0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 14:26:09 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:55684 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525Ab0EZS0I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 14:26:08 -0400
Received: (qmail 693 invoked by uid 399); 26 May 2010 12:26:06 -0600
Received: from unknown (HELO ?192.168.1.107?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 26 May 2010 12:26:06 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.5pre) Gecko/20100430 Lightning/1.0b2pre Thunderbird/3.1b2
In-Reply-To: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147816>

  ----- Original Message -----
From: Joshua Jensen
Date: 5/20/2010 10:50 PM
> Joshua Jensen (7):
>    Add string comparison functions that respect the ignore_case
>      variable.
>    Case insensitivity support for .gitignore via core.ignorecase
>    Add case insensitivity support for directories when using git status
>    Add case insensitivity support when using git ls-files
>    Add support for case insensitive directory and file lookups to git
>      log
>    Support case folding for git add when core.ignorecase=true
>    Support case folding in git fast-import when core.ignorecase=true
Would this patch series be better sent to the msysGit mailing list, 
given that it addresses Windows (and Mac OS X, I suppose) case 
preserving but case insensitive file system issues?  I posted here 
first, because it builds on some core.ignorecase functionality Linus wrote.

Thanks.

Josh
