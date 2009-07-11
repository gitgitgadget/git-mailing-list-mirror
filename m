From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Show current SHA1
Date: Sat, 11 Jul 2009 12:55:17 +0300
Message-ID: <874otjlf22.fsf@iki.fi>
References: <9586f3420907110239nbc35aealb473e1f1b3667410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Allan Kelly <allankelly@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 11:56:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPZJY-0002mr-FN
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 11:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbZGKJzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 05:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197AbZGKJzY
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 05:55:24 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:57448 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987AbZGKJzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 05:55:23 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 49F6055A029F30A2; Sat, 11 Jul 2009 12:55:18 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1MPZIb-0001N8-Co; Sat, 11 Jul 2009 12:55:17 +0300
In-Reply-To: <9586f3420907110239nbc35aealb473e1f1b3667410@mail.gmail.com>
	(Allan Kelly's message of "Sat, 11 Jul 2009 10:39:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123107>

On 2009-07-11 10:39 (+0100), Allan Kelly wrote:

> The question then is: what is the command to report the current SHA1?
> Note I never branch in the HTML repo, it's entirely linear.

If the "current SHA1" means "the SHA1 of the most recent commit in the
current branch" then usually

    git show

is the simplest way. There are many ways to print _only_ the SHA1.
Examples:

    git log -1 --pretty=format:%H
    git rev-list -1 HEAD
