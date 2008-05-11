From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] mergetool: Make ECMerge use the settings as specified by the user in the GUI
Date: Sun, 11 May 2008 09:33:09 +0200
Message-ID: <183DBDB1-99BE-42C5-91DE-2488046164B7@zib.de>
References: <482038C4.6050402@visageimaging.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@visageimaging.com>
To: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun May 11 09:33:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv63z-0004bv-FR
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 09:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbYEKHcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 03:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbYEKHcy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 03:32:54 -0400
Received: from mailer.zib.de ([130.73.108.11]:64501 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbYEKHcx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 03:32:53 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m4B7WRRC022173;
	Sun, 11 May 2008 09:32:27 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db97dd2.pool.einsundeins.de [77.185.125.210])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m4B7WQMQ007370
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 11 May 2008 09:32:26 +0200 (MEST)
In-Reply-To: <482038C4.6050402@visageimaging.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81745>


On May 6, 2008, at 12:53 PM, Sebastian Schuberth wrote:

> When run from the command line, ECMerge does not automatically use  
> the same
> settings for a merge / diff that it would use when starting the GUI  
> and loading
> files manually. In the first case the built-in factory defaults  
> would be used,
> while in the second case the settings the user has specified in the  
> GUI would
> be used, which can be misleading. Specifying the "--default" command  
> line
> option changes this behavior so that always the user specfified GUI  
> settings
> are used.


I tested the change and propose to take the patch.  I needed,
however, to remove dos line endings from the patch before it
applied cleanly.

	Steffen
