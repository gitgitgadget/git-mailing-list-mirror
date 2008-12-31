From: demerphq <demerphq@gmail.com>
Subject: Re: Do moves add to repository size?
Date: Wed, 31 Dec 2008 10:46:19 +0100
Message-ID: <9b18b3110812310146r48a15907q2bf88d81b6bf4e0f@mail.gmail.com>
References: <85fafb0c0812310111s552247em5f0ca57b737aedc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon Chiang" <simon.a.chiang@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 10:47:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHxfy-00011Q-D6
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 10:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbYLaJqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 04:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069AbYLaJqV
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 04:46:21 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:55858 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbYLaJqU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 04:46:20 -0500
Received: by qw-out-2122.google.com with SMTP id 3so4557210qwe.37
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 01:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vnAc3T3+JxL10N6jHMtp9YTe6EU1Ons2xNrsuLfpx60=;
        b=cXpBzPvXcL+zaUjXBR24TCFaDSIggNSN5CNJ2FcLhV8K1MPxok4xBig1COCePJOLLw
         DRRSs9kZWI20Jx9/qCs5OxrEE3rFZqyP+Iv8ew2GI8upMd4Wfq01La3ggs/ATSyWIOni
         pN16A1bN/a6k40RAOeVjwsjpQKGdMpC2ViJbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gVUE/WCK7rsXVe7HCk71+N/BFShRlLVGzcD+GVtIZB/G6P4dKMIhL8fykb8iKBs+dJ
         uCk7k6n6ynzUvI97j2fteEIt/eHkRhB1auLiU2csuCM9ps8cac0dM3bxiBkQpnFGN0S8
         /QkNydYqdjLjCwQ9XVYuHeqzFy8aj+z4RIwjs=
Received: by 10.214.113.11 with SMTP id l11mr13534404qac.190.1230716779040;
        Wed, 31 Dec 2008 01:46:19 -0800 (PST)
Received: by 10.214.217.13 with HTTP; Wed, 31 Dec 2008 01:46:19 -0800 (PST)
In-Reply-To: <85fafb0c0812310111s552247em5f0ca57b737aedc3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104260>

2008/12/31 Simon Chiang <simon.a.chiang@gmail.com>:
> Hey, I'm quite curious to know if moves/renames duplicate the file
> content in the repository (and hence grow the repository size) or if
> they just change the location of the content.  I want to drastically
> reorganize a repository and I'm wondering if will double it in size.

No it wont. Git uses a content addressable storage. And since in a
rename the content doesnt change....

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
