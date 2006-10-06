From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Subject: Re: Problem cloning packed-and-pruned http repository
Date: Sat, 7 Oct 2006 00:05:42 +0200
Message-ID: <20061006220542.GA5890@lumumba.uhasselt.be>
References: <20061006212616.GA5175@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 07 00:28:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVyBM-0003Jt-Jq
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 00:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422704AbWJFW2i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 18:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWJFW2h
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 18:28:37 -0400
Received: from student.uhasselt.be ([193.190.2.1]:30479 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP id S932652AbWJFW2h
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 18:28:37 -0400
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by student.uhasselt.be (Postfix) with ESMTP id 68F23318A
	for <git@vger.kernel.org>; Sat,  7 Oct 2006 00:28:36 +0200 (CEST)
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Received: from lumumba.uhasselt.be (lumumba.uhasselt.be [193.190.9.252])
	by student.uhasselt.be (Postfix) with ESMTP id B4E0C133F
	for <git@vger.kernel.org>; Sat,  7 Oct 2006 00:05:42 +0200 (CEST)
Received: by lumumba.uhasselt.be (Postfix, from userid 1000)
	id 52A57EDB4F; Sat,  7 Oct 2006 00:05:42 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061006212616.GA5175@lumumba.uhasselt.be>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28448>

Hi

On Fri, Oct 06, 2006 at 11:26:16PM +0200 or thereabouts,  wrote:
> [...]
> I've been having trouble setting up a public repository using GIT. After
> I have pushed my repository to a directory within ~/public_html, I can
> clone it. But the repository is _big_ (261M).
> 
> So, I use "git-repack" on it and a "git-prune-packed". This makes it
> nicely fit in 14MiB. If I try to clone this pruned/packed repository
> again both cg-clone hangs on it (as does git-clone).
> [...] 
> takis@poseidon:/tmp$ cg-clone http://lumumba.uhasselt.be/takis/git/ffmpeg-h264-test.git
> defaulting to local storage area
> Fetching head...
> Fetching objects...
> Getting alternates list for http://lumumba.uhasselt.be/takis/git/ffmpeg-h264-test.git/
> Getting pack list for http://lumumba.uhasselt.be/takis/git/ffmpeg-h264-test.git/
> progress: 0 objects, 0 bytes
> cg-clone: interrupted
> 
Apparently, it does work :-/ After a _long_ time I noticed that the
repository indeed got cloned... I am not sure if this is normal behavior
or not, it seemed to take a _really_ long. I would have thought
downloading 14MiB should not take a long time on my ADSL line.


With friendly regards,
Takis

-- 
OpenPGP key: http://lumumba.uhasselt.be/takis/takis_public_key.txt
fingerprint: 6571 13A3 33D9 3726 F728  AA98 F643 B12E ECF3 E029
