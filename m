From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH/RFC 2/2] completion: allow use without compiling
Date: Tue, 27 Oct 2009 01:33:53 +0100
Message-ID: <20091027003353.GA29205@localhost>
References: <1256589116-6998-1-git-send-email-bebarino@gmail.com> <1256589116-6998-3-git-send-email-bebarino@gmail.com> <7vocntd7vt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 01:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2a0V-0002Yl-Pi
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 01:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779AbZJ0Adl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 20:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755748AbZJ0Adk
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 20:33:40 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:57022 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751AbZJ0Adi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 20:33:38 -0400
Received: by ewy4 with SMTP id 4so4187519ewy.37
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 17:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=dP/e4ZfAP3eG3ekiiPN43bNj3uaq1PFNYGeaUyc3dFU=;
        b=Kdsgu6vMLnkYEohmCufFnOb1P/UnBQid34PbAMJiiFD0rOCs5jvR5jIpq20cOzr7tN
         UBqk9UNeLEHXPPuEtl01ZsasKVEGl+YftKieHJQyG81psw8BMhHKbGdT7CSOq0MLVhS5
         3o3RtjwfVXsetheQTvSXkg8aWveaOOVL7DeM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=INcnUkpGrPYpWW/ztfBrWPg1ZdEd11a4IX0POdwJ0KOgK4kp4ZvcolEWcYIaVW3nAd
         WmZUkAB7bnBxC9A8Y3d5cZ80p2K6e/98KLgkUG3wv7sAFLo9QVtfpNivGAvTEIvDVmm9
         oM11+FLxIMBeNmOS9cMFyMGi8gkTk921bkFHg=
Received: by 10.211.147.10 with SMTP id z10mr3343728ebn.28.1256603622316;
        Mon, 26 Oct 2009 17:33:42 -0700 (PDT)
Received: from darc.lan (p549A6E37.dip.t-dialin.net [84.154.110.55])
        by mx.google.com with ESMTPS id 4sm22473990ewy.57.2009.10.26.17.33.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 17:33:41 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N2a0X-0007gI-7y; Tue, 27 Oct 2009 01:33:53 +0100
Content-Disposition: inline
In-Reply-To: <7vocntd7vt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131294>

On Mon, Oct 26, 2009 at 04:59:18PM -0700, Junio C Hamano wrote:

> Stephen Boyd <bebarino@gmail.com> writes:
> 
> >  This duplicates code, but I don't know of a way to re-use the dynamic
> >  code without sourcing a bash script and possibly breaking someone's build.
>
>  (1) If the script notices that there is a file that contains the command
>      list, it sources it; otherwise,

Or we substitute the command list in-place, so that we still have the entire
completion script in one file.

Clemens
