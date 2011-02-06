From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [1.8.0] Tracking empty directories
Date: Sun, 6 Feb 2011 21:46:34 +0100
Message-ID: <AANLkTimo44R_=CLqZ=+TZmtctAnBXbxEakEBdgUVeY1L@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <m3zkqe8xc8.fsf_-_@localhost.localdomain> <201102051931.10979.thomas@koch.ro>
 <AANLkTikX5Y=TrXayXj-MCaR5p0=Tokc_5ihGqHFL9CQx@mail.gmail.com> <7vmxm8x5dx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: thomas@koch.ro, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 21:47:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmBVz-0005ew-9O
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 21:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012Ab1BFUrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 15:47:17 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42758 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab1BFUrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 15:47:16 -0500
Received: by iwn9 with SMTP id 9so3966425iwn.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 12:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=y4i1OYdjn8vJNFeqeNO2nA2ugJDGue1T2PmAk+yuGTI=;
        b=hxcbPK/RZrzTskWPWXUsdyS751o1wzmhcEmolnqiC1wZlVv3gpb5/l2dzLEpxhrK7X
         Z1FSHrBR/eajWKIrXl+WJS8CJs5iFiqP8m/wrVTLbq7N+7yxwv6wUaGEURuKtIGHqqRw
         fF/ZVDh8wzawjJUcSt9IeWzbi4LQGRKmFBkIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nww+2hvl6vyTPrDjqQuHZwtieHe2/+ThAAMZ1Y03iP8Ip5XTQb+Y31iw6IPgHrVW98
         ihQ7DKHURArUFtPZSjiZMDX7LIMie93bO/sl4Q5/v6FaigZ3WS28IjmpW2JI9wRe+h/I
         e+oUyswpYTTIGh8LKtAuq/KjSNHabrVW62VfY=
Received: by 10.231.147.149 with SMTP id l21mr16110586ibv.152.1297025235117;
 Sun, 06 Feb 2011 12:47:15 -0800 (PST)
Received: by 10.231.39.140 with HTTP; Sun, 6 Feb 2011 12:46:34 -0800 (PST)
In-Reply-To: <7vmxm8x5dx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166202>

Heya,

On Sun, Feb 6, 2011 at 21:41, Junio C Hamano <gitster@pobox.com> wrote:
> Huh?

To teach the plumbing to handle empty directories first, and then in a
later release add porcelain?

-- 
Cheers,

Sverre Rabbelier
