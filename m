From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: Bug report: .gitattributes: -diff Unset causes files to be reported
 as binaries
Date: Thu, 02 Jul 2009 13:29:30 +0200
Message-ID: <4A4C9A1A.10206@gmail.com>
References: <200907011208.35397.fenglich@fastmail.fm> <200907021014.06540.fenglich@fastmail.fm> <4A4C961C.6090503@gnu.org> <200907021329.04258.fenglich@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Frans Englich <fenglich@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Jul 02 13:29:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMKU0-0005fi-Pz
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 13:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbZGBL3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 07:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbZGBL3a
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 07:29:30 -0400
Received: from mail-ew0-f215.google.com ([209.85.219.215]:62647 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbZGBL33 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 07:29:29 -0400
Received: by ewy11 with SMTP id 11so31305ewy.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=rbKEGFDOHLIypnyqMwHnPQ3Al8o1dNDS1btY/gRoChg=;
        b=lfFV9HU0slMrtOOrJi/h8gwQ3mGkwVXFqFphCfFigvVQrC3LcC18TKn4IQ2Kxe1RCC
         bBShkV3BSLLeFN6f6u3eLpDQObhSF46vyAQMRyetEELDmPB3aQC09PzFUPvdKbhSOeX4
         +m1RIOMYyodb+o9P2GYv66cy43F28TFQ9Jg4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=wX6oL7OESBfvQzgy4S5b6t75sGpAcAsiuxxZ5N+Rw0W5WLtKgLZCKIip6qdMacF2F2
         J/MZbCRd4/FktGsqvq3JUqBHicuVtISjTlpIkiofupacUgD0O1SAMojxuiPJiytC62fF
         YSbMFuUMtljHn80Kl7DkVBcxzNU6iKOpmsciE=
Received: by 10.210.116.14 with SMTP id o14mr297618ebc.39.1246534172276;
        Thu, 02 Jul 2009 04:29:32 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 7sm1873247eyg.47.2009.07.02.04.29.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 04:29:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <200907021329.04258.fenglich@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122635>


>>> If -diff affects whether a file is treated as a binary, as opposed
>>> whether it's diff'ed, it would imo make sense to call it -binary.
>> No, diff affects how a file is diffed.  The particular setting "-diff"
>> diffs the file as if it was binary.
>
> Aha, then we're maybe at conclusion; if -diff doesn't cause the files to be
                                                 ^^^^^^^

???

> treated as binaries

Reread carefully.

1) There is no "-diff" attribute.  There is a "diff" attribute that 
affects *how* (not *whether*) files are diff.

2) A "-" in front of an attribute unsets the attribute.

3) The "diff" attribute, when unset, treats the file as binary.

ergo

4) Using "-diff" in .gitattributes treats the final as binary.

Paolo
