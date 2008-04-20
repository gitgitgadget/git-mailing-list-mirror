From: "Henry,  Jacob Anthony" <jachenry@indiana.edu>
Subject: Re: segmentation fault - git over http
Date: Sat, 19 Apr 2008 22:57:38 -0400
Message-ID: <20080419225738.ukaa4832v4cwco4o@webmail.iu.edu>
References: <16785966.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 05:26:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnQC9-0004dv-PX
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 05:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbYDTDZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 23:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbYDTDZj
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 23:25:39 -0400
Received: from hartman.uits.indiana.edu ([129.79.1.194]:38352 "EHLO
	hartman.uits.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbYDTDZj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 23:25:39 -0400
X-Greylist: delayed 1679 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Apr 2008 23:25:39 EDT
Received: from spinner.uits.indiana.edu (spinner.uits.indiana.edu [129.79.1.139])
	by hartman.uits.indiana.edu (8.14.2/8.13.8/IU Messaging Team) with ESMTP id m3K2vcmZ010013
	for <git@vger.kernel.org>; Sat, 19 Apr 2008 22:57:39 -0400
Received: from localhost (spinner.uits.indiana.edu [127.0.0.1])
	by spinner.uits.indiana.edu (Postfix) with ESMTP id A58CB101B9
	for <git@vger.kernel.org>; Sat, 19 Apr 2008 22:57:38 -0400 (EDT)
Received: from 98.223.158.239 ([98.223.158.239]) by webmail.iu.edu (Horde
	MIME library) with HTTP; Sat, 19 Apr 2008 22:57:38 -0400
In-Reply-To: <16785966.post@talk.nabble.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79945>

updating to version 1.5.5 fixed the problem.

Quoting jacobhenry <jachenry@gmail.com>:

>
> The past couple days I have tried to configure git over http.  To this point
> I have it working for a small repository. However, when I try to push a
> large directory to the server, it gives me a very vague description of the
> error "http-push died with strange error".  My apache logs do not even
> flicker.  Is there anywhere I can look to see what the actual error is?
>
> Here is the output when trying to push a rails project to my remote server
> using git-http-push:
>
> Fetching remote heads...
>  refs/
>  refs/heads/
>  refs/tags/
> updating 'refs/heads/master'
>  from 0000000000000000000000000000000000000000
>  to   267c7ff02a8dbd0e0d81bbfeee4e64faa4773f83
>    sending 60 objects
>    done
> Updating remote server info
> Segmentation Fault
>
>
> --
> View this message in context:
> http://www.nabble.com/segmentation-fault---git-over-http-tp16785966p16785966.html
> Sent from the git mailing list archive at Nabble.com.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
