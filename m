From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why gitweb commitdiff NO diff output ?
Date: Mon, 09 Oct 2006 19:13:43 -0700
Message-ID: <7v1wpgapew.fsf@assigned-by-dhcp.cox.net>
References: <4b3406f0609280032y77cb5961i220b3cfd741ebfd4@mail.gmail.com>
	<eft8u4$un0$2@sea.gmane.org> <20061003095250.GJ2871@admingilde.org>
	<7vwt7hnvsk.fsf@assigned-by-dhcp.cox.net>
	<4b3406f0610080122r17a10ea4h2c71a399fb8398a@mail.gmail.com>
	<7v64et9fjq.fsf@assigned-by-dhcp.cox.net>
	<4b3406f0610091851i593f3e53v5d5fef891edb6d48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 04:13:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX77r-0005qY-Re
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 04:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWJJCNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 22:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWJJCNp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 22:13:45 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:47814 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751293AbWJJCNo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 22:13:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010021344.WTJS12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 22:13:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YSDm1V00u1kojtg0000000
	Mon, 09 Oct 2006 22:13:47 -0400
To: "Dongsheng Song" <dongsheng.song@gmail.com>
In-Reply-To: <4b3406f0610091851i593f3e53v5d5fef891edb6d48@mail.gmail.com>
	(Dongsheng Song's message of "Tue, 10 Oct 2006 09:51:10 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28594>

"Dongsheng Song" <dongsheng.song@gmail.com> writes:

> NO.
>
> When I change the repository's owner to gitweb process,  no diff output yet.
>
> $ chown -R www-data:www-data  cauchy/ gcc/ mph/
>
> 2006/10/10, Junio C Hamano <junkio@cox.net>:
>> The site does not return any of these four blobs that are part
>> of the commitdiff when a=blob is requested on them.
>>
>>         file:a34d77e47bf1561db1ade4f6b247598b880f80d5 ->
>>         file:7625c494df01d4745e67bd4423e2fdbe9fc43799
>>
>>         file:b207fe30a5430f97d27d398d89c974b068694c7a ->
>>         file:57b07ace4bb6352416bbf9436b9f2642b3273257
>>
>> I would first suspect if the repository actually have them _and_
>> with an appropriate mode protection to be readable by your
>> gitweb process.

And does the repository have these four blob objects?
