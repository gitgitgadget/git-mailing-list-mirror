From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: Merging using only fast-forward
Date: Wed, 16 Jan 2008 14:38:20 -0800
Message-ID: <402c10cd0801161438u7443ebf2xdf1d6f3040ceb1a9@mail.gmail.com>
References: <loom.20080116T151930-575@post.gmane.org>
	 <863asxivlj.fsf@blue.stonehenge.com>
	 <7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 23:39:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFGuO-0006mF-A4
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 23:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbYAPWiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 17:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbYAPWiZ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 17:38:25 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:27254 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbYAPWiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 17:38:24 -0500
Received: by fk-out-0910.google.com with SMTP id z23so283186fkz.5
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 14:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KjKbOErG6C0P8lNPcjIUCaDls+7IuzOdvcscp5WdhV8=;
        b=Mvd1j1sL4CtGvcf01rgaKskldae5r8UtO+d57O2f6MIypZLXyJElp6C8qUSO1IsLpBM9K516qZ6/XLJBXz+Gpm4xEgcEpRUQmOG2lvYqFNT9zuS2nyeDuiSvoau7QXzehNgIZk+UtpQ2ftXZQtz4Qg6tkkSHRR5Zm6eMUkrdNH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bXY3QoOnVqP8a8SHIgB9Br91BCdJmo0NXENJB3tc4S/o5y4fO62OySq9c8H44zboeAfb589R+/Wl9Q1MAMOFn0KX/IloGpD8KSMNpRQgMaj4MqzngTFa5uv8m3GgKJQq+6Dj/qP3BVJQ5N5x7GtHnqBPCUDJ4DA6A5E7xKMjYh0=
Received: by 10.82.167.5 with SMTP id p5mr2426089bue.2.1200523100948;
        Wed, 16 Jan 2008 14:38:20 -0800 (PST)
Received: by 10.82.172.18 with HTTP; Wed, 16 Jan 2008 14:38:20 -0800 (PST)
In-Reply-To: <7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70757>

On Jan 16, 2008 12:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> A sane integration is a different story.
>
> We have --ff and --no-ff options to merge.  How should this new
> option --ff-only mesh with them?  Perhaps we would want to have
> an option --ff that takes three values?
>
>         --ff=never
>         --ff=normal
>         --ff=only
>
> and have the first one be synonym for existing --no-ff, the second
> one to be a synonym for not giving anything (or giving --ff
> explicitly), and the third one to be this new mode of operation?

Thanks for the patch.  I can probably look into it tonight and do the
suggested integration and test it out, I keep you posted.

-- 
Sverre Hvammen Johansen
