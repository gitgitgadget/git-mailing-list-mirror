From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Rearrange git-format-patch synopsis to improve clarity.
Date: Tue, 06 Nov 2007 09:01:22 -0600
Message-ID: <473081C2.7060106@freescale.com>
References: <119421522591-git-send-email-dsymonds@gmail.com> <ee77f5c20711051432w284cf22dx71192c145d25dced@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 16:05:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpPz9-0006gY-AA
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 16:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbXKFPEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 10:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbXKFPEk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 10:04:40 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:45550 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbXKFPEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 10:04:39 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id lA6F1ZGY006693;
	Tue, 6 Nov 2007 08:03:28 -0700 (MST)
Received: from [10.214.72.154] (mvp-10-214-72-154.am.freescale.net [10.214.72.154])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lA6F1Md6018464;
	Tue, 6 Nov 2007 09:01:22 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <ee77f5c20711051432w284cf22dx71192c145d25dced@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63681>

David Symonds wrote:
> On 11/5/07, David Symonds <dsymonds@gmail.com> wrote:
>>                     [-s | --signoff] [<common diff options>]
>> -                   [--start-number <n>] [--numbered-files]
>> +                   [-n | --numbered-files | -N | --no-numbered]
>> +                   [--start-number <n>]
> 
> Now that I look at it again, it seems the long options look quite
> inconsistent. I think it should be either
> --numbered-files/--no-numbered-files or --numbered/--no-numbered. My
> preference is with the latter (for brevity), but that breaks
> backward-compatibility.
> 
> Would you accept a patch that changed --numbered-files to --numbered,
> and kept the former as a synonym?

There are two forms of numbered file output names:
the traditional "0001-Foo-the-bar" and just "1" styles.
Please don't break that.  Both are needed.

Thanks,
jdl
