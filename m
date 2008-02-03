From: Mike Hommey <mh@glandium.org>
Subject: Re: MKCOL fails, 403 error
Date: Sun, 3 Feb 2008 15:31:01 +0100
Organization: glandium.org
Message-ID: <20080203143101.GB7946@glandium.org>
References: <eae1aef50802030535u1402471fh182a230f3e0667ea@mail.gmail.com> <eae1aef50802030539l14287c7exa914696755e7ade4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@suse.cz
To: Alan Smith <alanrogersmith@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 15:31:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLfsl-0007uP-Rs
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 15:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbYBCObF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 09:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288AbYBCObF
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 09:31:05 -0500
Received: from vuizook.err.no ([85.19.215.103]:52497 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104AbYBCObE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 09:31:04 -0500
Received: from aputeaux-153-1-85-206.w86-205.abo.wanadoo.fr ([86.205.43.206] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JLfsl-00015w-Aq; Sun, 03 Feb 2008 15:31:49 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JLfs5-0002Cc-EQ; Sun, 03 Feb 2008 15:31:01 +0100
Content-Disposition: inline
In-Reply-To: <eae1aef50802030539l14287c7exa914696755e7ade4@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72356>

On Sun, Feb 03, 2008 at 08:39:04AM -0500, Alan Smith wrote:
> Hello everyone,
> 
> I am assisting the admin of dsource.org to get git working on their
> server. I have had problems but those were resolved by my upgrading to
> the most recent version of git (who'd have thought Ubuntu would not
> have a version newer than 1.5.2.5?) Let me give you the terminal
> output, the best explanation I have of my problem:
> 
> $ git push upload --force --all -v
> Pushing to http://git.dsource.org/projects/pineapple/
> Getting pack list
> Fetching remote heads...
>   refs/
>   refs/heads/
>    refs/tags/
> updating 'refs/heads/master'
>   from 0000000000000000000000000000000000000000
>   to   aae4714c3d1150974612a9de2f86223dd6882b3c
>     sending 11 objects
>     done
> MKCOL 65f829e3b46d363c07ff4e534bb1a39a6660fa48 failed, aborting (22/403)
>      sent ce937eb2f7092823f0a491fdf0ab449440eb5365
> Updating remote server info
>     sent 367d34569b5d5223db05770d093e23bcc1c0ba89
>     sent c431db074337adc100edbe4be861f599b0d889ad
>     sent 65016e7e3c0d7654d6745b7de6d6a0840dd39150
> 
> In spite of the obvious problem, the 403 error, the user which I used
> to push to the remote server is in the apache group on that server.
> The apache group is both the owner and group of all of the files and
> directories in the git repository. Thus, I see no reason why it is
> getting a 403 error.
> 
> I am pretty sure the MKCOL has something to do with the fact that
> there is a directory in my local git repository which it doesn't seem
> to be able to create in the remote repository.
> 
> I was told to run git-fsck but it doesn't complain when I do run it.
> 
> Does anyone have any ideas?

Do you have access to the apache error_log ?

Mike
