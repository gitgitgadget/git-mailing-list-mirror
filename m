From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/RFC] fast-import: insert new object entries at start of
 hash bucket
Date: Tue, 23 Nov 2010 13:51:16 +0100
Message-ID: <AANLkTikK+vO2fLseChD8iccA0=M0FXp6TmWAPeaK9v+R@mail.gmail.com>
References: <20101123075348.GA10367@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Raja R Harinath <harinath@hurrynot.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 13:51:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKsLX-0006LN-Pn
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 13:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab0KWMvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 07:51:39 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47587 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340Ab0KWMvi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 07:51:38 -0500
Received: by gxk24 with SMTP id 24so265992gxk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 04:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=vSeG6qKaFQmhIl53g2iGwY5cvgdPKg+xud+d8Enu59o=;
        b=Jm+FeB5b1FhupD6wR1acI0BI1qkdOHN1gmSXcTVRUYhcPgVYp7YnfjKBPEx00xyw0a
         u6hQzRW9fJdjlY26x9SJkE6J4DCCyl/J30U5IPj0B+iGTbzaa9PZJiW6UdZFbFn/eDgW
         8LxEZYTQKePu6vmqTBaJe6im58ObdG7oo8Eqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Hrt1NSKTr422u0bxrmx9ixLpuS2NNMSl3eEGERWa81GvIoedmgcZf8vkYV/zKSjaJo
         7/kg9MANzspEw0D/t0mie3gaIGlCo0AhXPJpWXsX6UZrU9l4lzzQyLjnNlse/bkO4sjH
         R4Zi7Cw38RiMcBAU6xItTOOKHR4ICmAxhWhAE=
Received: by 10.150.217.1 with SMTP id p1mr11515294ybg.185.1290516697221; Tue,
 23 Nov 2010 04:51:37 -0800 (PST)
Received: by 10.151.100.3 with HTTP; Tue, 23 Nov 2010 04:51:16 -0800 (PST)
In-Reply-To: <20101123075348.GA10367@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161954>

Heya,

On Tue, Nov 23, 2010 at 08:53, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Thoughts?

Are there (m)any non-artificial cases for which this slows things down (a lot)?

-- 
Cheers,

Sverre Rabbelier
