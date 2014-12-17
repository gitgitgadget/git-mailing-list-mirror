From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH v4] remote: add --fetch and --both options to set-url
Date: Wed, 17 Dec 2014 15:42:08 +0100
Message-ID: <4526638.yURndRDM9N@al>
References: <1418825936-18575-1-git-send-email-peter@lekensteyn.nl> <20141217143212.GA23085@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 17 15:42:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1Fnw-0000vA-Dz
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 15:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbaLQOmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 09:42:15 -0500
Received: from lekensteyn.nl ([178.21.112.251]:58762 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbaLQOmP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 09:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=3JiuEyIGHkyVQnzFc5rlSHAiqewxyisoe42JmD6soaY=;
	b=kRR3mxMhPTL/Tcbhg+borNNlF51FTezC7peLtjn0H8oCWweT+9IOotSCqHjQCzSrT6pV2HWTKuTlFieE2/9PWBwIgE0gugnbMlYdTHznbiKSYAFO4wf4eMjhHoWnAQICvYGVqiRT1cv7+ghvZ9+iEull8SXNuy9g1U5VjmXCf6cZHdGzVFc9pLknq3dcSJajnH0Yrd6pmkZS6MftJtkeZERZ/akz1oT1aOC9MSS2c+F4ZAqaAOkWjDFvKiIVaWfZ+khp8Wcm2JJAIafSeBRg5CCRc9V1fcuv6LZHeB558ofiXfv0KYWgVeh+F8V6tK1wY71qrI8ZjhsFJXybv2u8dg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1Y1Fnl-00063J-Dt; Wed, 17 Dec 2014 15:42:09 +0100
User-Agent: KMail/4.14.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.3; x86_64; ; )
In-Reply-To: <20141217143212.GA23085@peff.net>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261487>

On Wednesday 17 December 2014 09:32:13 Jeff King wrote:
> On Wed, Dec 17, 2014 at 03:18:56PM +0100, Peter Wu wrote:
> 
> > This is the fourth revision of the patch that allows for just setting the fetch
> > URL. Eric wondered why '--fetch --push' is not used to describe the state
> > '--both', so I added this to the commit message.
> 
> Thanks, I think that explanation is very clear.
> 
> This version overall looks good to me.
> 
> > The t5505-remote.sh test still passes after this change (I was unable to run the
> > full test suite as it broke due to an unrelated gpg issue).
> 
> It is it because you have gpg 2.1, and the patches to handle that are
> not yet merged to master? Or is it because you are using the new patches
> and they are breaking things for your older gpg version?
> 
> If the former, that's fine. If the latter, it would be nice to see a
> report of the breakage. :)

Rest assured, this is a gpg 2.1 issue :-)
-- 
Kind regards,
Peter
https://lekensteyn.nl
