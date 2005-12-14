From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/11] git-applypatch: Usage string clean-up, emit usage string at incorrect invocation
Date: Tue, 13 Dec 2005 21:20:57 -0800
Message-ID: <7vfyow45l2.fsf@assigned-by-dhcp.cox.net>
References: <11345130302438-git-send-email-freku045@student.liu.se>
	<11345130311492-git-send-email-freku045@student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 06:22:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmP5H-0004mB-0h
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 06:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVLNFVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 00:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVLNFVE
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 00:21:04 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49846 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751270AbVLNFVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 00:21:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051214052101.QGFU25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 00:21:01 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13618>

freku045@student.liu.se writes:

>  . git-sh-setup
>  
> +[[ "$#" = "3" || "$#" = "4" ]] || usage
> +

I do not see much advantage to use [[...]] construct here.

	http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_04

talks about [[ ... ]] being "some implementations causing
unspecified results".
