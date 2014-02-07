From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] gitweb: Avoid overflowing page body frame with large images
Date: Fri, 7 Feb 2014 13:35:52 +0100
Message-ID: <CAAH6HY92SGAjMMcrw_HwA_Uh_3=AWFFF9K9WAnNAPcyUpDkbwQ@mail.gmail.com>
References: <2452A253-A926-4A40-9F08-6E28EFF229F3@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>, Tony Finch <dot@dotat.at>,
	Krzesimir Nowak <krzesimir@endocode.com>,
	=?ISO-8859-1?Q?J=FCrgen_Kreileder?= <jk@blackdown.de>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 13:36:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBkf4-0006PA-OG
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 13:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890AbaBGMf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 07:35:56 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:51675 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbaBGMfy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Feb 2014 07:35:54 -0500
Received: by mail-ob0-f169.google.com with SMTP id wo20so3920628obc.0
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 04:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vYXGlTCq3QMkD82oqdkp17WPKxevIqLntxjZewM8elQ=;
        b=X2cWSI3aUdmt89eXmcieiaQwyPeAvl96xgTOeFom84934vFtDczXzAuh5mf+8/7Ovc
         gWLveHPmEQX+EJdLK7JISeJkuwWB36kxf9Pkd/65MnZQX0qwTF6KZVpLK+pqcGsEKUys
         Kx42rLdUGiw+D/riVxoPlMD30k0qFsRPMHXYuwilVW+Hf6Ob1ibYz2ycCsd2yU2njblP
         grIYjknYKHTF62TGv9IeDDNbcH93LKFNwXHyMbsXksuT5j2RotJekGDdZoR1Ubqvv8HB
         Dz7DPLMpBzddGaTw52wwQokrF86LqKRlX7xC2SimBPuCQWqxBHcrNK/vcgw8zD2OYzvc
         7CRQ==
X-Gm-Message-State: ALoCoQk7eDstxMxEMqWqn6M75FgyGnP9IjEcsTUH++ky5q8/6JBmZxG010GPqUXGhQLdgVGAF9p2
X-Received: by 10.60.159.133 with SMTP id xc5mr12582464oeb.37.1391776552289;
 Fri, 07 Feb 2014 04:35:52 -0800 (PST)
Received: by 10.60.6.105 with HTTP; Fri, 7 Feb 2014 04:35:52 -0800 (PST)
In-Reply-To: <2452A253-A926-4A40-9F08-6E28EFF229F3@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241768>

On Fri, Feb 7, 2014 at 4:31 AM, Andrew Keller <andrew@kellerfarm.com> wrote:
> I recently used Git to archive a set of scanned photos, and I used gitweb to provide access to them.  Overall, everything worked well, but I found it undesirable that I had to zoom out in my browser on every photo to see the whole photo.  In the spirit of making the default behavior the most likely correct behavior, this patch seems to be a good idea.
>
> However, I'm not an expert on the use cases of gitweb.  In order for the maximum size constraints to take effect, the image would have to be at least the size of the web browser window (minus a handful of pixels), so the affected images are usually going to be pretty big.  Are there any common use cases for displaying a large image without scaling (and hence, with scrolling)?
>
> Thanks,
> Andrew
>

It sounds like your usecase is exactly what camlistore.org tries to achieve.

Vincent
