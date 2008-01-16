From: Petko Manolov <petkan@nucleusys.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 15:21:43 +0200 (EET)
Message-ID: <alpine.DEB.1.00.0801161517260.5260@bender.nucleusys.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <ee77f5c20801160254u53e07773qb4125ffd90cf7619@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 14:23:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF8En-00040i-H5
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 14:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbYAPNW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 08:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbYAPNW7
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 08:22:59 -0500
Received: from n152-u15.cabletel.bg ([89.253.152.15]:47991 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753334AbYAPNW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 08:22:58 -0500
Received: from bender.nucleusys.com ([192.168.234.2])
	by zztop.nucleusys.com with esmtp (Exim 4.63)
	(envelope-from <petkan@nucleusys.com>)
	id 1JF8EH-0007Hy-OG; Wed, 16 Jan 2008 15:22:53 +0200
In-Reply-To: <ee77f5c20801160254u53e07773qb4125ffd90cf7619@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70667>

On Wed, 16 Jan 2008, David Symonds wrote:

> If you don't care about versioning those files, why would you use a
> version control system? Just store them somewhere else, and use
> symlinks.

That is certainly a way of doing it.  However, it will be much simpler and 
fast to be able to "git clone" and then "git pull" every once in a while. 
The alternative involves "cp -a" or most likely "scp -r" the binaries 
along with the repository and you can never be sure that both are in sync.


 		Petko
