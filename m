From: Esko Luontola <esko.luontola@gmail.com>
Subject: Re: [RFC 1/8] UTF helpers
Date: Wed, 13 May 2009 22:31:19 +0300
Message-ID: <4A0B2007.70808@gmail.com>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>	<1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>	<alpine.DEB.1.00.0905130215260.27348@pacific.mpi-cbg.de>	<200905130724.44634.robin.rosenberg@dewire.com>	<4A0A91CE.3080905@gmail.com> <7vljp04z6j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 21:32:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4KBD-00039Z-Fi
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 21:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbZEMTba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 15:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbZEMTba
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 15:31:30 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:35285 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbZEMTb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 15:31:29 -0400
Received: by ewy24 with SMTP id 24so1050638ewy.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=d/NTxWkW5GQCEy1qFVXQdcm4vX+DgdIeEGzPFzBm4V4=;
        b=L4fzHThS5MdgN5Vs/oFDeIWg2tD7YUyDt5D/v/NohpcSTQi3ayaEzsTsiNuPR7Vvu2
         UdjwJJkouWxb6gtEl9DvPG7jQVI/XW+4eCGv0yPE0m5dlwb6PGsAEg/KLGlgw9wwaKsh
         HkrGWo580E7rpBqJYiZCTu1iJCNgVj6dyKcaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=a2NyLu7rL1YA6IuJvsGmIg4Ts6L+PjPiMERKrCdrHEWOkh+4pa+yVl+9rKcumvCuMI
         aFleYmczLBMFH8l2ntZqpsfU8EhKgWe6h9jrZ3RkCZuIFSur8zlWt87vWnfWVNmFvAAY
         COoRqCSIuOqMyU56PmlmdC3uoCcChW0IyQ5SA=
Received: by 10.216.13.74 with SMTP id a52mr582299wea.145.1242243089306;
        Wed, 13 May 2009 12:31:29 -0700 (PDT)
Received: from ?10.0.0.2? ([88.195.117.100])
        by mx.google.com with ESMTPS id 28sm580269eyg.14.2009.05.13.12.31.28
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 12:31:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vljp04z6j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119090>

Junio C Hamano wrote on 13.5.2009 21:48:
> If you allow people to record otherwise exactly the same tree object in
> different encoding, like you seem to have in mind, subtree comparision
> based on the object name will not work and you will end up always
> traversing down to the tip, because you won't know if your subtrees need
> filename iconv until you recurse into them and actually take a look.

Could you please educate me, that which operations depend on "doing 
subtree comparisons based on the object name", and in about which 
files/functions those comparisons are done? Also, do you mean by "object 
name" the SHA1 of the object, the filename of a file/directory, or 
something else? I'd like to know, which parts of the code I should read, 
to get a better mental model on how Git works.

-- 
Esko Luontola
www.orfjackal.net
