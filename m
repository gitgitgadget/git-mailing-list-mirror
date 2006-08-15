From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/9] gitweb: Great subroutine renaming + task separation into subroutines + improvements
Date: Mon, 14 Aug 2006 17:42:10 -0700
Message-ID: <7vbqqmbzj1.fsf@assigned-by-dhcp.cox.net>
References: <200608140202.46160.jnareb@gmail.com> <ebpjt8$5ao$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 02:42:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCn13-0005bV-5V
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 02:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWHOAmc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 20:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWHOAmb
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 20:42:31 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:53899 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965022AbWHOAmM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 20:42:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815004211.WBQD2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 20:42:11 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebpjt8$5ao$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	14 Aug 2006 12:40:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25431>

Jakub Narebski <jnareb@gmail.com> writes:

> Jakub Narebski wrote:
>
>> This series of patches is based on the 'next' branch, commit
>> 10a6653c818f78c6032d45e1d4da544085e1f28b (v1.4.2-g10a6653)
>
> But it rebases without problem on top of current master
>   460cccd3ba1d38fd64c9e83e40d58bcf3e9d7d2c (v1.4.2-g460cccd)
> ('git rebase --onto master next' rebases without errors)

I sent a few comments, some suggesting further improvements and
others expressing my puzzlement, but I'll be applying all of
them, so please base your further work on all of the 9 series.
