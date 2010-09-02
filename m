From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] parse_object: pass on the original sha1, not the replaced one
Date: Fri, 3 Sep 2010 09:24:07 +1000
Message-ID: <AANLkTikBau2-ggvZa2Zp35gTk_j8JEAY8nyVh3i0-ap7@mail.gmail.com>
References: <20100902211321.18003.34601.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 03 01:24:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrJ8p-0002ZI-Q6
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 01:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629Ab0IBXYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 19:24:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47082 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab0IBXYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 19:24:08 -0400
Received: by ewy23 with SMTP id 23so749510ewy.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 16:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=W9cuuzIKVFv1f7ATRFiB7fsqAIlsM5hEeaa7FFOr85M=;
        b=cQSmJqmKGutM6hdaukbN1OcSnUB06lvAjES700AhUBMGMD1qq2AOH5MPOclAUeiWLl
         xyhXw/W3WT8BA9PjIu81TMEL/IIloKWMfwVAcnP0TNIgUY4llJmSt6KEgTTmAmI1kB9j
         Cldf0eO8B4fATM9yNmwGRdphau/6FL19NGd4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=eQuX+aRrsKsjZFIH6SCLc4bPcLbjc5pc+DrC1o+Hp/wihx8AqEb3aUyYuGcDpY38AH
         axlikiL2BsbqHgW10ot+ew9wxr62hRt3DCEu8uv3IjnBmL7r0qU3aCPIVdAw+2t/KPj9
         04EGSp/2HU4oJAd5fNjbazB7reaP/xW6PaN90=
Received: by 10.216.159.72 with SMTP id r50mr10039329wek.92.1283469847113;
 Thu, 02 Sep 2010 16:24:07 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Thu, 2 Sep 2010 16:24:07 -0700 (PDT)
In-Reply-To: <20100902211321.18003.34601.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155223>

On Fri, Sep 3, 2010 at 7:13 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> Since no one resent the original patch with an improved commit
> message, here is my try.

My bad. I forgot something again. I will think of something to
demonstrate this. By the way, it breaks t6050.14, bisect and
replacements.
-- 
Duy
