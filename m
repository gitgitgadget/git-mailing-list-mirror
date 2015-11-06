From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 4/4] Add Travis CI support
Date: Fri, 6 Nov 2015 15:08:36 +0100
Message-ID: <52B7821B-A46D-4DEC-9102-B5573DE53113@gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com> <1446800323-2914-5-git-send-email-larsxschneider@gmail.com> <CAPig+cSc+BBgd3-UeVE79D9GWXfaQqbLCQdKo6FbhnPMsK_eFA@mail.gmail.com> <22B2C2B1-9260-4EC0-A4C5-C7F7DDD388BA@gmail.com> <CAHGBnuNwzGNjfh57zFOtwr6qU1PCsc7rgOniY8-Mz5Jgnv2QTg@mail.gmail.com> <D71ED634-382A-4835-AF65-D16FEFF17270@gmail.com> <CAHGBnuO9aVGYLd+3F3wp7QwazQvWZAS-NeNba3SwsuVkcVkCWg@mail.gmail.com> <BE90093A-90AA-4E63-9664-C5ABCDE6B410@gmail.com> <CAHGBnuOmZFYUXKRnydUZSouOuJ59QU8K_=FvQG0xkQ+TywFPew@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jean-Noel Avila <avila.jn@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	David Turner <dturner@twopensource.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 15:08:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuhhH-0002um-4t
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 15:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161396AbbKFOIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 09:08:45 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32863 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161339AbbKFOIp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 09:08:45 -0500
Received: by pabfh17 with SMTP id fh17so124103075pab.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 06:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zByXReJol5xcyQrksMNLTwTCbMBE5FEuDVobClwmCRE=;
        b=sn53XvJEn1titrVm8yZIQVXz81S+fiiGUL+9LFdo2DkpGI4bC5sHD3VH6yUDN6s3jU
         N/TgYgAEczqu3ZRNwBjAhJp77lrXxn0h61rA5rXBE4sE6kCRRCqlUqkdcoE/S4/QxWEK
         KLrDkeiB6JlUmoqw062LJQgIlLChVYcPtrYSPngwqljsPc3sb7nEnl6Yd01M+EnQaqKa
         MwxfwQHboI1PXVjERhbPBes+RvBEOSJQf+7BXP1W/Wqmt22K6/bAuQeP0IcLDWu2TKZM
         K3OKgo/n6hZdDOgKngkbPL0F+O/PAqeSeg1dwsw1qL/KgUKr317odTHhPShCjZTVcbNd
         qqxg==
X-Received: by 10.66.243.3 with SMTP id wu3mr17863451pac.135.1446818924368;
        Fri, 06 Nov 2015 06:08:44 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id dd4sm369261pbb.52.2015.11.06.06.08.40
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Nov 2015 06:08:43 -0800 (PST)
In-Reply-To: <CAHGBnuOmZFYUXKRnydUZSouOuJ59QU8K_=FvQG0xkQ+TywFPew@mail.gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280985>


> On 06 Nov 2015, at 14:57, Sebastian Schuberth <sschuberth@gmail.com> wrote:
> 
> On Fri, Nov 6, 2015 at 2:55 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
> 
>>> I think running different configuration per branch makes sense, yes.
>> 
>> If the list decides to accept this patch. Do you think that would be a necessary requirement for the first iteration?
> 
> No. I think this could be addressed later as an improvements. To me
> it's more important to finally get *some* sane Travis CI configuration
> in.
True. However, as I stated in my v4 cover letter the Travis CI integration is not yet perfect. I am constantly running builds to find flaky tests. Eg. here is one of them in git-p4 area that I will tackle next:
https://s3.amazonaws.com/archive.travis-ci.org/jobs/89603763/log.txt

I also see a weird "prove Tests our of sequence" error one in a while:
https://s3.amazonaws.com/archive.travis-ci.org/jobs/89603770/log.txt

Does anyone have an idea what could cause this?

Thanks,
Lars
