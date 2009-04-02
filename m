From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 6/8 v2] sh-tools: add a run_merge_tool function
Date: Wed, 1 Apr 2009 22:33:46 -0700
Message-ID: <20090402053345.GA4185@gmail.com>
References: <1238400684-14881-1-git-send-email-davvid@gmail.com> <885649360903311115o6131988emdcba6ef215ec0ab0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 07:35:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpFaR-0005Qj-0n
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 07:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbZDBFeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 01:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbZDBFd7
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 01:33:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:48975 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbZDBFd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 01:33:58 -0400
Received: by wa-out-1112.google.com with SMTP id j5so289824wah.21
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 22:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OxWnNMWQSnbYXQ0Nurmbm3SdCE0UUR7LQfxgIUSumKY=;
        b=e1ANO0S9A1LcntxtgYT25YV2orrNEi7ZC+DEbqqrrUqxO3hpuyqG067b9qWyjTkPbN
         IL0dPCXUzACTrV9L9+Rd4am87EeAMgsf33xU6SP7SKfuOI6kno6BOtvKzJI5/gSd+Wb8
         obm1XvMH6xn4MuaqY+klpn08/btBp8TJPH2F4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DAaMNLekNoxXmPEKASVtTNt/jm03HdLcg2F3fhPpFmDHZ6dO4MXzopeuEYcMjUdQmG
         obDoJX4xHryYwfyLVNf3DKEDjECsV7nEconoSjisbKYJ7QFGMY5FqKJ5EXV8ZNG0CUDt
         EiTl6RtpQFiNev7m5/Jd7ULJvuQXbf9yrkDhI=
Received: by 10.114.95.1 with SMTP id s1mr5702550wab.50.1238650436351;
        Wed, 01 Apr 2009 22:33:56 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n33sm747239wag.53.2009.04.01.22.33.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 22:33:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <885649360903311115o6131988emdcba6ef215ec0ab0@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115444>

On  0, James Pickens <jepicken@gmail.com> wrote:
> On Mon, Mar 30, 2009 at 1:11 AM, David Aguilar <davvid@gmail.com> wrote:
> > This function launches merge tools and will be used to refactor
> > git-(diff|merge)tool.
> 
> Thanks for writing difftool; I find it quite useful.  I tried it with
> tkdiff, and noticed that it shows the 'merge preview' window even though it
> isn't doing a merge.  If a user with unstaged changes were to carelessly
> click the 'save and exit' button, his changes could be lost.  So I think
> it's a good idea to stop the merge preview window from showing up under
> difftool.  To do that I think you just have to remove the '-o "$MERGED"'
> option to tkdiff.
> 
> James

Hi James

I included your suggestion in my latest patch series.
Once things settle down with the current series I'll
add diffuse to {diff,merge}tool and friends.

So, yup, this shouldn't be an issue in future versions of
difftool.

Thanks

-- 

	David
