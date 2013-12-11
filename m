From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] cat-file: handle --batch format with missing
 type/size
Date: Wed, 11 Dec 2013 15:31:21 -0800
Message-ID: <20131211233121.GO2311@google.com>
References: <20131211115458.GA10561@sigill.intra.peff.net>
 <20131211115844.GB10594@sigill.intra.peff.net>
 <20131211204200.GN2311@google.com>
 <20131211231549.GB16606@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Bronson <naesten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 12 00:31:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqtFb-0001mK-59
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 00:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507Ab3LKXb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 18:31:27 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:52077 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3LKXb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 18:31:26 -0500
Received: by mail-yh0-f52.google.com with SMTP id i7so594925yha.39
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 15:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xtVjMG1PT9chrd4q2+Mx9yoQr0FsvRlf3jhsEoWJUhM=;
        b=L1jr+LMQknEvxOD/GXXdSkwYeHN4dzGKkVW8s3P2qzg3dFQeCML2npKolKyQtWTgjE
         clRtpYtjldmocnjNMOAhpw2CA/W2NfEY0OHOFSnxrRGmRt8l5oy4q9Qnk2zUhz6cLeDS
         HShAwpTu4/AoTKUx5SXBlfm81sC88Dm0CZtPSDKXwVgFwogwsUvHdcpH6WjE3nVLmM26
         D7UDi4S78mc6bMVxHwk+SjHmO5hFR4CUEDNGFfCS8ZIA8E8oUN4/eWz+RRT0eNWnbIZZ
         zUyMtNZLsMxWAyZ8sjzfUYt95hoJh+nH70qDBCN3LPLF7i7OpAqmjGsMgQ8shtLcZCQZ
         l7UA==
X-Received: by 10.236.149.176 with SMTP id x36mr3888959yhj.27.1386804685073;
        Wed, 11 Dec 2013 15:31:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id r98sm30995443yhp.3.2013.12.11.15.31.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 11 Dec 2013 15:31:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131211231549.GB16606@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239218>

Jeff King wrote:

> Updated patch is below.

Thanks!  v2 of both patches looks good.
