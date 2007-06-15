From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC][PATCH] Fix assumption that git is installed in a standard
 place on the remote end ssh
Date: Fri, 15 Jun 2007 16:30:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706151628180.31972@reaper.quantumfyre.co.uk>
References: <20070615150351.GH14677@menevado.ms.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Kevin Green <Kevin.T.Green@morganstanley.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 17:31:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzDlq-0000Gg-H1
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 17:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbXFOPbI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 11:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754160AbXFOPbH
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 11:31:07 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:58967 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754109AbXFOPbG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jun 2007 11:31:06 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id ACEF1BF859
	for <git@vger.kernel.org>; Fri, 15 Jun 2007 16:31:03 +0100 (BST)
Received: (qmail 16933 invoked by uid 103); 15 Jun 2007 16:31:03 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.3/3423. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 49.829502 secs); 15 Jun 2007 15:31:03 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 15 Jun 2007 16:30:13 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20070615150351.GH14677@menevado.ms.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50268>

On Fri, 15 Jun 2007, Kevin Green wrote:

>
> Hi,
>
> I've run into a problem pushing/pulling where we don't (READ: can't) have git installed in the
> standard location.  This leads to a failure on trying to find the git binaries
> on the remote end.  I've looked through the archives and didn't come across
> any similar discussions.  Please point me there if I've missed something...

from the git-pull manpage:

        --upload-pack <upload-pack>
               When given, and the repository to fetch from is handled by
               git-fetch-pack, --exec=<upload-pack> is passed to the command
               to specify non-default path for the command run on the other
               end.

and git-pull:

        --receive-pack=<git-receive-pack>
               Path to the git-receive-pack program on the remote end.
               Sometimes useful when pushing to a remote repository over ssh,
               and you do not have the program in a directory on the default
               $PATH.

-- 
Julian

  ---
To be or not to be.
 		-- Shakespeare
To do is to be.
 		-- Nietzsche
To be is to do.
 		-- Sartre
Do be do be do.
 		-- Sinatra
