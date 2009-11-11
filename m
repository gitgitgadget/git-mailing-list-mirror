From: Pascal Obry <pascal@obry.net>
Subject: Re: Move repository from OS X to Windows
Date: Wed, 11 Nov 2009 16:53:12 +0100
Organization: Home - http://www.obry.net
Message-ID: <4AFADDE8.7080109@obry.net>
References: <4AFABCF8.9060601@syntevo.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 16:53:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8FVJ-0003et-Tx
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 16:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757495AbZKKPwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 10:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756348AbZKKPwy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 10:52:54 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:46505 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149AbZKKPwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 10:52:54 -0500
Received: by ey-out-2122.google.com with SMTP id 9so291506eyd.19
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 07:52:59 -0800 (PST)
Received: by 10.213.103.83 with SMTP id j19mr6590581ebo.31.1257954777579;
        Wed, 11 Nov 2009 07:52:57 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-81-24.w86-205.abo.wanadoo.fr [86.205.111.24])
        by mx.google.com with ESMTPS id 10sm443041eyz.11.2009.11.11.07.52.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 07:52:56 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <4AFABCF8.9060601@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132667>

Thomas,

> I've cloned a very large repository on OS X and want to move that to Windows
> (trying to avoid to clone the repository a second time). What steps should I
> do to make it working (currently, I'm getting an error on pull/merge that
> "Entry 'foo' is not uptodate. Cannot merge.")?

Is that a git-svn clone?

Otherwise I do not see why you avoid a second clone. Cloning from your 
windows machine the OSX repo won't be slower than cloning from the 
original repo? Or I missed something...

If you are speaking about a git-svn clone, I understand. In this case I 
generally I just rsync the .git directory from one machine to the other:

    $ mkdir project
    $ cd project
    $ rsync -a machine:/path/to/project/.git .
    $ git reset --hard HEAD

And you are done.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
