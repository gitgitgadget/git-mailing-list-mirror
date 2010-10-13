From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 04/21] notes.c: Reorder functions in preparation for
 next commit
Date: Wed, 13 Oct 2010 17:20:19 -0500
Message-ID: <20101013222019.GA9509@burratino>
References: <1286586528-3473-1-git-send-email-johan@herland.net>
 <1286586528-3473-5-git-send-email-johan@herland.net>
 <7vy6a1hhya.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	bebarino@gmail.com, avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:23:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P69jj-0002YN-D2
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436Ab0JMWXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 18:23:45 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41484 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab0JMWXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 18:23:45 -0400
Received: by gxk6 with SMTP id 6so1205669gxk.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=M64d9G58i40txFpqH3OTyHui0IT5v6abfATQ5EFdFcM=;
        b=GD76BreQ98ayvfg7s+UWxOv/VJBQKQ9/gJd6EHzuzOqOUbty/+6iPR8cFusorcmuy8
         UpmyY6ZuTUS2HTqN6UcdaYIYaeN1e3f6OtbPcj8azcuNm7eJMIjc7T6MqT8OwIcarghL
         0+/tbcPZFYpGYdd72ouqIqrPvaWh0WljjYNB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RDs435+TKOGgn280vz12W2b8a0xNos3Mao3NOhgwuBfmH9Z2wAQHmuuPTdRIWJS3L8
         Mt9rNiP+xY2nLGumbQqx6TAuQyL3/ssmiaYDh1LOu6cKPLb1lOGQLa8EyaUUK5Pu0kZD
         IohdT4Z9NcBJ2udBygMcXHOafDd9kxqgfUkec=
Received: by 10.150.196.10 with SMTP id t10mr1859225ybf.27.1287008624268;
        Wed, 13 Oct 2010 15:23:44 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id v3sm8500931yba.2.2010.10.13.15.23.42
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 15:23:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vy6a1hhya.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158993>

Junio C Hamano wrote:

> What is this series based on?

e93487d, if I remember correctly.
