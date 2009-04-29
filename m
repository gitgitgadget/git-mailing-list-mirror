From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: escape searchtext and parameters for replay
Date: Wed, 29 Apr 2009 15:14:10 +0200
Message-ID: <200904291514.11331.jnareb@gmail.com>
References: <337ECD47-D343-40F2-9E41-9E7D8531C5DF@aepfle.de> <200904291428.46244.jnareb@gmail.com> <0626233F-50D5-4F7E-9009-506FEA77571D@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Wed Apr 29 15:17:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz9ei-0003wt-Dh
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 15:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760616AbZD2NOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 09:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760613AbZD2NOS
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 09:14:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:21881 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760606AbZD2NOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 09:14:16 -0400
Received: by rv-out-0506.google.com with SMTP id f9so883465rvb.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KKQtO2Z2EjgSFno0bp6fQ4TqXc3ZirNhcmrSgj33Q1Q=;
        b=LgxNw7Na3R6AWmdxnWoEyAvwRi/Qe2MUFyxSWgc4iasDmlEPhGIPYZDKWvE9xpmtGx
         m4BOmISUC+dYYJM0ssJFEm4UbNNsLmixrYXdZV9b6VnD3oM+D2gdOXacBXt8P3FLu3YD
         7Gdl6DHe+qTx2lRAk281YwYY0PA+ZMo9OKE2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IxTjBEtkeR6Sv9GZFUlbSfFQvrWHjo7SBs5UQAIpGrs/pK+cZY7dP6pDZWGn6euGOd
         BlVQtKJT8mnzPZdUuqCCV2tCe4cHfx9UKTGTkI7ePUkG4ckU7ZHMtaEQKhs3dssqJgPq
         xlRwNBMQcxVV+FAHittx7SrXmrrhJ4/U34uFY=
Received: by 10.140.157.1 with SMTP id f1mr90129rve.196.1241010856743;
        Wed, 29 Apr 2009 06:14:16 -0700 (PDT)
Received: from ?192.168.1.13? (abwr45.neoplus.adsl.tpnet.pl [83.8.241.45])
        by mx.google.com with ESMTPS id b8sm2281641rvf.4.2009.04.29.06.14.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Apr 2009 06:14:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <0626233F-50D5-4F7E-9009-506FEA77571D@aepfle.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117888>

On Wed, 29 Apr 2009, Olaf Hering wrote:
> Am 29.04.2009 um 14:28 schrieb Jakub Narebski: 
>> On Wed, 29 April 2009, Michael J Gruber wrote:
> 
>>>> It should be s=torvalds%40linux instead of s=torvalds\@linux
>>
>> If you by hand edit URL changing '\@' to simply '@', does changed
>> gitweb URL works correctly?
> 
> I tried akpm@osdl.org, and @ and . was escaped with a backslash.
> Removing both, and using the plain mail address worked.

This problem was fixed in 7e431ef (gitweb: Separate search regexp from 
search text), but this fix is present in git 1.5.2 and later, and 
kernel.org gitweb is a fork (adding caching mechanism) of 1.4.5-rc0,
according to info in git.kernel.org HTML source, and it does not have 
this fix.

  http://git.kernel.org/?p=git/warthog9/gitweb.git;a=summary

I have CC-ed J.H. on this.
-- 
Jakub Narebski
Poland
