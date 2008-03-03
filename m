From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC] git-submodule: multiple-level modules definition
Date: Mon, 3 Mar 2008 12:51:34 +0100
Message-ID: <8c5c35580803030351l2e8d7eedq58108b54bf07dc5c@mail.gmail.com>
References: <46dff0320803020911m30c8e3b3w80c0c92258a45f0f@mail.gmail.com>
	 <8c5c35580803021018v7590ad76kbbab2b1113e27666@mail.gmail.com>
	 <46dff0320803021747y6e334903pf8b5a77168bc7882@mail.gmail.com>
	 <8c5c35580803022257n7ff0cdc3i1e72a0034d254aa4@mail.gmail.com>
	 <46dff0320803030302t286c33a5h3555200c9e8840e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 12:52:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW9DI-0005vG-IV
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 12:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbYCCLvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 06:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbYCCLvf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 06:51:35 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:49419 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbYCCLve (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 06:51:34 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6773197wah.23
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 03:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9b5JGGKQIm6mmXMXzcxzVN/XGOiwSI+2KxsgN1Zwgis=;
        b=CTz9xEAqwcPgCUZz2f4NnOWBvJa+GicUJWZ1DJBcyuKiqV/Sp+33dZJ+PL2cMHiRjrK/resaJ9kMHKNOTt2C+jDPVmaLydQ7uvu+ixTYRaQ8QA/xJGowri5Si/HDiqpuz/OKFMzp4W5/RyOze7sQ8P+NGTdn3gz2nMswv3JcaZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E/nssn8+R6QRHI0xgzYzK5aItROYe7yzWSY4eNyVggsjBMVaND96ZcUAMPEzKFUp2rkowzVTGoP6tnizENYcG8nVfDnt15NVXC5/LnOkWhBevgh1OFceuXRDH6AShhCbT52ptF84mKnDSr9XRVbqqu0D4tJRvLQD/yzyQLDGdlU=
Received: by 10.114.57.1 with SMTP id f1mr1629838waa.15.1204545094597;
        Mon, 03 Mar 2008 03:51:34 -0800 (PST)
Received: by 10.114.241.8 with HTTP; Mon, 3 Mar 2008 03:51:34 -0800 (PST)
In-Reply-To: <46dff0320803030302t286c33a5h3555200c9e8840e3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75917>

On Mon, Mar 3, 2008 at 12:02 PM, Ping Yin <pkufranky@gmail.com> wrote:
>
> On Mon, Mar 3, 2008 at 2:57 PM, Lars Hjemli <hjemli@gmail.com> wrote:
>  > On Mon, Mar 3, 2008 at 2:47 AM, Ping Yin <pkufranky@gmail.com> wrote:
>  >  >  But why always
>  >  >  use git init even when we don't have the local configuration
>  >  >  requirement?
>  >
>  >  We need a way to tell git which of those submodules we are interested
>  >  in, i.e. which submodules to clone/fetch during 'git submodule
>  >  update'.
>  >
>  Now that's easy with the multiple level module definition. We can now
>  group our modules by hierachy and designate modules we are interested
>  by logical names such as crawler or search as my proposal has
>  mentioned.

Sorry, you've lost me here. How is 'git submodule update' going to
avoid cloning/fetching all submodules with your proposal?

PS: the supposed work-flow is an initial 'git submodule init foo bar
baz' (i.e. register the submodules you're interested in checking out)
followed by an occasional 'git submodule update' (i.e. update all the
submodules you are interested in).

--
lh
