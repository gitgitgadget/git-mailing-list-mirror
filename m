From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git-am failed, what's next ?
Date: Thu, 22 Feb 2007 11:50:02 +0100
Message-ID: <38b2ab8a0702220250v2c2ca77fub95b1e9a2a57bd78@mail.gmail.com>
References: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com>
	 <7v8xeqh6bj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 11:50:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKBWn-0002mD-D6
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 11:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbXBVKuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 05:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXBVKuH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 05:50:07 -0500
Received: from qb-out-0506.google.com ([72.14.204.238]:14160 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbXBVKuF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 05:50:05 -0500
Received: by qb-out-0506.google.com with SMTP id d11so74661qbd
        for <git@vger.kernel.org>; Thu, 22 Feb 2007 02:50:03 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hH7dMWM2ENNJjlV+vtpISpj4Ewx7b3FRO607oNxi77CHxsFwxi2kqUMyYacYFsUxoVqbfLGjWrNpirMUSbh3UXYwmim/h4eHAyCTovxpw1p+eBmVv6iImFgS2W4L8hoprs84t7/g+vS+kxZHs3JH/3lafIvOAPkY67hvmDS/BZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nrace0mX7jXjDRbouBqO7lg6x4kCXd86BBYGMz8Ii4m600fNS+b3KpgHBcZ06WEZeXpmyJ2IUJxa54HiaIRqFn99dlTOmZJTOCi1Yme9xjLAaEzBUf9ECMDF80n97fno1C+m6D/iytr14Nyw5ISuwPIhnlYO0ajvjV1SG991DmI=
Received: by 10.114.173.15 with SMTP id v15mr202157wae.1172141402066;
        Thu, 22 Feb 2007 02:50:02 -0800 (PST)
Received: by 10.115.47.14 with HTTP; Thu, 22 Feb 2007 02:50:02 -0800 (PST)
In-Reply-To: <7v8xeqh6bj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40347>

Junio C Hamano wrote:
> 	$ git am -3
>
> This can result in one of three things:
>
>  * It can complain, with "Patch does not record usable index
>    information".  When this happens, you are back to square-one.
>    Your repository does not have enough blobs for it to fall
>    back on 3-way merge.  The operation did not change anything
>    in your working tree nor what are in .dotest/ directory, so
>    it did not do any further harm.  You have to use one of the
>    two strategies described above instead.
>

BTW, in this case I got the following error message:

fatal: sha1 information is lacking or useless (foo).
Patch does not record usable index information.
Cannot fall back to three-way merge.
Patch failed at 0001.

which is hard to understand, whereas your explanation:

Your repository does not have enough blobs for it to fall
back on 3-way merge.

sounds better and easier to understand to me...
-- 
Francis
