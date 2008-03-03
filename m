From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFC] git reset --recover
Date: Mon, 3 Mar 2008 17:02:43 +0000
Message-ID: <20080303170242.GA30361@hashpling.org>
References: <46dff0320803030659j2fa0325lf9c88b915ddb70da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:03:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWE4Y-000728-DG
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 18:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbYCCRCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 12:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYCCRCw
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 12:02:52 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:46178 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbYCCRCv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 12:02:51 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JWE3v-0001MY-JH; Mon, 03 Mar 2008 17:02:51 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m23H2hYt001373;
	Mon, 3 Mar 2008 17:02:43 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m23H2hHd001372;
	Mon, 3 Mar 2008 17:02:43 GMT
Content-Disposition: inline
In-Reply-To: <46dff0320803030659j2fa0325lf9c88b915ddb70da@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: 5ad8377510ae05c12a2f9d28e80b8913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75946>

On Mon, Mar 03, 2008 at 10:59:14PM +0800, Ping Yin wrote:
> 
> but i fogot to type "git init" which results that file1 and file2 are
> added to index of foo repository. I tried to revert the operation
> using "git reset". And the tragedy happened at that time because i
> made so fatal  a mistake that i typed "git reset --hard". And i lost
> all my files in bar dir!

If they've been added to the index then the objects should be in your
git repository, it's just that it may be hard to find them.

Does 'git fsck' report some dangling blobs?  If so (some of) them
should be the content of your missing files.

