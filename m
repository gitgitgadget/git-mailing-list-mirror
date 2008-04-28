From: Bill Lear <rael@zopyra.com>
Subject: Re: Simple problem
Date: Mon, 28 Apr 2008 11:35:55 -0500
Message-ID: <18453.64747.540905.586259@lisa.zopyra.com>
References: <fv4u49$oks$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:37:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWLU-0005Ti-0T
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935861AbYD1QgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 12:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933669AbYD1QgA
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:36:00 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60796 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965443AbYD1Qf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 12:35:59 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m3SGZvZ05372;
	Mon, 28 Apr 2008 10:35:57 -0600
In-Reply-To: <fv4u49$oks$1@ger.gmane.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80556>

On Monday, April 28, 2008 at 16:31:05 (+0000) Kenneth P. Turvey writes:
>I ran into an issue earlier today that I didn't know how to easily solve 
>in git.  I'm sure it is easy to handle, but I wasn't sure how.  
>
>I removed a file and then realized I'd hit the wrong one.  So all I 
>wanted to do was to get the file back the way it was in the last commit.  
>
>Basically I wanted something similar to:
>
>svn update myfile
>
>in subversion.  
>
>I got it back by using a diff and just deleting all the minus signs at 
>the beginning of the lines, but I'm sure this isn't the way to handle 
>this.  Strangely this simple case wasn't covered by any of the tutorials 
>I looked at. 

% rm file
[oops]
% git checkout file


Bill
