From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 13:39:36 +0200
Message-ID: <81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
References: <20070506195230.GA30339@mellanox.co.il>
	 <7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
	 <20070510095156.GC13655@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu May 10 13:39:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm6zm-0003kW-2A
	for gcvg-git@gmane.org; Thu, 10 May 2007 13:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbXEJLji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 07:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755860AbXEJLji
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 07:39:38 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:6821 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173AbXEJLjh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 07:39:37 -0400
Received: by an-out-0708.google.com with SMTP id d18so132327and
        for <git@vger.kernel.org>; Thu, 10 May 2007 04:39:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UAMsPzrwhlFWyVQwLVDdr7bthN4cqHH5Z/bSnPuWSoIK0M8FRQ3RWIO+vBjpNj9WrgwL7fzU/vKOdLLE45yS7aZEsSYw14sF+v8/fVdJyfY4dNidSZcapsIN6G29KlRUe7juZdY/m/QzCIuq+OSV7YTMitAW+/T18mvmdYUKIMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o7hX8yA3zYHTKwCpKNJ7yCjV0vTIAhDGWJdurrmgDs021A4R7s1WDlwnfCtkmmPkP9kNKILb/ZwKlhaXNX1tzQ3sbw+WgSczFtXNd2hU4YDcDs1gBSn4ZFQxYKFv4kn1cZob7mJPai+WmUr+7Nx2sQYzKsPVWNHcE6KmYOWyB9U=
Received: by 10.100.177.16 with SMTP id z16mr1160036ane.1178797176630;
        Thu, 10 May 2007 04:39:36 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Thu, 10 May 2007 04:39:36 -0700 (PDT)
In-Reply-To: <20070510095156.GC13655@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46859>

On 5/10/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> -static int git_tcp_connect_sock(char *host)
> +static int git_tcp_connect_sock(char *host, int flags)

There is only one bit of flags ever used. What are the others for?
Why use negative logic?
What was wrong with plain "int verbose"?
What addresses were tried by connect?
