From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Mon, 22 Jan 2007 23:20:22 +0100
Message-ID: <46d6db660701221420i6f439972h2c6c6146fed78097@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
	 <200701222127.09601.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 23:20:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H97Wc-0002ZX-IC
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 23:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbXAVWUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 17:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbXAVWUY
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 17:20:24 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:30449 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbXAVWUX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 17:20:23 -0500
Received: by an-out-0708.google.com with SMTP id b33so487173ana
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 14:20:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y6foaOgib+cP3ziEtWrFjybzCTvH69LGeiHphN/bM5dJnjkNAqztSmZ3W6sEVpjiueTWNMExNI4dMA1YvAr2MA5NO0FLZldl/L/uLx4HABl9bY1Fk+9pYr+Aiwg4extAbWa3UH5CTHtTFbU6Gr3cOrls3pDzRRyRVfnXqvxqKw8=
Received: by 10.48.48.13 with SMTP id v13mr123242nfv.1169504422050;
        Mon, 22 Jan 2007 14:20:22 -0800 (PST)
Received: by 10.78.183.8 with HTTP; Mon, 22 Jan 2007 14:20:22 -0800 (PST)
To: "Johannes Sixt" <johannes.sixt@telecom.at>
In-Reply-To: <200701222127.09601.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37463>

On 1/22/07, Johannes Sixt <johannes.sixt@telecom.at> wrote:
> On Monday 22 January 2007 14:06, Christian MICHON wrote:
> > One problem I haven't found a solution for though: the date
> > of commit is wrong, always back to epoch (1970???).
>
> I've pushed out a fix for this.
>

it seems to be in the snapshot I just evaluated:
mingw.git-d576539c9255d22425efcc55f7e9720fbb8a42d1

indeed, it's fixed!

I'll run more regressions tomorrow (like the one I posted,
using 117 versions of linux-2.6 kernels).

--
Christian
