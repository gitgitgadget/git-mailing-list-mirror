From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Mon, 25 Feb 2008 21:15:35 -0500
Message-ID: <47C37647.90908@gmail.com>
References: <47AAA254.2020008@thorn.ws>	<20080207063020.GP24004@spearce.org>	<200802071056.19370.robin.rosenberg.lists@dewire.com>	<20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>	<20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org> <18368.41742.689290.877767@cargo.ozlabs.ibm.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 03:16:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTpMk-0001id-6t
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 03:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053AbYBZCPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 21:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757334AbYBZCPq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 21:15:46 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:62175 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756928AbYBZCPp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 21:15:45 -0500
Received: by wr-out-0506.google.com with SMTP id c48so2891147wra.23
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 18:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=nAu3oPsHIsvdAWoUgFA1M2MAN1T3KyDRUxw72oAK378=;
        b=b+CT8M3Rnd+4rZBa7HqUGhUrkXC1PiFevh38rQ8EstO00qMiEYZ99b3rpGDztcw8SuDZeSLnPrldvg7tVQK2IwNmEnJydKZp0MCpIsuMIknfISCleWgzf1v+VPg8n2DE8Q8pAKVAU+/5HKvS6oqBHCrt3wKnB/VhUg7L5qO2aAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ApyXB9FuUICQkFCdeVHazUi/cuShiUbyhK80r0P4BDjWoIq4MaRNDShdsIZED8GGxEKY3UC/70+EAMVGECg6cWBrnbD8/ttuN7TPH9NXo9BysM1MmW64jJVbP4It+SZEFMAShmawXpHxnzfO/YkAfCuCQEYA0OaXjaHwv2AriMc=
Received: by 10.140.132.8 with SMTP id f8mr2763147rvd.198.1203992143163;
        Mon, 25 Feb 2008 18:15:43 -0800 (PST)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id h2sm7155426rnb.16.2008.02.25.18.15.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Feb 2008 18:15:42 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <18368.41742.689290.877767@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75100>

Paul Mackerras wrote:
> Gerrit Pape writes:
> 
>> Saving the geometry can cause several inconveniences, e.g. when using a
>> temporary dual screen setup, or sharing ~/.gitk between multiple
>> systems.  Additionally it can be argued that window placement and sizing
>> are the tasks of the window manager.  So don't do that anymore.
> 
> I myself find it useful to have gitk remember the size and layout of
> the various panes, so I won't be applying this patch.
> 
> The saving/restoring of the window position was done by Mark Levedahl
> to make gitk work properly on Cygwin.  I agree it can be annoying on X
> and I would take a patch to inhibit the restoring of the window
> position when running under X.  I'd want an ack from Mark before
> making that change more generally.

I use gitk under X and like the saving/restoring of window 
size/geometry. Please do not remove that feature.
