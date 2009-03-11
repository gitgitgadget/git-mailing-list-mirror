From: Svenn Are Bjerkem <svenn.bjerkem@googlemail.com>
Subject: Re: After git svn clone master is tied to a branch in svn, howto set 
	master to trunk
Date: Wed, 11 Mar 2009 09:04:23 -0700 (PDT)
Message-ID: <7ec81af9-d5eb-42a4-b6af-22e7a3ab89f8@t7g2000yqa.googlegroups.com>
References: <09fb20f5-3722-49d4-9565-95a5b41d15ac@c36g2000yqn.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 17:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhQwP-00051f-Lw
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 17:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbZCKQE0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 12:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbZCKQE0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 12:04:26 -0400
Received: from yx-out-2122.google.com ([74.125.44.25]:53753 "EHLO
	yx-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbZCKQEZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 12:04:25 -0400
Received: by yx-out-2122.google.com with SMTP id 33so26876yxl.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 09:04:23 -0700 (PDT)
Received: by 10.151.6.15 with SMTP id j15mr1334612ybi.29.1236787463112; Wed, 
	11 Mar 2009 09:04:23 -0700 (PDT)
In-Reply-To: <09fb20f5-3722-49d4-9565-95a5b41d15ac@c36g2000yqn.googlegroups.com>
X-IP: 62.92.119.36
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.3) 
	Gecko/2008092814 Iceweasel/3.0.3 (Debian-3.0.3-3),gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112947>

On Mar 11, 4:17=A0pm, Svenn Are Bjerkem <svenn.bjer...@googlemail.com>
wrote:
> Hi,
> after performing a
> $> git svn clone https://svnserver/svn/a/b/c-T trunk/current -t tags =
-
> b branches
> I find that the git master has been tied to one of the branches. It
> turns out that the highest svn revision number in the repository was
> tied to that branch.

[snip]

> I guess I could solve the problem by modifying a file in trunk on svn
> and commit so that the trunk will get the highest svn revision number
> again and redo the clone.

I just wanted to confirm this assumption: First I removed the complete
git-svn clone and modified a file in trunk and checked it into svn.
Then I re-performed the git svn clone as described above. The master
in the local git repository is now tied to the trunk of the svn
repository.

--
Svenn
