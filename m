From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH i18n 00/11] Mark more strings for translation
Date: Wed, 18 Apr 2012 14:40:21 -0500
Message-ID: <20120418194021.GB30361@burratino>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 21:40:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKajw-0007nk-QO
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 21:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188Ab2DRTk2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Apr 2012 15:40:28 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54505 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab2DRTk1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 15:40:27 -0400
Received: by obbta14 with SMTP id ta14so7006431obb.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZR5/XICJuGJal0zA4geguCLEd9Li3mxchMsRGY5kWXo=;
        b=egEFspi0qfyPgOwRl8/bUgBWiJ+Pki8l822vIcKymvn3XUDblcgfKw7ZSQpj3llU9s
         ERyecYjUfJL2ksVWl4b7qmRzpfolRRd6cbNlWvJ0i+nIvtEVNzl0KziKNhqo/cVscw3D
         O6s870ERH9TIHdu3Zbd7Ila4N+g095T4gqTaaj2s0vzv/gLFj+KsooVx2koVv65qG0BU
         tZowmPpvnmXPOgDC8HUrae8HTgqvBPR8asjVdBzB3GoK9UinpzyypK6PZMqVLhDgqHvB
         1/eokfjVrFUotPWnngPGKGjI+GDLr8GCSh8N32asX57cYdZH61sZqWzVD4S2YLA0yuFY
         Kjzw==
Received: by 10.182.190.6 with SMTP id gm6mr4031398obc.6.1334778027363;
        Wed, 18 Apr 2012 12:40:27 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b2sm27917077obo.22.2012.04.18.12.40.24
        (version=SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 12:40:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195890>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> This series marks the following for translations
>
>  - relative dates
>  - git-help (and provide support for translating parseopt)
>  - git-remote
>  - git-index-pack
>  - git-apply
>  - git-bundle
>
> Except git-help, other commands are chosen because they handle plural
> form and I'd like to reuse gettext for that. There are a few conflict=
s
> with topics on pu, but seem easy to resolve.

My main reaction is that it would be nice to find a way to check that
parseopt users correctly mark their messages for translation while we
remember.  But that doesn't need to block the series.  Ideas about
mechanism from gettext wizards welcome.

Other comments inline.  I expect that there will be at least one
reroll before this is ready.

Thanks,
Jonathan
