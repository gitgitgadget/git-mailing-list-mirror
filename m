From: David Brown <git@davidb.org>
Subject: Re: rm and mv commands: should I use them?
Date: Sun, 6 Jan 2008 21:01:28 -0800
Message-ID: <20080107050128.GA20484@old.davidb.org>
References: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com> <76718490801061905k30c1ac86r51a65165d47807d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jon Hancock <redstarling@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 06:01:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBk7Z-0006yy-CK
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 06:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbYAGFBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 00:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbYAGFBa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 00:01:30 -0500
Received: from mail.davidb.org ([66.93.32.219]:59305 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbYAGFB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 00:01:29 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1JBk76-00063M-HV; Sun, 06 Jan 2008 21:01:28 -0800
Mail-Followup-To: Jay Soffian <jaysoffian@gmail.com>,
	Jon Hancock <redstarling@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <76718490801061905k30c1ac86r51a65165d47807d4@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69760>

On Sun, Jan 06, 2008 at 10:05:34PM -0500, Jay Soffian wrote:
>On 1/6/08, Jon Hancock <redstarling@gmail.com> wrote:
>> Additionally, is there
>> a simple procedure with git to say: "I want to version exactly what is
>> in my working tree.  If I removed something or added something, just
>> handle it".
>
>>From http://www-cs-students.stanford.edu/~blynn/gitmagic/ch05.html#id2553633
>is the helpful hint:
>
>$ git-ls-files -d -m -o -z | xargs -0 git-update-index --add --remove

As long as your git is new enough to have git-add -u, you should be able to
do:

   $ git add .
   $ git add -u

and have the index match the working tree (keeping excludes out).

Dave
