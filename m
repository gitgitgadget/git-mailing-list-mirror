From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v7 00/11] Add interpret-trailers builtin
Date: Sat, 8 Mar 2014 11:54:14 +0000 (UTC)
Message-ID: <loom.20140308T124447-78@post.gmane.org>
References: <20140306220029.29150.64594.chriscool@tuxfamily.org> <xmqq8uslu1bi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 12:54:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMFq0-0005NL-Rj
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 12:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbaCHLyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2014 06:54:41 -0500
Received: from plane.gmane.org ([80.91.229.3]:46316 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbaCHLyj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2014 06:54:39 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WMFpu-0005IV-OX
	for git@vger.kernel.org; Sat, 08 Mar 2014 12:54:38 +0100
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Mar 2014 12:54:38 +0100
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Mar 2014 12:54:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243674>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> 	...
> 
> is easier to read and maintain if written like so (with using HT
> properly---our MUAs may damage it and turn the indentation into
> spaces):
> 
> 	... &&
> 	sed -e "s/ Z$/ /" >>expect <<-\EOF &&
>         Fixes: Z
>         Acked-by= Z
>         Reviewed-by: Z
>         Signed-off-by: Z
> 	EOF
> 	...
> 

How about:

   printf '%s: \n' Fixes Acked-by Reviewed-by Signed-off-by >> expect

This solution scores high marks in both readability and maintainability
in my mind.
