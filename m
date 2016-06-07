From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/5] t1404: document function test_update_rejected
Date: Tue, 7 Jun 2016 18:57:23 +0200
Message-ID: <5756FCF3.7050509@kdbg.org>
References: <cover.1465299118.git.mhagger@alum.mit.edu>
 <2561c38f85648144d665e870ca42c133a3a78909.1465299118.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 18:57:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAKJo-0004Vb-6O
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 18:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161290AbcFGQ52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 12:57:28 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:64038 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932144AbcFGQ51 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 12:57:27 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rPHmh0Mqdz5tlB;
	Tue,  7 Jun 2016 18:57:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 6C0E25291;
	Tue,  7 Jun 2016 18:57:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <2561c38f85648144d665e870ca42c133a3a78909.1465299118.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296697>

Am 07.06.2016 um 13:50 schrieb Michael Haggerty:
>   test_update_rejected () {
> +	local prefix before pack create error &&

Do we want to add more of unportable 'local' declarations?

>   	prefix="$1" &&
>   	before="$2" &&
>   	pack="$3" &&

-- Hannes
