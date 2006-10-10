From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why gitweb commitdiff NO diff output ?
Date: Mon, 09 Oct 2006 17:32:09 -0700
Message-ID: <7v64et9fjq.fsf@assigned-by-dhcp.cox.net>
References: <4b3406f0609280032y77cb5961i220b3cfd741ebfd4@mail.gmail.com>
	<eft8u4$un0$2@sea.gmane.org> <20061003095250.GJ2871@admingilde.org>
	<7vwt7hnvsk.fsf@assigned-by-dhcp.cox.net>
	<4b3406f0610080122r17a10ea4h2c71a399fb8398a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 10 02:49:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX5Xf-0002bK-UU
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 02:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbWJJAcL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 20:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbWJJAcL
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 20:32:11 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:4295 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751930AbWJJAcK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 20:32:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010003210.SKSD22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 20:32:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YQYC1V00i1kojtg0000000
	Mon, 09 Oct 2006 20:32:13 -0400
To: "Dongsheng Song" <dongsheng.song@gmail.com>
In-Reply-To: <4b3406f0610080122r17a10ea4h2c71a399fb8398a@mail.gmail.com>
	(Dongsheng Song's message of "Sun, 8 Oct 2006 16:22:23 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28588>

The site does not return any of these four blobs that are part
of the commitdiff when a=blob is requested on them.

        file:a34d77e47bf1561db1ade4f6b247598b880f80d5 ->
        file:7625c494df01d4745e67bd4423e2fdbe9fc43799

        file:b207fe30a5430f97d27d398d89c974b068694c7a ->
        file:57b07ace4bb6352416bbf9436b9f2642b3273257

I would first suspect if the repository actually have them _and_
with an appropriate mode protection to be readable by your
gitweb process.
