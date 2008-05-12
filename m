From: Tim Harper <timcharper@gmail.com>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 12:58:07 -0600
Message-ID: <73584838-DF17-4CDB-92CA-363ED9DA9582@gmail.com>
References: <4827DEF6.1050005@gmail.com> <87ej87is50.fsf@offby1.atm01.sea.blarg.net> <alpine.DEB.1.00.0805121428310.30431@racer> <48285087.3090402@gmail.com> <alpine.DEB.1.00.0805121606010.30431@racer> <20080512152731.GM31039@zakalwe.fi> <alpine.DEB.1.00.0805121804500.30431@racer> <20080512180720.GN31039@zakalwe.fi> <alpine.DEB.1.00.0805121920120.30431@racer> <20080512183615.GO31039@zakalwe.fi> <20080512183803.GP31039@zakalwe.fi>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	bill lam <cbill.lam@gmail.com>, git@vger.kernel.org
To: Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Mon May 12 20:59:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvdEm-00036h-EP
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001AbYELS6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756072AbYELS6O
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:58:14 -0400
Received: from gv-out-0910.google.com ([216.239.58.186]:24898 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622AbYELS6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:58:13 -0400
Received: by gv-out-0910.google.com with SMTP id e6so302218gvc.37
        for <git@vger.kernel.org>; Mon, 12 May 2008 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=jaq4MU+eRVnSfKhTEB4kKWRXSLHx91zFTJC4FrDvEBA=;
        b=cbDpAHv5bB1Wkef9PTLVt2zbYA7S9twMDKByf4HzBP/mQS9IGwGPIaxljDX+JPcXpvK69RhwSZeO/b+5/cbhoZEyVGKztBLN5oa5U1SJr8tpBRfxHlLFrFO2AVBa9GRIdc11ZsxKe3SBS6DotDpRp6A+CWOz7cKfGTlFoCyrOYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=fZfxw8Q05m9dnnrPpamYJ8BoHorldid/XZcagdlwA+5DzsPHFtnRSqEIC02qQGcQWFEu/GsoXx9pVRsdcSvQscRJgh396KXCsJ3fSRwTTPv1Cltbr9cwaKxN3MKF9pHUnuuHoolIxd+KlbpYg07nzaQvR6v319kJrkaOBAfExCo=
Received: by 10.142.240.9 with SMTP id n9mr3403945wfh.214.1210618690864;
        Mon, 12 May 2008 11:58:10 -0700 (PDT)
Received: from ?10.0.1.193? ( [66.182.89.5])
        by mx.google.com with ESMTPS id 30sm18410062wfa.17.2008.05.12.11.58.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 11:58:09 -0700 (PDT)
In-Reply-To: <20080512183803.GP31039@zakalwe.fi>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81908>


On May 12, 2008, at 12:38 PM, Heikki Orsila wrote:

> On Mon, May 12, 2008 at 09:36:15PM +0300, Heikki Orsila wrote:
>> 3. cd today && git fetch /path/to/repo
>
> That was a mistake, a bare fetch is not enough.

Yeah, Heikki - I wonder if you're missing the point.  In our case, we  
don't bother with repository backups here.  Everyone developer has a  
full copy of the repository, and any one of them could be used to  
create a new "central" git repository.  If our central git repository  
goes down - we've got 9 others floating around on different laptops  
and computers.  You can't beat that kind of redundancy.  You'd have to  
nuke Utah to take us out (btw: please don't nuke Utah).

Tim

>
>
> -- 
> Heikki Orsila
> heikki.orsila@iki.fi
> http://www.iki.fi/shd
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
