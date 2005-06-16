From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PROPOSAL] Add a module (repo-log.c) to log repository events.
Date: Thu, 16 Jun 2005 14:09:29 +1000
Message-ID: <2cfc4032050615210961c4d146@mail.gmail.com>
References: <20050616035924.31808.qmail@blackcubes.dyndns.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jun 16 06:04:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DilcD-00026F-9w
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 06:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVFPEJi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 00:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVFPEJi
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 00:09:38 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:58746 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261730AbVFPEJg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2005 00:09:36 -0400
Received: by rproxy.gmail.com with SMTP id i8so155718rne
        for <git@vger.kernel.org>; Wed, 15 Jun 2005 21:09:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jeq9up/+MRu8VDnifKfpFTT2vCgWegA2r5/axboa3KX+F1FoM9MANooHGiR4nk+lky+qcyLyqf6WA0OUyZSl7aOznkHJNMyJfLiA2W3LQKDklw/XuhSD+Va3UIjlhG5dwuaK9mQGzMB2oEpNiRi8MhVKQ8MZbXi7kCakMqaRjmA=
Received: by 10.38.65.51 with SMTP id n51mr182857rna;
        Wed, 15 Jun 2005 21:09:30 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 15 Jun 2005 21:09:29 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20050616035924.31808.qmail@blackcubes.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A variety of log formats would be possible but the default log format
I intend to use is:

for object events:

     yy-mm-ddThh:mm:ss(+/-)oooo SP object-type SP sha1  LF

for label events:

     yy-mm-ddThh:mm:ss(+/-)oooo SP 'label' SP label LF

The default format uses ASCII text and human readable iso-8601,
locally zoned timestamps so that the logs are easily perused by both
humans and machines.

jon.
