From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Mon, 18 Apr 2011 02:21:32 +0200
Message-ID: <BANLkTimTszUC+4d3tMTP-cxG3AoWmr08HA@mail.gmail.com>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thorsten Glaser <tg@mirbsd.de>, Harley J Pig <harleypig@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 02:22:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBcE5-0003QE-PP
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 02:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab1DRAVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 20:21:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57915 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab1DRAVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 20:21:52 -0400
Received: by ywj3 with SMTP id 3so1131350ywj.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 17:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=QUXwrxhfw8ZCrT20bOupNC7lfvKCfnhmmE8PtQo2pDU=;
        b=Rx2SZOIsUibCRq8QZ9EsSNX8uMHAH1MLxcPIVS98OVYVEwhav8czNiqJE+HXCfMvon
         vMO2nwlhU8h4z9jnE/ulbmxFR476Rvs9rDa9PHuSzF949/WzO/XuPdfcg3gVmzeJBfIb
         h+KVq8li/j8Vgp334YmQhn2/sqyHT4Eir/r0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Dpg4C/Hqi1cSFSXMRkQs+VT8a8YpcG2qMUOl5WFGneJGmb5hNVkyffVprWKf7Hjegt
         tik23iTvVlckM7yZKyifPYe5IocgN0RHZJKwComCn7k3+9/Ks/VJhmB6kJPt7gQsgqnS
         UDs8mS8MeGLmk82Hd9RCyFFUa9uZbeTycGEd4=
Received: by 10.236.197.35 with SMTP id s23mr2947194yhn.57.1303086112070; Sun,
 17 Apr 2011 17:21:52 -0700 (PDT)
Received: by 10.236.109.130 with HTTP; Sun, 17 Apr 2011 17:21:32 -0700 (PDT)
In-Reply-To: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171732>

Hi all,

as I don't want to let this go stale, here are the three options:

1) fix metastore
2) default to gitperms
3) extend git


I still think 3) would be best, but someone would need to step up to
do this. Is anyone up for this task? If not, we will have to resort to
1) or 2)


Thanks again,
Richard
