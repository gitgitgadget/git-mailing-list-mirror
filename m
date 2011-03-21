From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 2/3] revision.c: introduce --min-parents and
 --max-parents
Date: Mon, 21 Mar 2011 12:58:17 -0500
Message-ID: <20110321175817.GB8202@elie>
References: <cover.1300702130.git.git@drmicha.warpmail.net>
 <41d12c53966faa9c9cb5acc7646e9098dcd911ea.1300702130.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 18:58:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jNB-0003O0-Ai
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 18:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab1CUR6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 13:58:23 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:65081 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132Ab1CUR6W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 13:58:22 -0400
Received: by vxi39 with SMTP id 39so5207971vxi.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1TQYhkCPJF1UjPaQ6OEuY0M6Xc0iwokpWOHM1hkM4z4=;
        b=v0Vj7nwE6ofQ0U/9wD8ShcMPi/Q4duyMv4F9UmgB4a5KOwj9bg3iMmhxGEToVMVQqY
         fuzHSIv999bC5m7FB63anxTmYlSfgGpka+KFcT5dlOVAdFXnycedCvw/YTHIZL8rFioc
         YjOsAedagzSMMCnQoDYCx7Wa4noAfxOL1iBq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IwjQUu1xfExNZR9uiwSNbwtBANQBoer5KamlDYkoyQlTRvW7u2fV0QFEFHr/890PzL
         AKX9rFyn9sFRCNlpl2sCrdj1rAcPzrid9fmugRTQDbetZEE5B6usO8AdaHUJz307wSVI
         N2DVX7O5+lyAygezfTlRfHRFJMlZvJzcmWCco=
Received: by 10.220.199.141 with SMTP id es13mr1270290vcb.73.1300730301548;
        Mon, 21 Mar 2011 10:58:21 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id f4sm1491697vcz.46.2011.03.21.10.58.19
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 10:58:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <41d12c53966faa9c9cb5acc7646e9098dcd911ea.1300702130.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169620>

Michael J Gruber wrote:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> builtin/log.c       |    2 +-
> builtin/rev-list.c  |    2 ++
> builtin/rev-parse.c |    2 ++
> revision.c          |   24 +++++++++++++++++-------
> revision.h          |    4 ++--
> 5 files changed, 24 insertions(+), 10 deletions(-)

For what it's worth, the patch looks obviously good to me, too.
