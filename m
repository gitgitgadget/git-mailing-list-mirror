From: Junio C Hamano <junio@siamese.dyndns.org>
Subject: Re: [PATCH] Improve usage messages
Date: Thu, 21 Apr 2005 16:02:28 -0700
Message-ID: <7vll7bd98b.fsf@assigned-by-dhcp.cox.net>
References: <20050421124152.A28137F87D@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 00:58:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOkcc-0002uG-TU
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 00:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVDUXCf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 19:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVDUXCf
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 19:02:35 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:36301 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261637AbVDUXCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 19:02:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421230229.EBVR22013.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 21 Apr 2005 19:02:29 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20050421124152.A28137F87D@smurf.noris.de> (Matthias Urlichs's
 message of "Thu, 21 Apr 2005 22:41:52 +1000 (EST)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MU" == Matthias Urlichs <smurf@smurf.noris.de> writes:

MU> Index: diff-tree.c

MU> +static const char diff_tree_usage[] = 
MU> +	"diff-tree [ -r (recurse) | -z (\\0-terminate) ]"
MU> +		"\n\t<tree sha1> <tree sha1>";

I think we already have this, and Pasky's right to say the
(recurse) and (\0-terminate) should not be there.


