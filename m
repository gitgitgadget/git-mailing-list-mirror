From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: What's cooking in git.git (Sep 2010, #07; Wed, 29)
Date: Sat, 02 Oct 2010 22:36:36 -0600
Message-ID: <4CA80854.90108@workspacewhiz.com>
References: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 06:36:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2GJV-0006G8-6n
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 06:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216Ab0JCEgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 00:36:36 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:37771 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab0JCEgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 00:36:36 -0400
Received: (qmail 2309 invoked by uid 399); 2 Oct 2010 22:36:35 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 2 Oct 2010 22:36:35 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157826>

  ----- Original Message -----
From: Junio C Hamano
Date: 9/29/2010 6:16 PM
> * jj/icase-directory (2010-08-16) 6 commits
>   - Support case folding in git fast-import when core.ignorecase=true
>   - Support case folding for git add when core.ignorecase=true
>   - Add case insensitivity support when using git ls-files
>   - Add case insensitivity support for directories when using git status
>   - Case insensitivity support for .gitignore via core.ignorecase
>   - Add string comparison functions that respect the ignore_case variable.
>
> Depends on GNU FNM_CASEFOLD.  Presumably a bit of tweak in Makefile for
> non-windows but non-GNU platforms is all it takes?
I posted a new series with an alternate solution for fnmatch that 
doesn't rely on GNU FNM_CASEFOLD.  Hopefully, this one is okay.

I have begun working on tests, but I'm still trying to pick through 
basic shell scripting and then determine how the existing test suite works.

Josh
