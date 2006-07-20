From: "Ben Williamson" <benw@pobox.com>
Subject: Re: [PATCH] Re: git-svn: Missing files
Date: Thu, 20 Jul 2006 15:51:02 +1000
Message-ID: <b6327a230607192251j32cad47epbf3362d4b81ff537@mail.gmail.com>
References: <b6327a230607191902n47b81993x8caea2df3955d8c0@mail.gmail.com>
	 <20060720034841.GA28298@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 20 07:51:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3RRF-0006nS-2w
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 07:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWGTFvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 01:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWGTFvF
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 01:51:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:53489 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030275AbWGTFvE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jul 2006 01:51:04 -0400
Received: by ug-out-1314.google.com with SMTP id o2so638713uge
        for <git@vger.kernel.org>; Wed, 19 Jul 2006 22:51:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=C2x3tuDiMV6m1GqvZvpq7b6wfAkHKa/gT1Zt58jEJO5MSaP120pCHDRntY2mMxV+3DXTr0QdsPx6X/92w6ZiJ0tPv/1KhJeaxq8Az+3sLfsGuihH7D84o8O246tLUgxPJTaFOOSSDrgJR8v1r8tywTkaTgGuWUmOa5t/j4dL0oc=
Received: by 10.78.120.6 with SMTP id s6mr105570huc;
        Wed, 19 Jul 2006 22:51:02 -0700 (PDT)
Received: by 10.78.126.12 with HTTP; Wed, 19 Jul 2006 22:51:02 -0700 (PDT)
To: "Eric Wong" <normalperson@yhbt.net>
In-Reply-To: <20060720034841.GA28298@localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: 883f81b0155cb1eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24019>

On 7/20/06, Eric Wong <normalperson@yhbt.net> wrote:
> Ben, can you please try this patch against the git-svn.perl file in
> master?  You can also find the full patched file here:
>
>         http://git-svn.bogomips.org/git-svn.perl

Just finished, and the results were heaps better, but it seems
package/dhcp/Config.in was still missed. (The others below are empty
directories.)

$ diff -ur --exclude=.git --exclude=.svn svn-export/buildroot
git-svn-fetch-fixed/buildroot
Only in svn-export/buildroot/package/dhcp: Config.in
Only in svn-export/buildroot/package: linux
Only in svn-export/buildroot/target/generic: access_point
Only in svn-export/buildroot/target/generic: firewall

Hey, good enough for me, but then I'm not using dhcp...  ;)

- Ben.
