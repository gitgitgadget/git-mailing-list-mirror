From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH] contrib: Add update-http-moderated hook
Date: Wed, 21 Jul 2010 06:37:10 -0400
Message-ID: <20100721103710.GA2122@localhost.localdomain>
References: <1279675387-15280-1-git-send-email-public_vi@tut.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 12:37:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObWgA-0000n6-09
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 12:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163Ab0GUKhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 06:37:17 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34570 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab0GUKhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 06:37:16 -0400
Received: by vws14 with SMTP id 14so1468530vws.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 03:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RxE2M6yrzXKAOpSYZjPESso519fPrpv0eoW163agp1o=;
        b=fwVOq5t+rvT6Fy99C7bPIKG7Ff5JgAFpBbvI2nHKjC1yR8nXoXJeT4ko41CMPEU/zl
         QkZ/AraakFEOZAlP0yaEguXhdse1FYSDWRUbbHBMJagA4BQI5XplYFVN+azYbPYaTsm1
         0ZpfA3h73tizytYPH/mwTcxkMmCUwrId7bm/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GSxUnmMqtMmChhUqjOOZGWmnxfTSD2AsPmBFpSbgPmMLgHfYS9Jh6nb4ghVQOcFRS6
         M7itiNQ0vc4JtTODm+OBVc7lNy1tZmSLPs+easpDNdbUz01vyn3biPr7jCGvElKPEyuU
         hcQ5qypvgMTa7C3P3OZr0CcMKE0Gyn3V9Hwe0=
Received: by 10.224.34.210 with SMTP id m18mr6656335qad.301.1279708634546;
        Wed, 21 Jul 2010 03:37:14 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id j28sm29202082qck.23.2010.07.21.03.37.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 03:37:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279675387-15280-1-git-send-email-public_vi@tut.by>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151392>

On Wed, Jul 21, 2010 at 04:23:07AM +0300, public_vi@tut.by wrote:
> +#           Require User mod

> +if [ "$REMOTE_USER" == "mod" ]; then exit 0; fi

Perhaps, for easier configurability, you should at the very least have
a variable at the top such as GIT_MOD_USER=mod in case the users of
this script want to change it at some point.
