From: David Turner <dturner@twopensource.com>
Subject: Re: Corruption of branch?
Date: Mon, 14 Dec 2015 14:20:01 -0500
Organization: Twitter
Message-ID: <1450120801.1678.13.camel@twopensource.com>
References: <566EFF11.6010600@gmail.com>
	 <CAGZ79kaUw8Hb_7hdAUbvmnmXvm3a-77j5t3zeyQ-7BqwPCSp+A@mail.gmail.com>
	 <566F05B2.8080403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Nyberg <tomnyberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 20:20:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8YfJ-0003lH-RW
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbbLNTUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:20:04 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35221 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbbLNTUC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:20:02 -0500
Received: by qgew101 with SMTP id w101so55829912qge.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 11:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=h9AX//0E8Rpwpy8Fdw7y1Dw+2JZlfKchsq1c7lLRnRE=;
        b=ZUpuEw9sq/nNAX/C8qtNckSLHB79edg0q+dQI27GkEKLDzmxelSjNmticbCitm5Dat
         PApWGzqDG0GSxkpZ97eXATuQpwLxbTA5tKHU4GaaHHq57c65x+12YmfNqpM3YmObK2Qu
         jwS7EutfeWyHBVhurMlUoGWOGDwmmS32zpPNRRbumcDffV3bO8aa1nrADVMDcNcRd3J1
         WwDeXrnTJgOycH6ym15VPzrJSbw64WmgnBGLwn307QIER0u6ETgZNYt20VzRItFD23uS
         6DkvGRKNnCSppHzmZVPwY6JBjlotgztSuz+uD6uCvQ3OpVouIsk7rRCKfGCj89XUIwzi
         /oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=h9AX//0E8Rpwpy8Fdw7y1Dw+2JZlfKchsq1c7lLRnRE=;
        b=jtJTZ1ld/vS4i+utTVPBymVJfUvx2uwQN9uEcot1c0RBHDG0tX//Wgu5OkEWZdvOPR
         SkfzzCYoPsyH75yazaXfpYRFoPulqno7wgpu8I/YOLqk5ZA+k6BiSmTIEC8KU0jcHxud
         LNw+xXrODGmeNOsZGzlCLC9QAiq9tIJmTjp2vVy7vOgkIWHYHyRvE/Rwr2LQZELqeghB
         QakK8HGBiux+OWQgl9ge5xHIAp6xNFPB57jC5DF7epvkZRX+/B15o4jO9w9mAhInhtVR
         E4S+myw2qlRFh7gq7ksLDGKPHwNp9wX83Zsfcofc0XpmlHQtjVm2dD/Js+vInFawp49/
         96zQ==
X-Gm-Message-State: ALoCoQn8EQh/ZjFHkFcrhSBvDnHETHRWcgPTGt120M4D90XQsJ+M34Tlz3hyvmBHk9cNHkorYFLmv6JVCYxhm0GvTewKW8mWVA==
X-Received: by 10.140.42.164 with SMTP id c33mr45454843qga.66.1450120801666;
        Mon, 14 Dec 2015 11:20:01 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id d6sm1437729qkb.13.2015.12.14.11.20.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Dec 2015 11:20:00 -0800 (PST)
In-Reply-To: <566F05B2.8080403@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282383>

On Mon, 2015-12-14 at 13:08 -0500, Thomas Nyberg wrote:
> Hi Stefan thanks for much for the response! So I compiled release 
> version 2.6.4 as well as the current master branch on the git git 
> repository (2.7.0.rc0.20.g4b9ab0e) and the problem persists on both.
> 
> To answer your questions, there are no weird characters. The name of the 
> bad_branch is "frus". There is another branch called 
> "frus_body_cleaning" that is totally fine.

What's in .git/config under [branch "frus"] (if anything)?

What does "grep refs/heads/frus .git/packed-refs" say?  What about
find .git -name frus ?

Sorry for the possibly-stupid questions, but I'm really baffled by this
one.
