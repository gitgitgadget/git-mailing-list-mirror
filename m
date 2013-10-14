From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] config doc: user.signingkey is also used for signed
 commits
Date: Mon, 14 Oct 2013 10:15:46 -0700
Message-ID: <20131014171546.GA12907@google.com>
References: <1381770276-12062-1-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Mon Oct 14 19:15:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVlkN-000626-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 19:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142Ab3JNRPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 13:15:55 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:49894 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136Ab3JNRPy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 13:15:54 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so7597566pbb.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 10:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=n4k6XAYHbIgdHIx9B1uThHzMrcp7XcnVCwSt+AN9h8o=;
        b=YlzhQBUgfmOUuh5EPkVV9Ixr5pVjiLE3CQGdv+HVJ7HzLZBpEcNoKSFfiZn6Ct7Y9S
         slogG/C0SQ3hd8Jo45v2l7ywastqx+StJCU+EHpk29XgMGLnehGvB7KDG8UGGk3iu5E8
         M+BU+naRed7EaYCEWQ660LfklmSu57RZePjkxmQaTxmSpw0CwOEA+XWOoZLclqXj+3H5
         3yqU44nD13O2sWfd2SCnmKAJbxd/hnIKeDZsqZWPEVKIVTa3SfDpjxDz0SYmxu+CYzxc
         +vnOQNAIrOKv2yfnsVWvKXVKeUNgMP5/mcnwbYEfg/L2l3+S/gaNMlBBejVy1zMmz9HA
         8zMQ==
X-Received: by 10.68.6.170 with SMTP id c10mr37159752pba.101.1381770953737;
        Mon, 14 Oct 2013 10:15:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id so2sm79176523pbc.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 10:15:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381770276-12062-1-git-send-email-boklm@mars-attacks.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236106>

Nicolas Vigier wrote:

> The description of the user.signingkey option only mentioned its use
> when creating a signed tag. Make it clear that is is also used when
> creating signed commits.
> ---
>  Documentation/config.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thanks.  May we have your sign-off?  (See Documentation/SubmittingPatches
section 5 "Sign your work" for what this means.)
