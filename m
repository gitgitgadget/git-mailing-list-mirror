From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] push: add 'prune' option
Date: Wed, 22 Feb 2012 08:45:33 +0700
Message-ID: <CACsJy8C6K8UteZjH+mo88SeNWUf6yFyRRi_EQHa84ETNvv0iGA@mail.gmail.com>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8ACoF=2dEUoFvT8bQDmUsjJA2_VWvTSJV6fakqyCLBCYg@mail.gmail.com> <20120221173548.GB32376@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 22 02:46:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S01Ho-0006TK-Hn
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 02:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab2BVBqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 20:46:06 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:50602 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754321Ab2BVBqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 20:46:04 -0500
Received: by werb13 with SMTP id b13so4188241wer.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 17:46:03 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.109.198 as permitted sender) client-ip=10.180.109.198;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.109.198 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.109.198])
        by 10.180.109.198 with SMTP id hu6mr31663143wib.16.1329875163261 (num_hops = 1);
        Tue, 21 Feb 2012 17:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ib3fCzCP152tJCa7WGGJIcX7gfgYpy0LtYfiLtls7s4=;
        b=RuL8C4mwRHUR9eVZ8qUjBQWTjtoeMgqpXBfoIQJe4jlswKyA0p5g/BFVOLJ0c1A5JQ
         TEmOl/kExkxEjbJjNtFRXf8L/kjHAG/eodYPQQCqXYtjvRYeelpXGQVFlUwSo5BWH+0N
         MjM9Z/WSBNt3ocy+gMJLPfEhnDbVqNJAopuWA=
Received: by 10.180.109.198 with SMTP id hu6mr26368889wib.16.1329875163228;
 Tue, 21 Feb 2012 17:46:03 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 21 Feb 2012 17:45:33 -0800 (PST)
In-Reply-To: <20120221173548.GB32376@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191216>

On Wed, Feb 22, 2012 at 12:35 AM, Jeff King <peff@peff.net> wrote:
> Huh? Don't we already have "fetch --prune"?

We do indeed. I went to git-fetch.txt, searched for prune but missed
many "include" directives in there.
-- 
Duy
