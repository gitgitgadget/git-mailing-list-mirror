From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git-svn segmetation fault
Date: Fri, 1 Feb 2008 22:42:58 -0500
Message-ID: <20080202034258.GA27814@dervierte>
References: <47A39DFD.9020905@saville.com> <47A3BE6F.6080304@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 04:43:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL9I7-0007YG-Nv
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 04:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbYBBDnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 22:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753697AbYBBDnE
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 22:43:04 -0500
Received: from hs-out-0708.google.com ([64.233.178.249]:23905 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753671AbYBBDnC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 22:43:02 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1141640hsz.5
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 19:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=CMYSp8IponsPrDKHLVQv16wVRt5+nW8pnYa9Kevsi9E=;
        b=LAkb3jm2xhIdmVfD2/tDIIgfylUwjvNOpyaKwaTlP6c0VNj9KMYLmvqz3i1JYNzpkKEQkNKl0f9XZR7mctJArMDFgF79cPJALEYh66f7iK6bhLK13AM0jGknJJXoodIbE6N/7as+PhYZlKvSAIOxdrMQqgwvOkhrVi0hV63Doqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=u/6VI9PRBBL9qhyE+qK3go4i5LAM/5V1IZ9cnV5J8eEWnRhxWn25VPNbaMBen4iYFdlkVfy6HC0x/AQxkcJaAF4N7tME3NGcEmpJtDSWqYYKukC9fw0ZUP9J8mairVtGBYT7DlW8e4D0dALX2WskjFrX8OccAgHYTE1tlxAapNg=
Received: by 10.150.136.6 with SMTP id j6mr1672485ybd.126.1201923781253;
        Fri, 01 Feb 2008 19:43:01 -0800 (PST)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id 18sm9983844wry.17.2008.02.01.19.43.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Feb 2008 19:43:00 -0800 (PST)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 10A9D23A78; Fri,  1 Feb 2008 22:42:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47A3BE6F.6080304@saville.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72217>

On Fri, Feb 01, 2008 at 04:50:55PM -0800, Wink Saville wrote:
> Wink Saville wrote:
>> I was doing an git-svn dcommit and got a seg fault. The first
>> phase of updating svn completed and then it seg faulted on the
>> second. So I suspect I'm out of sync and need to recover,
>> any guidance appreciated.

Can you show the contents of .git/config ?
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
