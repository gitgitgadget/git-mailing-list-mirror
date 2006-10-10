From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Re: Why gitweb commitdiff NO diff output ?
Date: Tue, 10 Oct 2006 09:51:10 +0800
Message-ID: <4b3406f0610091851i593f3e53v5d5fef891edb6d48@mail.gmail.com>
References: <4b3406f0609280032y77cb5961i220b3cfd741ebfd4@mail.gmail.com>
	 <eft8u4$un0$2@sea.gmane.org> <20061003095250.GJ2871@admingilde.org>
	 <7vwt7hnvsk.fsf@assigned-by-dhcp.cox.net>
	 <4b3406f0610080122r17a10ea4h2c71a399fb8398a@mail.gmail.com>
	 <7v64et9fjq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 04:02:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX6m4-0006LB-OY
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 03:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWJJBvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 21:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWJJBvN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 21:51:13 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:34027 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964906AbWJJBvL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 21:51:11 -0400
Received: by py-out-1112.google.com with SMTP id n25so2581974pyg
        for <git@vger.kernel.org>; Mon, 09 Oct 2006 18:51:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q8d6R5Zs0uYjZSdZRkt78brnc2+YY9hbZS//hJorSeYBQR4Ua3wE3py2M+IR/88zoW5kV+3pD+uPe1+77Wau+w1N80umKdXMdSXUwizufYEcUhoIUHmLZf+a92oZ14XjOBNgYt2QPMzcTvF8jk+UruqNRRPE2YUZl6tod7dtaUo=
Received: by 10.35.76.9 with SMTP id d9mr1937426pyl;
        Mon, 09 Oct 2006 18:51:10 -0700 (PDT)
Received: by 10.35.106.3 with HTTP; Mon, 9 Oct 2006 18:51:10 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v64et9fjq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28592>

NO.

When I change the repository's owner to gitweb process,  no diff output yet.

$ chown -R www-data:www-data  cauchy/ gcc/ mph/

2006/10/10, Junio C Hamano <junkio@cox.net>:
> The site does not return any of these four blobs that are part
> of the commitdiff when a=blob is requested on them.
>
>         file:a34d77e47bf1561db1ade4f6b247598b880f80d5 ->
>         file:7625c494df01d4745e67bd4423e2fdbe9fc43799
>
>         file:b207fe30a5430f97d27d398d89c974b068694c7a ->
>         file:57b07ace4bb6352416bbf9436b9f2642b3273257
>
> I would first suspect if the repository actually have them _and_
> with an appropriate mode protection to be readable by your
> gitweb process.
>
>
>
>
