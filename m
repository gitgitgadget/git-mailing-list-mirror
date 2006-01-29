From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git commit error on initial (the very first) commit
Date: Sun, 29 Jan 2006 13:16:25 -0500
Message-ID: <20060129181625.GA5540@fieldses.org>
References: <200601292026.54893.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 19:16:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3H6E-0002H4-T9
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 19:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWA2SQ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 13:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWA2SQ1
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 13:16:27 -0500
Received: from mail.fieldses.org ([66.93.2.214]:63957 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751103AbWA2SQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 13:16:27 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F3H69-0002w9-H8; Sun, 29 Jan 2006 13:16:25 -0500
To: Andrey Borzenkov <arvidjaar@mail.ru>
Content-Disposition: inline
In-Reply-To: <200601292026.54893.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15228>

On Sun, Jan 29, 2006 at 08:26:54PM +0300, Andrey Borzenkov wrote:
> May be I do something wrong? What is correct procedure to initially import 
> tree? git 1.1.4
> 
> {pts/0}% git init-db
> defaulting to local storage area
> {pts/0}% git add .
> {pts/0}% git commit -m 'initial import'

It needs to know which paths to update.  Probably you want to include
all the files you added with the "git add", and you can do that just
with -a:

	git commit -a -m "initial import"

should do the job.  The default commit command for me is usually just
git commit -a.

--b.
