From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: more merge strategies : feature request
Date: Thu, 04 Dec 2008 06:27:17 +0900
Message-ID: <20081204062717.6117@nanako3.lavabit.com>
References: <ee2a733e0812021707i82049eai866035aef3386264@mail.gmail.com>
 <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com>
 <4933AC03.6050300@op5.se>
 <ee2a733e0812011849l1b319c96u9abbb4e8dd4f53ce@mail.gmail.com>
 <81bfc67a0812020546o79906a20jcd04bd42d18dd803@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Caleb Cushing" <xenoterracide@gmail.com>, git@vger.kernel.org
To: "Leo Razoumov" <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:29:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7zHj-0005xc-Lg
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 22:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbYLCV2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 16:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYLCV2D
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 16:28:03 -0500
Received: from karen.lavabit.com ([72.249.41.33]:55415 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742AbYLCV2B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 16:28:01 -0500
Received: from a.earth.lavabit.com (a.earth.lavabit.com [192.168.111.10])
	by karen.lavabit.com (Postfix) with ESMTP id 40DCAC7AF2;
	Wed,  3 Dec 2008 15:28:00 -0600 (CST)
Received: from 7795.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id UWHT3J3BHUET; Wed, 03 Dec 2008 15:28:00 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=mxLzCP4WrBMWu7+VeUzwwp7epYfOe7W2D43iWXz1+2F9I0eDtV5HC6MaAD/YmOl8MhBDp82+aRdSE1foSpVOMVqrTDqyl6NZG+j3INVEw5uSbNLdgwJea+9q7JgaRdL9r7nmaXxNlkvhO6RSTZRyt/CSpWbwV2PBJ0vm5Zslpc4=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <ee2a733e0812021707i82049eai866035aef3386264@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102291>

Quoting "Leo Razoumov" <slonik.az@gmail.com>:

> On 12/2/08, Caleb Cushing <xenoterracide@gmail.com> wrote:
>> > I guess that "no-overwrite" can be achieved by
>>  >
>>  >  git merge -s ours --no-commit
>>
>> no it doesn't. which is why I called it a bad name. no-overwrite would
>>  still add new lines to the file not in ours (and no-commit isn't
>>  needed in that case) it just wouldn't overwrite conflicting lines, my
>>  understanding of ours is that it will keep the files as is.

Isn't what Caleb wants "-X ours/theirs" per-hunk option for merge strategy backends?

It was discussed several months ago on the list and was rejected.  For details you can start here:

    http://thread.gmane.org/gmane.comp.version-control.git/89010/focus=89021

I still think the patch in the above link was reasonable, but the thread was distracted into discussing minor syntactical details of how the option gets passed to the backend, and the rest of the discussion to decide if it makes sense to add such a feature was unfortunately lost in the noise and never concluded.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
