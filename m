From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 06:52:25 +0200
Message-ID: <4816A989.2010204@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, johannes.schindelin@gmx.de, srb@cuci.nl
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 06:53:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqhq5-0001Wm-NU
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 06:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbYD2Ew0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 00:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbYD2Ew0
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 00:52:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:39900 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbYD2EwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 00:52:25 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2116736nfb.21
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 21:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=MMPar/C0Zkrkou+uqcNJtM8pgMSDTu1J6GoXBWXlnWY=;
        b=BpCplxs7+JGSblZclKqQTdv0DdzVM1SSUu9utMKw6hLD8glsJgLcCO++5nyT16JV1tHuWAcbBtCaQlAvMY1mPrs7cmcXJDnuVJE62XGCCbe118cEM7kVCGWLUwXeBsNP8AIgmUN/P9hR3Kyx8OeKIGZA8PBcp7PrItey8NKgjXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=dsanDsGswN9kIsYrRDGLaNbioBZG6JHG4nQGu37t02WgKcBt5HhfVp8FuR7pC0YX6ahpc9z+7lrtMzW8PH2ZxzDIQwLfZfcdwcBKKOuK4pFg6LAsFGP7bdwjNNDCYwEG4TGjtk44PlpX73cGjNCAjb+XoXx5d3fMkgvQGe6rOsI=
Received: by 10.210.133.2 with SMTP id g2mr6790387ebd.47.1209444744472;
        Mon, 28 Apr 2008 21:52:24 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id j10sm10587759mue.14.2008.04.28.21.52.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Apr 2008 21:52:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <20080428213339.GC10600@steel.home>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80645>

Alex Riesen wrote:
> Paolo Bonzini, Mon, Apr 28, 2008 20:19:48 +0200:
>>> my v4l2
>>> repo (which is a pretty collection of all kinds of remotes)
>> I can add a global boolean configuration to change the default value of  
>> skipDefaultRemote.
>>
> 
> With the default NOT so that current behaviour stays?

No, absolutely.  In fact if I were you I would set skipDefaultUpdate 
*now* on the remotes of that repo.

Paolo
