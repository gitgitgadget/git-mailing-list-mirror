From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: Instead of rebasing, etc....?
Date: Mon, 10 May 2010 13:33:22 +0530
Message-ID: <87ljbsdvzp.fsf@hariville.hurrynot.org>
References: <loom.20100507T003055-527@post.gmane.org>
	<loom.20100507T004928-336@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 10 10:39:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBOVv-0007A1-3N
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 10:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497Ab0EJIiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 04:38:54 -0400
Received: from lo.gmane.org ([80.91.229.12]:44539 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753364Ab0EJIix (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 04:38:53 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OBOVn-00077l-69
	for git@vger.kernel.org; Mon, 10 May 2010 10:38:51 +0200
Received: from 117.192.138.218 ([117.192.138.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 May 2010 10:38:51 +0200
Received: from harinath by 117.192.138.218 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 May 2010 10:38:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 117.192.138.218
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:LNws7jW9Ic5IvTkmzNKIqPIIa14=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146773>

Hi,

Dave Abrahams <dave@boostpro.com> writes:

> Dave Abrahams <dave <at> boostpro.com> writes:
>
>> I often find myself pursuing a development branch ...
>
> Sorry, my ASCII art was messed up in the previous message.  
> Here's what I meant:
>
> o-o-o-o origin/dev
>    \
>     o-o-o dev
>
>
> o-o-o-o - -o origin/dev dev
>    \      / 
>     o-o-o 

You can use the 'ours' merge strategy.

On the 'dev' branch, you do

   git merge -s ours origin/dev

Now 'origin/dev' is a parent of the new 'dev', while the tree contents
haven't changed.  You can now push 'dev' back to origin without any
hassles.

- Hari
