From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 2/7] add push line in git-clone
Date: Tue, 06 May 2008 10:37:56 +0200
Message-ID: <482018E4.9000908@gnu.org>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org> <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org> <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org> <7vve1yzgfc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 10:38:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtIhA-0002cX-7N
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 10:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbYEFIhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 04:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbYEFIhy
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 04:37:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:59760 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbYEFIhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 04:37:53 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1280946nfc.21
        for <git@vger.kernel.org>; Tue, 06 May 2008 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=n8GvRTykVA9mGm62EjAxypuY6y9rAytajz9xAWqZ5UM=;
        b=EaQuNV8Z+kYdWeirlh2LeBgpwN5DBsIYjpn28cGWUVMPR788E76oTVAePBwQEv9YYv0LSg7SLOCs8hiMF2Ct6SnNPo8ciBRtAdCm3DuVDNO95mtp1mu74sYHITH772ir8zWXXvzKkiCDv8Dd1ItbZFu5w9DKxXsUHWnWMmSw2wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=VlQVcbB2D7yNh99izAQaXOE+D+ciiCg4nEksjELnBWrN0D37bTNoKo25jo2bd/JouZbgDt/gxNPgYHHO64V8xka4NfvCKkPQMrOF3W3qNNCWcUqnc5rocamYKuvRR4+e2ZSr2lqnw3qHuAU0v8/LM0jwxkirs2cIeL5obBb4PLk=
Received: by 10.210.16.16 with SMTP id 16mr440161ebp.41.1210063069632;
        Tue, 06 May 2008 01:37:49 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id s10sm646124muh.10.2008.05.06.01.37.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 May 2008 01:37:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <7vve1yzgfc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81344>


> Used together with [1/7], this change is Ok in a homogeneous environment,
> but it would break people who use git of different vintage on the same
> repository (think of a repository on a networked filesystem).  You clone
> like this, and older git won't grok the push configuration anymore.
> 
> It may look a very minor point, but I think it deserves mentioning.

I think it is reasonable to require cloning with the 
least-common-denominator version in this case.  Think of what happened 
if the pack format changed.

Paolo
