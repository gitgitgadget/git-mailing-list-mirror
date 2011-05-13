From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/8] revert: Introduce a struct to parse command-line
 options into
Date: Fri, 13 May 2011 05:07:22 -0500
Message-ID: <20110513100722.GC30396@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-4-git-send-email-artagnon@gmail.com>
 <20110511112438.GD2676@elie>
 <20110513093253.GD14272@ramkum.desktop.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 12:07:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKpHW-0006SW-Vt
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 12:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757363Ab1EMKHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 06:07:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37775 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab1EMKH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 06:07:28 -0400
Received: by iwn34 with SMTP id 34so2139287iwn.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=k629ko2x3XLiXxICatdE3o4FC6G68Zn4otQjCCcilfo=;
        b=HYTty6vc1CpUseqLxX8Mm2U4/vLdyhkwKyVZNQh1vhjrEQEv5gXRZw6T2+cAFeOyQb
         88h9fsp4AKPAMDVxyXwjw53p5wnC09JfLBdZx6LoXLEpUEguEkd8d93Andr1tiGw3MQx
         c8C6OlcYybrMzrAvyiWrY2LzyATxz2EIZVCyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mkEEjGO8u1aT6fUMcn9gnfLoG8F+mEYF3I/LQx9afBsMBOWSZ+/IfcN6j0MidrBULT
         jmc8QTp4nCjiHBbd3oMSKfmlPx+LJCc8SjbgzTnUwhxNkZ18wvOis12rPKkFY4/ZMsdP
         nT/8afdpyhoQH/FjDNvrzf5k0WazjA/M8wiGI=
Received: by 10.42.146.134 with SMTP id j6mr1472477icv.282.1305281247937;
        Fri, 13 May 2011 03:07:27 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id u17sm907724ibm.45.2011.05.13.03.07.25
        (version=SSLv3 cipher=OTHER);
        Fri, 13 May 2011 03:07:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110513093253.GD14272@ramkum.desktop.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173522>

Ramkumar Ramachandra wrote:

> In my defense, I thought whitespace (indentation, style) changes were
> permitted as long as I'm making a functional change.  If this isn't
> the case, when can I correct the style/ indentation?

What I generally try to do is to only correct style and indentation
when it is making my life difficult (either in reading or writing the
code), through a separate commit that explains the improvement.  That
way, a person reading the diff for a functional change doesn't have to
be distracted by irrelevant changes.

Based on the advice he gives from time to time, Junio's policy seems
to be that trivial cosmetic cleanups should either be very compelling
or go at the start of a series that makes other changes to the same
section of code.
