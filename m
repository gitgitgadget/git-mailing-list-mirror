From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] blame: show "previous" information in --porcelain/--incremental format
Date: Fri, 6 Jun 2008 17:44:36 +0200
Message-ID: <200806061744.36687.jnareb@gmail.com>
References: <940824.46903.qm@web31808.mail.mud.yahoo.com> <200806061128.04031.jnareb@gmail.com> <7vabhywq2c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 17:45:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4e8F-0007CV-SA
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 17:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbYFFPon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 11:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752941AbYFFPon
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 11:44:43 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:6097 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbYFFPom (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 11:44:42 -0400
Received: by gv-out-0910.google.com with SMTP id e6so384504gvc.37
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=prDLrJ1prcd0g7FseGdYmfnBxQhTSLgUHEJdFY/ZFTI=;
        b=WNcsPc1a/xi/Hxasa15ZSbkCuI6b7FROOrCrBZfkpYyUDotR7eCbhhfcn3H5fjVsdX
         2F9lPw+CGySZoJQtbtV6v20M8foJTrk99Did3nfSdq/swsPpap7EUkVJzKdo65Fh2R6Q
         X0+xgRAGrc1ZVG5PS2JGUXFlwzkRa3DEdprCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VQeYcNXBNuY7KLMnGKX3EIpwevmYOsiipfVjsmffO0WR2QpKqsxyy9HtC3wfCPgSFX
         anuQaim/1rWL1MV5AoqhErqDkuiediwQDU57Iy8YnEPcpxsNTT8w4hInOLPNu7Nxrh0r
         f1EzA50mZG8yi4OwW4yzWj7vz/d2SdQRIEAvI=
Received: by 10.210.22.8 with SMTP id 8mr201295ebv.19.1212767080690;
        Fri, 06 Jun 2008 08:44:40 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.247.141])
        by mx.google.com with ESMTPS id f13sm8340037gvd.2.2008.06.06.08.44.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 08:44:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vabhywq2c.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84083>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> What happens if attributed (blamed) commit is "evil merge"?
>> Would git-blame emit multiple "previous <sha-1 of commit> <filename>"
>> headers?
> 
> Read the code.  There is only one previous pointer in each origin.

Ah. True.

So the question now is: how git-blame choses one parent if commit
which is blamed is an evil merge commit?

-- 
Jakub Narebski
Poland
