From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 19:33:07 +0200
Message-ID: <8c5c35580705241033l73cb1295w4f1a33e74b745857@mail.gmail.com>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
	 <Pine.LNX.4.64.0705241039200.4648@racer.site>
	 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241201270.4648@racer.site>
	 <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241230410.4648@racer.site>
	 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241315290.4648@racer.site>
	 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
	 <7vabvuywix.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, skimo@liacs.nl,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Martin Waitz" <tali@admingilde.org>,
	"Alex Riesen" <raa.lkml@gmail.com>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 19:33:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrHBz-0002HF-0F
	for gcvg-git@gmane.org; Thu, 24 May 2007 19:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbXEXRdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 13:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbXEXRdO
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 13:33:14 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:22354 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbXEXRdM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 13:33:12 -0400
Received: by an-out-0708.google.com with SMTP id d31so86183and
        for <git@vger.kernel.org>; Thu, 24 May 2007 10:33:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E8+DVTuoq1E9UMJ/erLcf2gm/l8UadcDZsFcacif58bsZfauj2+6zGs0sAZZLCUBM0RL+WjLSc0Bn6L9awlR87dBbFxyMX9Kc/Pefoojh4VNAoF7iQeX7QJXa8VASA9IDMrFl81Q5RAHORHXBHYaOhIIovgGMF4lfxy9mBrAYwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cRcqDwoc8EnnT0FZRWmYKeHvhhC+s6VZvgcRDIzARzjhV+cwvF1ehcXWPtZRbXpW4mnstGK4LcEvrfVfulwU2+9fXaFRimmYVUTbQbhI2cCaiA0eaCz1Iwcu8CqlllGiRL23U3B/OEGGbsBI6dIMY0lqfRJIxTmXfyQakgDRNjU=
Received: by 10.114.195.19 with SMTP id s19mr1031722waf.1180027987300;
        Thu, 24 May 2007 10:33:07 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Thu, 24 May 2007 10:33:07 -0700 (PDT)
In-Reply-To: <7vabvuywix.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48279>

On 5/24/07, Junio C Hamano <junkio@cox.net> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > I think the whole point of the 'remote config' stuff is to get an
> > unversioned/out-of-tree .gitmodules file, right?
>
> Why does this have to be out-of-tree and unversioned to begin
> with?

Probably to cater for subprojects moving away from the url mentioned
in the versioned .gitmodules file.

> When you are bootstrapping, you will start by a fetch/clone of
> the superproject.  Why can't that tree contain necessary
> information that is relevant to the superproject in question?

It sure can, and it would be the most natural solution. I just wanted
to mention an alternative to the 'git config --remote' solution.

--
larsh
