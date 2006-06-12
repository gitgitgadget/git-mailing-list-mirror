From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvs import error
Date: Mon, 12 Jun 2006 12:31:35 +1200
Message-ID: <46a038f90606111731q34fe431fn36d751b387ab69a9@mail.gmail.com>
References: <20060611234842.GA12713@prophet.net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 02:31:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpaLE-00052h-Ke
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 02:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWFLAbg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 20:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWFLAbg
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 20:31:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:14280 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751075AbWFLAbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 20:31:36 -0400
Received: by wr-out-0506.google.com with SMTP id i20so1044685wra
        for <git@vger.kernel.org>; Sun, 11 Jun 2006 17:31:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FeYOMLEy2YHhApH0Iu2oOReRnM0tbiJCx4b9tHRtf2qIIFpTnhRJaLWXejCAt5cxDrxhpy21bb0eGqx0NSqJftQqLZl51ButRc8mwBfa6kF17eXGyqB+Tq/Mrn67ubaq5DssZJ9MS+Qc0jpHRQIZLEtBaYe+Qcw28YJ9GGSzBcg=
Received: by 10.54.91.8 with SMTP id o8mr5065756wrb;
        Sun, 11 Jun 2006 17:31:35 -0700 (PDT)
Received: by 10.54.71.9 with HTTP; Sun, 11 Jun 2006 17:31:35 -0700 (PDT)
To: "carbonated beverage" <ramune@net-ronin.org>
In-Reply-To: <20060611234842.GA12713@prophet.net-ronin.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21677>

On 6/12/06, carbonated beverage <ramune@net-ronin.org> wrote:
> fatal: Not a valid object name HEAD
> checkout failed: 256
> $ exit

After each attempt, the import leaves a .git file around. rm -fr .git
before retrying... or just retry in a new directory every time ;-)

(... we should die with a more helpful message here...)

cheers,


martin
