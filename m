From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: make gitweb_check_feature a boolean wrapper
Date: Sat, 29 Nov 2008 23:27:40 +0100
Message-ID: <cb7bb73a0811291427n7922ab1fq50caedafe7163f9e@mail.gmail.com>
References: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1227959616-8056-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vej0u1d2c.fsf@gitster.siamese.dyndns.org>
	 <7vzljiz1qn.fsf@gitster.siamese.dyndns.org>
	 <7vmyfiz0zf.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 23:29:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6YJB-0004q0-6k
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 23:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbYK2W1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 17:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbYK2W1m
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 17:27:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:10136 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbYK2W1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 17:27:41 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1013970nfc.21
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 14:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=V5Ix4fCBayknBiGyZaW8JK1wrM9ARu3z//6u2hAfGzQ=;
        b=bWi1w5wb2NMorqG+kVJqtC1GeXY27X5BM4zbt3qBXafIrB47MxUoGfq5uB80oapt7R
         jRQnhblC75UthjGXAFXO103TbVfWF9xBElmDz3prpvjck+XGpueQ3Zt1w3dPfVYr6vYg
         Zm2YSN5LLUsnK1tpSdJjg7vmEg87+Lk1tU7d0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LBbWNmt4XQoLxZGsCuA1qwiFEhcilRLFANLPZBpBNTvmqeGVnSOpk+/0nX9mA1NIwQ
         FJLa37EoZZ+Qy5tEVCKXEQP53HIiwheaMfaAjSFIUz7EIWloOKyllwrr7xXglLJiSCJc
         dK0BqWpdo179qrXRbpZh4j7uzcUaKAhWgcxa8=
Received: by 10.210.58.17 with SMTP id g17mr10678426eba.130.1227997660064;
        Sat, 29 Nov 2008 14:27:40 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Sat, 29 Nov 2008 14:27:40 -0800 (PST)
In-Reply-To: <7vmyfiz0zf.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101931>

On Sat, Nov 29, 2008 at 10:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  * Again, this is to demonstrate how I would have liked to see your
>   patches as a reviewable series.  Notice how this naturally justifies
>   the dropping of parentheses in many lines that begin with "my", and
>   makes it easier to review?  You can review the patch easily by knowing
>   that callers that have s/get/check/ are now safe to use scalar context.

Yes, I get the point: do less things under the hood. I also still
think that three patches with code going ping-pong are way too much,
though 8-P

For what it's worth, you get my Ack: to your patchset 8-)

-- 
Giuseppe "Oblomov" Bilotta
