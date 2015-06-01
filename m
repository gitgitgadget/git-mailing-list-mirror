From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Git-Win: case insensitive names
Date: Mon, 1 Jun 2015 20:42:53 +0300
Message-ID: <20150601204253.50939487ba6e49feb443343e@domain007.com>
References: <CAFQnHJfK94wG_bpe3OFmd7CyZzLCQFq70QGoMAP8=PchdUVH9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vadim Kramer <vkokielov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 19:43:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzTjq-0002R9-Dr
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 19:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbbFARm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 13:42:57 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:58674 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbbFARm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 13:42:57 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t51Hgr3H009577;
	Mon, 1 Jun 2015 20:42:54 +0300
In-Reply-To: <CAFQnHJfK94wG_bpe3OFmd7CyZzLCQFq70QGoMAP8=PchdUVH9g@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270444>

On Mon, 1 Jun 2015 13:30:19 -0400
Vadim Kramer <vkokielov@gmail.com> wrote:

> Just had to deal with a nasty cross-UNIX/Windows problem.
> 
> Two files in the repository were in the same direcory and had the same
> name differing only by the case of some of the letters.  While
> checking them out, git wantonly confused them (conflated them into
> one) and got confused about them.
> 
> I know it's an outlandish situation.  Still, when git is in a
> case-insensitive file system, it should at least check for this.

What it does it do if you have core.ignorecase set to on?

(And you did tell nothing about your platform and your Git version.)
