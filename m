From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Cloning from sites with 404 overridden
Date: Wed, 22 Mar 2006 07:06:13 +0100
Message-ID: <e5bfff550603212206k1924d352xcbdb0e5a11b88a50@mail.gmail.com>
References: <20060322025921.1722.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, spearce@spearce.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed Mar 22 07:06:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLwU7-00057m-Fs
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 07:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWCVGGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 01:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWCVGGP
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 01:06:15 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:27657 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750797AbWCVGGO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 01:06:14 -0500
Received: by wproxy.gmail.com with SMTP id 67so367397wri
        for <git@vger.kernel.org>; Tue, 21 Mar 2006 22:06:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HAmUozHtMHHomlrtLI309ZcoS3VaIrhoSSauaat5084KduuFRl9+7yyxjtlaBbYNAYsZ9/RcfP/Gj0IidOFz+EexN6N2pDZGPaf+jQZH5AhZ0a86loOhZfcBA4DqrImsKPsca71VvSh2Mu+LAFkO5Rqhq1nNTHYXJdvxrlCQ38A=
Received: by 10.64.233.9 with SMTP id f9mr272848qbh;
        Tue, 21 Mar 2006 22:06:13 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Tue, 21 Mar 2006 22:06:13 -0800 (PST)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060322025921.1722.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17807>

On 21 Mar 2006 21:59:21 -0500, linux@horizon.com <linux@horizon.com> wrote:
> If someone feels ambitious, you can detect this condition automatically
> by searching for a file that you know won't be there and seeing if you
> get a 404 response to that.
>

Perhaps I am proposing a total idiocy, I don't know git-fetch
internals, but wouldn't be better to avoid trying to download a non
existing object? So to fix the problem at the origin?

I don't know if it is possible to list contents before try to download
so to avoid asking for a non existing object.

Marco
