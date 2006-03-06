From: Junio C Hamano <junkio@cox.net>
Subject: Re: git clone downloads objects that are in GIT_OBJECT_DIRECTORY
Date: Sun, 05 Mar 2006 18:34:48 -0800
Message-ID: <7vfylwcncn.fsf@assigned-by-dhcp.cox.net>
References: <20060306010825.GF20768@kvack.org>
	<20060306014253.GD25790@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 03:35:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG5Yk-0004Nj-Gv
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 03:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWCFCeu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 21:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWCFCeu
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 21:34:50 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:32728 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751276AbWCFCeu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 21:34:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060306023126.YQUL17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 21:31:26 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060306014253.GD25790@spearce.org> (Shawn Pearce's message of
	"Sun, 5 Mar 2006 20:42:53 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17264>

Shawn Pearce <spearce@spearce.org> writes:

> Benjamin LaHaise <bcrl@kvack.org> wrote:
>> Hi folks,
>> 
>> Doing a fresh git clone git://some.git.url/ foo seems to download the 
>> entire remote repository even if all the objects are already stored in 
>> GIT_OBJECT_DIRECTORY=/home/bcrl/.git/object .  Is this a known bug?  
>> At 100MB for a kernel, this takes a *long* time.
>
> I believe it is a known missing feature.  :-) git-clone doesn't
> prep HEAD to have some sort of starting point so the pull it uses
> to download everything literally downloads everything as nothing
> is in common.

You would first 'clone -l -s' from your local repository and
then clone into that from whatever remote, perhaps.
