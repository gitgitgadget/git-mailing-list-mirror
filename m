From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 00/13] the refs-transactions-reflog series
Date: Thu, 4 Dec 2014 11:27:20 -0800
Message-ID: <20141204192720.GB16345@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
 <xmqqppbztfzj.fsf@gitster.dls.corp.google.com>
 <CAGZ79ka9swMKvYpSLC20kj0bj=QWS7syVDtQcOmuT5AC3SO+gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:27:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwc3k-0006VM-UJ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 20:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbaLDT1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 14:27:24 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:62290 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbaLDT1X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 14:27:23 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so16367518ieb.40
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 11:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6ZVcCc3oG7zo7gSobHBd04bSZYTOu9fn1tFJTisK9Hk=;
        b=Pes+oLKJQbasUvnc5bBVEtWa4VfT+5FQ7htbaPZgYCyCAJ6x1hiw/mZdIogiXjErMs
         KOA80CdpCDrLvD96kRUYsx8Z3VOA1p10Ua6+mapY1Vj8wFbfqdUl6+PcpqJJ798jqZ8Y
         5O0673A0q35TWrBK1rK6Sje/jYHVq7EdG7eViR8dUqdTXwJOFxnB4VsxX7NNOdgUiToR
         31jKjsIX6ckNqc3fZqBpJ6sEzo+6qM50R8rDsMv16vXnp4jVUBrk2FuLAthYIfzUwzLp
         4erITPftLycei4JPHT0/DOZHIgbB4JDFFVDgQ0dLbVYsd+SPZ62vxubv4ZF2ez8J0WS0
         q0fQ==
X-Received: by 10.42.201.212 with SMTP id fb20mr12749982icb.2.1417721242885;
        Thu, 04 Dec 2014 11:27:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c1ad:3fe5:3da3:c161])
        by mx.google.com with ESMTPSA id c1sm20758849igo.17.2014.12.04.11.27.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 11:27:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79ka9swMKvYpSLC20kj0bj=QWS7syVDtQcOmuT5AC3SO+gw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260785>

Stefan Beller wrote:

> Ok, let's see how Michaels series evolves and if I can base the
> transactions series
> on that

That sounds good to me, too, FWIW.  That way we don't have to fuss
with conflicts in refs.c. :)

Thanks,
Jonathan
