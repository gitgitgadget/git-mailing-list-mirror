From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: how to undo a merge
Date: Tue, 01 Nov 2011 08:56:00 +0100
Message-ID: <4EAFA610.9080101@lyx.org>
References: <CANiMyiEoaxAO3XxJMWEXP-L7C_xkxU0_nyDaor+TsJr-Ch7ARw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hong-Ming Su <halleyinvent@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 08:56:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL9Ci-0007Cz-E8
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 08:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297Ab1KAH4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 03:56:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:32768 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab1KAH4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 03:56:06 -0400
Received: by eye27 with SMTP id 27so6005856eye.19
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 00:56:05 -0700 (PDT)
Received: by 10.213.20.18 with SMTP id d18mr1084203ebb.138.1320134164974;
        Tue, 01 Nov 2011 00:56:04 -0700 (PDT)
Received: from [192.168.1.3] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id q28sm58018866eea.6.2011.11.01.00.56.03
        (version=SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 00:56:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CANiMyiEoaxAO3XxJMWEXP-L7C_xkxU0_nyDaor+TsJr-Ch7ARw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184560>

Op 1-11-2011 8:27, Hong-Ming Su schreef:
> The commit graph before merging is:
> A--B<-master
>   \  \
>    \  \
> C--D--E--F<- dev
>
> git checkout master
> git merge dev
>
> The commit graph after merging is:
> A--B
>   \  \
>    \  \
> C--D--E--F<- dev<-master
>
> master fast-forward to commit F.
> I want to "undo" the merge. What shall I do?

git checkout master
git reset B

Vincent
