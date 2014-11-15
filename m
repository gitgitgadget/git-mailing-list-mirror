From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git push --all --tags
Date: Sat, 15 Nov 2014 18:58:36 +0300
Message-ID: <20141115185836.103fc4f493ad55725eab38f0@domain007.com>
References: <loom.20141115T054352-272@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ryan Jacobs <ryan.mjacobs@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 16:59:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpfkL-0005Q7-Lm
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 16:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbaKOP6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 10:58:41 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:60546 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbaKOP6l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 10:58:41 -0500
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	(authenticated bits=0)
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id sAFFwa5N007331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 15 Nov 2014 18:58:37 +0300
In-Reply-To: <loom.20141115T054352-272@post.gmane.org>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 15 Nov 2014 04:44:19 +0000 (UTC)
Ryan Jacobs <ryan.mjacobs@gmail.com> wrote:

> $ git push --all --tags
> error: --all and --tags are incompatible
> 
> Why are these flags incompatible? Just wondering 'cause I think that
> it would be a good feature to be able to push all of your branches
> and all of your tags to the server in one quick and simple command.

  git push --mirror

should do this.
