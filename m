From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: Mercurial over Git no success
Date: Sat, 19 Feb 2011 07:06:25 -0600
Organization: Digium, Inc.
Message-ID: <4D5FC051.3090505@digium.com>
References: <1297717305.19327@davidwbrown.name>	<AANLkTinro_sSV52aZATAPFAm1SLRq8i4Q1kA2W+wqqH3@mail.gmail.com> <AANLkTimi8MU3VYug6orouHS7GmBJ-Pf27_zj_KO0Sj6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: david@davidwbrown.name, git@vger.kernel.org,
	Manuel Doninger <manuel.doninger@googlemail.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 14:06:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqmWE-0003wd-RQ
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 14:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab1BSNGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 08:06:34 -0500
Received: from mail.digium.com ([216.207.245.2]:53857 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab1BSNGc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 08:06:32 -0500
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1PqmW4-0005QR-FM; Sat, 19 Feb 2011 07:06:28 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id 638BBD82A1;
	Sat, 19 Feb 2011 07:06:28 -0600 (CST)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pBndqKexU+0G; Sat, 19 Feb 2011 07:06:27 -0600 (CST)
Received: from [192.168.1.6] (173-24-207-63.client.mchsi.com [173.24.207.63])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id 1F2B2D82A0;
	Sat, 19 Feb 2011 07:06:27 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <AANLkTimi8MU3VYug6orouHS7GmBJ-Pf27_zj_KO0Sj6c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167271>

On 02/14/2011 05:19 PM, Jon Seymour wrote:
>  From the INSTALL file:
>
>   - Git is reasonably self-sufficient, but does depend on a few external
>     programs and libraries.  Git can be used without most of them by adding
>     the approriate "NO_<LIBRARY>=YesPlease" to the make command line or
>     config.mak file.
>
>          - "zlib", the compression library. Git won't build without it.
>
>         ...

It would be quite appropriate then for git's configure script to *fail* 
if zlib and zlib headers are not present. The OP would have known what 
was wrong much earlier (and likely with a more useful error message) if 
that had happened.

-- 
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
