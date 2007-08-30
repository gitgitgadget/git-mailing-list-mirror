From: "Tom Clarke" <tom@u2i.com>
Subject: Re: Add --rebase option to git-pull?
Date: Thu, 30 Aug 2007 22:36:49 +0200
Message-ID: <550f9510708301336v29f2022fodca374881bd82a62@mail.gmail.com>
References: <550f9510708300540u13c77201oe7cbe599c6773364@mail.gmail.com>
	 <Pine.LNX.4.64.0708301415150.28586@racer.site>
	 <550f9510708300810y1ca84e8dt4d0bab8fc99deb3c@mail.gmail.com>
	 <20070830202251.GA15405@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 22:37:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQqll-0005um-Oo
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 22:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761511AbXH3UhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 16:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbXH3UhQ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 16:37:16 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:6325 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761445AbXH3Ugu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 16:36:50 -0400
Received: by py-out-1112.google.com with SMTP id u77so3069681pyb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 13:36:49 -0700 (PDT)
Received: by 10.35.40.10 with SMTP id s10mr1027180pyj.1188506209371;
        Thu, 30 Aug 2007 13:36:49 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Thu, 30 Aug 2007 13:36:49 -0700 (PDT)
In-Reply-To: <20070830202251.GA15405@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57067>

Indeed. Thanks :-).

-Tom

On 8/30/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> Tom Clarke, Thu, Aug 30, 2007 17:10:31 +0200:
> > +# Give up if we are given more than two remotes -- not handling octopus.
> > +case "$remotes" in
> > +?*' '?*)
> > +       exit 2 ;;
> > +esac
>
> Isn't it "given two and more remotes"?
>
>
