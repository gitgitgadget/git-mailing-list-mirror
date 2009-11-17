From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/2] t3101: test more ls-tree options
Date: Mon, 16 Nov 2009 22:26:09 -0800
Message-ID: <4B024201.2010400@gmail.com>
References: <1258173248-31059-1-git-send-email-bebarino@gmail.com> <1258173248-31059-2-git-send-email-bebarino@gmail.com> <7vws1piscw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 07:26:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAHW8-00075O-EZ
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 07:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbZKQG0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 01:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbZKQG0I
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 01:26:08 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:53235 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbZKQG0H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 01:26:07 -0500
Received: by yxe17 with SMTP id 17so575474yxe.33
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 22:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=vemsigyrhLHCTYjeIuC7EMtdPUGT5UVmmxbW0O1XDuM=;
        b=sX/q52dgqK/5ocyb+cbBr+8kMdEbcXEJqi59R8tFD4LXDc2hIeEljuzDV+zVKnP3A3
         1FewiMN8hsPGIjaCrCzgsPUb2xCWTKgTvmz85y/TN5JO3diQpW8VPRMuIlNXzNbTt2Mz
         HqyYp99Ob/Ad4GFxfMYF6DOrnDkQyg/VXxckg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=suAPekykZd+jwIVTKy7EfJHBmAZtZBcqv9osecRhvxgk54K+Sj8uuIfJ+VfkQEcvGV
         opnwkjyToIgGz0BXr4O6jfbMBEfOOIq3bfmDUyS0uhbYex9URFwGRWl9LZ4etBh+boEJ
         JTNyThoKRXe7bZatHxO7YdzUjGHIABfYWDrCs=
Received: by 10.90.45.11 with SMTP id s11mr6343078ags.72.1258439173400;
        Mon, 16 Nov 2009 22:26:13 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 21sm2004205yxe.19.2009.11.16.22.26.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 22:26:12 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <7vws1piscw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133064>

Junio C Hamano wrote:
> Thanks.  I'd squash this patch in for the following reasons; Ok?

Looks good. Thanks.

I figured reusing the test_output function would be a bad idea.
