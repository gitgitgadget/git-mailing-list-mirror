From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Check that a tag exists using show-ref instead of looking for the ref file.
Date: Tue, 3 Oct 2006 22:11:05 +0200
Message-ID: <200610032211.05847.chriscool@tuxfamily.org>
References: <20061001223304.d37df36f.chriscool@tuxfamily.org> <7vlknxrcja.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 22:05:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUqVV-0003ao-0S
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 22:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWJCUEq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 16:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWJCUEq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 16:04:46 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:64463 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030300AbWJCUEp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 16:04:45 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 67C8D54983;
	Tue,  3 Oct 2006 22:04:44 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7vlknxrcja.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28294>

Junio C Hamano wrote:
> Thanks.  We also need this to avoid refetching already packed
> tags.

Yeah, I did a very quick check on the shell scripts and I obviously missed 
some places that need updates.

In fact, I couldn't resist to start implementing the deleted-refs/$frotz~ref 
stuff we talked about...

Christian.
