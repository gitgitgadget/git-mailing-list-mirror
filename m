From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 2/7] add push line in git-clone
Date: Wed, 14 May 2008 17:20:52 +0200
Message-ID: <482B0354.2060207@gnu.org>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org> <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org> <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org> <7vve1yzgfc.fsf@gitster.siamese.dyndns.org> <482018E4.9000908@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 17:22:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwIne-0001fs-7S
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 17:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbYENPU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 11:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbYENPU6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 11:20:58 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:26654 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbYENPU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 11:20:57 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2784320fkq.5
        for <git@vger.kernel.org>; Wed, 14 May 2008 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=e3LfsJKyEGy6A1EYfgZmY0zex2tsgaKsU/BS0vaGOco=;
        b=RdikhVo3D4qDbqVmtOiwxqsfS+LN8wuXgvLYhYOYmQrycgKRNoymfqSA/Pev3IqjUo8wlSjah3b1IpqX1HPU5LA3sTWydAMXbEFTUt6rgOmrWlSq0DwJzRzH7dZ1fVDuOzljRL48OGi75ryAufknFylSbkk3iANIQd/u07ZIWIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=kykbNpIMxPCF+xxsXdq6r7oyyEQ3UJFTY3SvHvpYnPwGZvGHnojh66cXytOTbX1Z+GOUJTe405DWOs4Fs73/HNSDHjPJRVqXanWFofWZP4RYl7EQAbZWLk/+d9crlN7VSfnwdPN/E1gJq4pOKht2Dot8ZG5fRAxW+P0mMJ2f70o=
Received: by 10.125.121.17 with SMTP id y17mr506616mkm.131.1210778454463;
        Wed, 14 May 2008 08:20:54 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id d4sm1517069fga.4.2008.05.14.08.20.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 08:20:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <482018E4.9000908@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82106>

Paolo Bonzini wrote:
> 
>> Used together with [1/7], this change is Ok in a homogeneous environment,
>> but it would break people who use git of different vintage on the same
>> repository (think of a repository on a networked filesystem).  You clone
>> like this, and older git won't grok the push configuration anymore.
>>
>> It may look a very minor point, but I think it deserves mentioning.
> 
> I think it is reasonable to require cloning with the 
> least-common-denominator version in this case.  Think of what happened 
> if the pack format changed.

Any news on this (and on 1/7, which is in pu)?

Paolo
