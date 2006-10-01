From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] Move code resolving packed refs into its own function.
Date: Sun, 1 Oct 2006 06:06:32 +0200
Message-ID: <200610010606.32561.chriscool@tuxfamily.org>
References: <20060930220158.d331bb7c.chriscool@tuxfamily.org> <7vmz8hccxl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 06:00:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTsV5-0004gL-7q
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 06:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbWJAEAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 00:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbWJAEAM
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 00:00:12 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:62102 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751868AbWJAEAJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 00:00:09 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 79EF86CF59;
	Sun,  1 Oct 2006 06:00:05 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7vmz8hccxl.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28169>

Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This patch move Linus' packed refs resolving code from
> > "resolve_ref" into a new "resolve_packed_ref" extern
> > function so that it can be reused when needed.
>
> I think we are stepping on each other's toes.  How far into the
> process of making correct branch deletion are you?

I am not farther than the 2 patches I sent yesterday (before going to bed).

Now I will probably add a few more test cases and see what needs to be done 
for tags. Tell me when you have finished with branch deletion so I can see 
what I can do in this area.

Thanks,
Christian.
