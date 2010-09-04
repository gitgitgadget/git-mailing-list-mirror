From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: usage for git-p2p (was: git pack/unpack over bittorrent - works!)
Date: Sat, 4 Sep 2010 16:21:07 +0100
Message-ID: <AANLkTi=_cXwHfDrDFx+1dG_6ZiHkrb8GObv72zwH3z3b@mail.gmail.com>
References: <AANLkTin0-Zjy7Chvntf2pNj5iCQ-4Y5u=bu8r7DSejeu@mail.gmail.com>
	<4C8260EC.9000404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 17:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OruYc-0008Ia-L2
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 17:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab0IDPVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 11:21:15 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55341 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab0IDPVO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 11:21:14 -0400
Received: by vws3 with SMTP id 3so2158338vws.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+QZ5/fM+jxZ85P7MxXRXXuvmtEaZHBH3CH91Bna64Bo=;
        b=GNt4VW7J3XNdQa3iVqjUs7t7hqnLPGmCAu2da2kLba8rPCRLcdkjHcgTWhxgol6ySD
         P+INi+jXq/SEJ924zuusdsAAVAfL+fzkj4xeHQT0n43VAoiM8WTSMYVqSgeHVtIFyJQ1
         xlmoj+ha6t5oEbW6nIDVWoLcDgfDRJz0aD3gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Z8GSmqtxGbrveZldSpSZsQaBLosqyvFpYKesHizSAeZD76tlVK3VCTNG6kv5w8XknI
         fIX8a6bN+Tm5D8eDXJ1tTxf6hndu6L/v63wx+pDlz+qKzqn/3k5YsEHd/2FceCq76ENp
         5zHd25fT0NEPc7J0hdY7EmCgvTbXNNPMBzf2I=
Received: by 10.220.129.13 with SMTP id m13mr834292vcs.132.1283613667338; Sat,
 04 Sep 2010 08:21:07 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sat, 4 Sep 2010 08:21:07 -0700 (PDT)
In-Reply-To: <4C8260EC.9000404@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155333>

On Sat, Sep 4, 2010 at 4:08 PM, Artur Skawina <art.08.09@gmail.com> wrote:
> The one other use case for git-p2p that i can see is distributing the
> object store over a LAN.

 ok - then you should help with the "git hive" effort that casey's
writing, as he is focussing on writing an extension to git which does
exactly that.  the discussion on this thread is focussed on extending
git to work out on the wider internet, not just the case of optimised
transfers on a LAN segment.

l.
