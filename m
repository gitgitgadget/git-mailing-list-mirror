From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Additional fast forward strategies.
Date: Tue, 11 Mar 2008 22:03:19 -0800
Message-ID: <402c10cd0803112303r4eb7c98fgf129c1387fdf55f6@mail.gmail.com>
References: <402c10cd0803102004x7892f01cledfef6f277fba26a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 07:04:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZK4G-0005IX-Sr
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 07:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbYCLGDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 02:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbYCLGDV
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 02:03:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:61974 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbYCLGDV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 02:03:21 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2739926fga.17
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 23:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IXujuXuXaBwlqC10k1C3PPqlUyDrw7pm+NdAkdfZ87w=;
        b=v1W2jPlva+9oopir9jSg1/Jcw0KZgMGKNbx4TtNFue0AqJEk2WcUCw3GKERl4DCcEy0riShvnRkD/n8R9FQnwRUymxPh4hjMy8Xmjecx6o6gok7uryyB81uhM2/GABSIpaPcwA89GiVGgS9ZfOBVvbwjMQBloATFJVI0OYD++do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gYFIcG5LsFHNiLijpEklvlp23GmrSZFsG3jxaX9OD4+qYE6DVOBZsfutVIA8hessCGvhF8ZHultvZ/7XHWGagaoAKmymP9JSxa210aucPBztY9NALS4uXD4CI1nRVj8sCK4YBDRPkL9cC4L7iNwljBWlG1SmsgspOWJBFMtvcQw=
Received: by 10.82.146.10 with SMTP id t10mr18843566bud.6.1205301799481;
        Tue, 11 Mar 2008 23:03:19 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Tue, 11 Mar 2008 23:03:19 -0700 (PDT)
In-Reply-To: <402c10cd0803102004x7892f01cledfef6f277fba26a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76929>

I may drop this patch or at least not prioritize it for now.  I don't
need it and implemented it just for fun.  There are other features
that are fare more important.  The other patch I am working on that
implement "--ff=only" is something I need

-- 
Sverre Hvammen Johansen
