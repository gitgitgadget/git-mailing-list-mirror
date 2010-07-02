From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] string_list: Add STRING_LIST_INIT macro and make use
 of it.
Date: Fri, 2 Jul 2010 15:22:57 -0500
Message-ID: <20100702202257.GA7539@burratino>
References: <7vbpawifwa.fsf@alter.siamese.dyndns.org>
 <bcb1b64b5db55dd11a398da3cf2c95145852ddfb.1278097858.git.tfransosi@gmail.com>
 <20100702193002.GB6585@burratino>
 <AANLkTiltCRnezNdL-ueNGfM87mRlbtK6fn1fYMcv5M0G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, srabbelier@gmail.com, gitster@pobox.com,
	Alex Riesen <raa.lkml@gmail.com>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 22:23:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUmlr-0008HL-2x
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 22:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759435Ab0GBUX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 16:23:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39933 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757613Ab0GBUX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 16:23:28 -0400
Received: by iwn7 with SMTP id 7so3619095iwn.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=O5QKHJKa5zVTtwKsnG/i3vNCLDmW8MOtc3/epzR6zy0=;
        b=xVH4X+7S1aD97xDoRTQNhTLRalhhnEtlv8TtBP/YQmcT2iH+75jc33wzSPat7L9qBu
         glJYM8phKPu3dzPAn9pPhRim65aiNC588EocmpHUjaToM5rso60cKb4t6G1u8sOtXtkM
         YFO0UtTn8R4RcqaXgjwGcFs0zDTyWQJQBgDbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=T6bimw1R07DeW+1g/Pwlw5HyIBuDDz9BsmYokKSaXUtltOpZRxPGHqtZPRisGbNna3
         GQ8nhE5cJuQx/ZUjYsoIZZ6mHzVSdF+tjloYTzKjkTFRZ+jKeGmVSmXC9NaRozLGkd0v
         615+76v0FFC8sAkp2tijegk1zOVX6+0DADIMU=
Received: by 10.231.176.215 with SMTP id bf23mr1323360ibb.96.1278102207445;
        Fri, 02 Jul 2010 13:23:27 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm4548743ibk.15.2010.07.02.13.23.26
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 13:23:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiltCRnezNdL-ueNGfM87mRlbtK6fn1fYMcv5M0G@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150163>

Thiago Farina wrote:

> #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0 }
> #define STRING_LIST_INIT_DUP { NULL, 0, 0, 1 }

That looks fine to me.  Thanks, and sorry to nitpick.
