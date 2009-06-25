From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Displaying Current Git Aliases
Date: Thu, 25 Jun 2009 19:08:40 +0300
Message-ID: <87prcspa7r.fsf@iki.fi>
References: <c115fd3c0906250859q661d2319i463d6eea7e9dbe54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:10:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJrWr-00040P-6u
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 18:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759039AbZFYQIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 12:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758696AbZFYQIm
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 12:08:42 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:45055 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759204AbZFYQIj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 12:08:39 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 49F5976602268650; Thu, 25 Jun 2009 19:08:40 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1MJrVA-00015c-2w; Thu, 25 Jun 2009 19:08:40 +0300
In-Reply-To: <c115fd3c0906250859q661d2319i463d6eea7e9dbe54@mail.gmail.com>
	(Tim Visher's message of "Thu, 25 Jun 2009 11:59:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122218>

On 2009-06-25 11:59 (-0400), Tim Visher wrote:

> Can git display a list of all of your current aliases like bash's
> `alias` command?

I guess not directly but:

    git config -l | grep ^alias
