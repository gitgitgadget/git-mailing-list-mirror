From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v5 00/14] New hash table implementation
Date: Thu, 14 Nov 2013 23:07:55 +0100
Message-ID: <528549BB.20507@gmail.com>
References: <52851FB5.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 23:08:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh54x-0005tt-4h
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 23:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757Ab3KNWHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 17:07:55 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37618 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637Ab3KNWHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 17:07:53 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn6so155182wib.10
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 14:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7QZSic0DhqmIvWsyON5n8lK/HFy7WzyM1qsDlQNNodU=;
        b=YTRm0RA3iIwbkOOj1So0L2fxZ/pT56xgsCJU5r8E4BR5CRB8LWAYcOTiUJmPqrVKx7
         2GkOtigiUog2HKXvILU1WgzRVVosu4Zj2St8gf9vcLmtNDYcP52nzeC50lZqZI2TlVuL
         RWJf0HQ5pdYBwXyQVCIJ832oLVSg1rjsrap/SA1zcJjIaR6LzMKzKYLv7Qc0Nyz/v1uB
         RGkpSRqwz2cEFrEX1BKt/lGpQrwerO4VEqoMpH5WaI1PSn14PeehV1mi1MiKZrlltAg/
         zIkWxLsy5MgNkngRoHGWbmopVx6x5+NsddySE/8T35JCThFKhzBoENJjsTquVAmDblSg
         2iyw==
X-Received: by 10.194.238.230 with SMTP id vn6mr4109142wjc.57.1384466872600;
        Thu, 14 Nov 2013 14:07:52 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id uc12sm2664301wib.3.2013.11.14.14.07.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 14:07:51 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52851FB5.4050406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237879>

Am 14.11.2013 20:08, schrieb Karsten Blees:
> Changes since v3:

s/v3/v4/
