From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: suggest name for OPML view
Date: Sat, 10 Jan 2009 14:15:48 -0500
Message-ID: <cb7bb73a0901101115i541f0911o42f08fc47820fb82@mail.gmail.com>
References: <1230900570-25324-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200901101510.20918.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 20:17:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLjKd-0001qO-HL
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 20:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbZAJTPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 14:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbZAJTPv
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 14:15:51 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:35984 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbZAJTPu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 14:15:50 -0500
Received: by ewy10 with SMTP id 10so10798375ewy.13
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 11:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wsFtJ1pFS2S7KN/RopHYQ3QkAZBIbicI5/vFsQ5DgBw=;
        b=DciWypaUSZ48d3/ZwlJni4amDLmJUyrJaJJ8A8OHFmKso2apXpg437tRicgVFmV9vg
         7imF8U7EYTK3eS4N5LRHFoao6b6LnhZtuflCKYzfjuaYvkx3Xvi4qKY8vosFCq69gLes
         OVpOTWK70TCFhckVvsV+uVcJXMISTo0pDuRRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Vp8/B4yXoVCFEpIeQUD/eMVgFGsMCTInla9T8pr9Wo9hPaFjCut2PjEpBOnrVtZNtH
         l4NkXdUawiE2x4DCKxC9oL7VpF3DMSyRYMWU5M1O7jL5VI0+XP0iUyy1P4ReQQKPaIkG
         a0KY82fyxw57IPXlQn8eTPbaAEFrFyMEk1JXM=
Received: by 10.210.35.17 with SMTP id i17mr8816159ebi.165.1231614948473;
        Sat, 10 Jan 2009 11:15:48 -0800 (PST)
Received: by 10.210.57.20 with HTTP; Sat, 10 Jan 2009 11:15:48 -0800 (PST)
In-Reply-To: <200901101510.20918.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105138>

On Sat, Jan 10, 2009 at 9:10 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Fri, 2 Jan 2009, Giuseppe Bilotta wrote:
>
>> Suggest opml.xml as name for OPML view by providing the appropriate
>> header, consistently with similar usage in project_index view.
>
> It is not name for a view, but more of default filename when saving
> it. While it is good idea to have consistency, I guess that while
> 'project_index' view and other non-HTML views are meant to be
> downloaded and saved (snapshots, patches, patchsets), OPML view
> is meant to be used on-line, just like web feeds in RSS and Atom
> formats which are non-HTML too but do not have Content-Disposition
> header set.

OPML is used for import/export of RSS feed lists between aggregators
(e.g. moving your reading list from knewsreader to google reader). As
such, it can also be comfortable to save it to disk for import by some
tools. IMO, of course. And there's also the consistency thing, and not
actual reason _not_ to offer the filename, since it comes pretty
cheap.

-- 
Giuseppe "Oblomov" Bilotta
