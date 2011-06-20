From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] Move contents of libgit.a to lib subdirectory
Date: Mon, 20 Jun 2011 01:47:13 -0500
Message-ID: <20110620064713.GA27992@elie>
References: <alpine.LNX.2.00.1106192014410.41113@linux.foleyremote.com>
 <BANLkTimjixOT=j9Xf=Ti-04cRw2noC0NiQ@mail.gmail.com>
 <7vd3i9dow4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Peter Foley <pefoley2@verizon.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 08:47:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYYGg-0006oh-83
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 08:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110Ab1FTGrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 02:47:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63809 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab1FTGrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 02:47:25 -0400
Received: by iwn6 with SMTP id 6so935585iwn.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 23:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=hZF+5JFjCNu5F+aMAbkJiNMcYTqu58FmIYt5iVbciJo=;
        b=iKeaAuYf/0I3hMIwtkA9ety/YVbQOA/vMPAyAdhhqrVD0J9uz34r4re2lRkPm1c0NB
         QEv4YH3yutSo5RfW8e6gzmgBtHbikBiswg1A9q9NvngmNWbZqq4cVwEJV6ona9yZfY7q
         bq/m5HUL/XiVdjBM96XQbRMydJhxdoKNyQyIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=upoglRyDK1tY3u8K0/eh2rCxA15/XPMWYHk7+7rOn/17boNI+d5ZAk/Er4Il8LzS04
         AJhVVw8HC5+BLPAm08cQlW9Ri7pQd49YKjwvl+7Ol/mtlGAElJAV8eWoj+jLCDImYQdE
         ciuo34l34xgrfsX8B9/8Qf1GCYlxDdMrJm/aI=
Received: by 10.231.117.35 with SMTP id o35mr4805177ibq.149.1308552444461;
        Sun, 19 Jun 2011 23:47:24 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.sbcglobal.net [69.209.50.158])
        by mx.google.com with ESMTPS id ft12sm3005769ibb.36.2011.06.19.23.47.22
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 23:47:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd3i9dow4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176051>

Junio C Hamano wrote:
> Shawn Pearce <spearce@spearce.org> writes:

>> ... But why is this amount of churn necessary or being
>> recommended? What problem does this address? Is that worth the pain
>> this puts on every other in-flight change that is still being
>> developed, or is already in the review pipeline?
>
> No reason and not recommended; nothing; not worth.
>
> Especially during the pre-release freeze.

It's unlikely the patch would be cooked by the time there is a
release, or even in the moments of quiet after that.  If this were a
patch intended for immediate inclusion, the timing would be
unfortunate, but for an RFC I wouldn't have expected the release
timing to be very relevant.

A better thought out version of this patch, meaning timed
appropriately and taking into account the comments that came up the
last times the subject was discussed, would imho be a good thing.
Part of thinking it through is to consider the effect on in-flight
patches and to consider whether it's possible to mitigate that.

In other words, I think Shawn's questions get right to the point.
I hope the above answers --- which do seem to correctly reflect the
state of things in absence of such thinking --- will not dissuade
someone from finding a good answer.

More prior discussion for the sort of masochistic person who wants to
work on it: [1].  I admit I can imagine easier tasks. :)

Just my two cents,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/165748/focus=165801
