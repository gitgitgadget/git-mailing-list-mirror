From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [1.8.0] Re: reorganize the mess that the source tree has become
Date: Fri, 4 Feb 2011 19:15:50 +0100
Message-ID: <20110204181550.GA14173@vidovic>
References: <20110202022909.30644.qmail@science.horizon.com>
 <alpine.LFD.2.00.1102030036420.12104@xanadu.home>
 <AANLkTimnMDuAX-Ctc5K3mt=b2bz2FTsb_P7Fs8RzVwpd@mail.gmail.com>
 <AANLkTikhPRGZ9DxCWbWvBiac_DYiXYsnEdHVOnbHUdU4@mail.gmail.com>
 <87bp2sy2mf.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Eugene Sajine <euguess@gmail.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 04 19:16:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlQCR-0002mG-7O
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 19:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab1BDSP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 13:15:58 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59201 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab1BDSP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 13:15:57 -0500
Received: by ewy5 with SMTP id 5so1431643ewy.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 10:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=S3kP0cHIevPgl9qWbglgVPJvzJCF3bEGZmn9ooQi1W8=;
        b=A0c4p4nauGSj3ByksdUVtyR4f8JeeTzF+KbxJUZS5+FZKZAhiSwwp4HDcILZGrJhny
         3NMBdqpzog75Tv6Fwy7gOuY2CLUvHiqdIXM1DcVWzHLZV6OEv9iUDKc4zY0CMSARfwaP
         iv3vqmcTHKv81bD0Pz6wyLWZPDT/P2dvfvSOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q8QkL1gJ3DFpv+VDGHCjVQoW1YxW10Kg5u1kU7HPm8Y6dLJiv5q2bXkum+EvZUP+f/
         0akLzJCCnPbeEhk3z1ufgv9la85Gh6IfjUENqIn2E25hDDQIxEq2mtG7NDdEMzm9Uysx
         vMcehodB4kZluqvWNElFM1oIS5tjUfQp9K9JA=
Received: by 10.216.191.215 with SMTP id g65mr1000800wen.16.1296843355784;
        Fri, 04 Feb 2011 10:15:55 -0800 (PST)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id t11sm533796wes.41.2011.02.04.10.15.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Feb 2011 10:15:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87bp2sy2mf.fsf@catnip.gol.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166052>

The 04/02/11, Miles Bader wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
> > Quite frankly, I'm surprised there are (presumably experienced)
> > developers who do not immediately see the value of a little
> > organization. Surely, given the use of code conventions, formatting
> > rules, etcetera, the obvious one step further is to also organize
> > where the files go?
> 
> I think one of the problems is that what's been suggested seems like
> window-dressing.  Moving everything into src/ and calling it "organized"
> doesn't actually accomplish much other than perhaps making the README
> file more visible to newbs; things are _still_ a mess, just a mess with
> four more letters...

So it would be an ordered mess, at least. The current amount of files in
the root directory do make things harder for people not already familiar
with the content. FMHO, moving the source files into a subdirectory
could be only a first step to the good direction.

-- 
Nicolas Sebrecht
