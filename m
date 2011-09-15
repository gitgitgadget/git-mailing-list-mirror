From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH] t6019: avoid refname collision on case-insensitive systems
Date: Thu, 15 Sep 2011 08:45:50 -0400
Message-ID: <4E71F37E.4030106@kitware.com>
References: <02451a2849fc8f1cab7983b6c8c629ebb6a1aaa9.1316075573.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Sep 15 14:46:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4BKR-00042k-TO
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 14:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933531Ab1IOMqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 08:46:00 -0400
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:54969 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933504Ab1IOMp7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 08:45:59 -0400
Received: from mail-gy0-f169.google.com ([209.85.160.169]) (using TLSv1) by na3sys009aob102.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTnHzhEW3m0KU6jTb3fhzZ9LZrvKvMpBr@postini.com; Thu, 15 Sep 2011 05:45:59 PDT
Received: by mail-gy0-f169.google.com with SMTP id 6so2464298gya.0
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 05:45:56 -0700 (PDT)
Received: by 10.150.144.21 with SMTP id r21mr1137557ybd.125.1316090756726;
        Thu, 15 Sep 2011 05:45:56 -0700 (PDT)
Received: from [192.168.100.107] (cpe-74-67-54-254.nycap.res.rr.com [74.67.54.254])
        by mx.google.com with ESMTPS id u13sm15014107anf.14.2011.09.15.05.45.53
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Sep 2011 05:45:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <02451a2849fc8f1cab7983b6c8c629ebb6a1aaa9.1316075573.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181464>

On 9/15/2011 4:34 AM, Thomas Rast wrote:
> The criss-cross tests kept failing for me because of collisions of 'a'
> with 'A' etc.  Prefix the lowercase refnames with an extra letter to
> disambiguate.

Thanks.

-Brad
