From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: add NO_FNMATCH_CASEFOLD to HP-UX section
Date: Tue, 8 Mar 2011 22:37:57 +0100
Message-ID: <AANLkTi=2rXtG6EnmG2WRqwzoANdb3cthh22sMa9S8TwF@mail.gmail.com>
References: <160568F4-412B-4D50-8CA8-01BF729E4012@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 08 22:38:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px4bV-00068O-AT
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab1CHVh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 16:37:59 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47771 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993Ab1CHVh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 16:37:58 -0500
Received: by fxm17 with SMTP id 17so5559831fxm.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 13:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0mfEULIRB3qbWLF45KHJkv2N47PvBsPvqv3N/hpG/wo=;
        b=xjXPt7izH5ZRMsDfFmBvu0K3RX2/UrJdilee3TocX+DqNDEMq60QM2XdGRxiGvJsPm
         iaWWHl8kCKQ0c5zLCBzKnnzovgBrBvLTyupNwiVpO8ZIU453ZzU7M2O1upb25OqYITuG
         K0HVxeCqTblygtIn7252Wb/br0T3F2k37bNJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RCVW0QC2OfzMGggBs46Q+ab5zPRRpsxHNebBxegsIKx0OUO+wLSyB37OdV5roVurpE
         0orkRjebgknu8oNWxfxsCACK3Y1LUWe4n58uGsOKmxwrCDykaY2C983Rg47vGCn2ogk3
         LC6YSuRFbqYKsOK0jDpeFHJzT6brFb+I1uK+I=
Received: by 10.223.143.75 with SMTP id t11mr1361537fau.49.1299620277426; Tue,
 08 Mar 2011 13:37:57 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Tue, 8 Mar 2011 13:37:57 -0800 (PST)
In-Reply-To: <160568F4-412B-4D50-8CA8-01BF729E4012@nextsoft.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168702>

On Mon, Mar 7, 2011 at 12:43, Michal Rokos <rokos@nextsoft.cz> wrote:
> fnmatch() on HP-UX does not support the GNU FNM_CASEFOLD extension, so set NO_FNMATCH_CASEFOLD to use the internal fnmatch implementation.

Thanks. This looks good to me, I didn't have a HP-UX system to test on
when I wrote this.
