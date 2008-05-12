From: Tobias Sarnowski <sarnowski@new-thoughts.org>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 08:36:54 +0200
Message-ID: <EC8B6A6F-31FA-498C-92A1-DE2F0645C56F@new-thoughts.org>
References: <4827DEF6.1050005@gmail.com>
Mime-Version: 1.0 (iPhone Mail 4A102)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 08:59:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvS0T-0002ya-7C
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 08:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbYELG6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 02:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755813AbYELG6c
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 02:58:32 -0400
Received: from www61.your-server.de ([213.133.104.61]:34685 "EHLO
	www61.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbYELG6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 02:58:31 -0400
X-Greylist: delayed 1280 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 May 2008 02:58:31 EDT
Received: from [80.187.98.1] (helo=[172.16.193.89])
	by www61.your-server.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <sarnowski@new-thoughts.org>)
	id 1JvRfG-0001IY-0p; Mon, 12 May 2008 08:37:38 +0200
In-Reply-To: <4827DEF6.1050005@gmail.com>
X-Mailer: iPhone Mail (4A102)
X-Authenticated-Sender: sarnowski@new-thoughts.org
X-Virus-Scanned: Clear (ClamAV 0.91.1/5920/Thu Feb 21 22:44:31 2008)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81837>

Hi bill,

Backing up the ".git" directory is all you need. You can also clone it  
as a bare repository (see git clone --bare).

Afterwards "git checkout" is your friend.

Tobias

Am 12.05.2008 um 08:08 schrieb bill lam <cbill.lam@gmail.com>:

> Hello, this should be a simple question. How to backup a git  
> repository but excluding files that not under versioned?  If I cp or  
> tar or rsync the directory. All non-versioned files are added.
>
> regards
