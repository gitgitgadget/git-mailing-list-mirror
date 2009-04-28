From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Add --reference option to git submodule
Date: Tue, 28 Apr 2009 14:27:38 +0300
Message-ID: <20090428112738.GC27513@redhat.com>
References: <20090428065237.GA5972@redhat.com> <49F6E419.1020308@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 13:30:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LylWX-0000HU-3R
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 13:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbZD1Laq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 07:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbZD1Lap
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 07:30:45 -0400
Received: from mx2.redhat.com ([66.187.237.31]:57104 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbZD1Lao (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 07:30:44 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n3SBSewU024798;
	Tue, 28 Apr 2009 07:28:40 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n3SBSd8n012569;
	Tue, 28 Apr 2009 07:28:40 -0400
Received: from redhat.com (vpn-10-44.str.redhat.com [10.32.10.44])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n3SBSbPb032706;
	Tue, 28 Apr 2009 07:28:38 -0400
Content-Disposition: inline
In-Reply-To: <49F6E419.1020308@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117765>

On Tue, Apr 28, 2009 at 01:10:17PM +0200, Michael J Gruber wrote:
> > @@ -177,6 +179,14 @@ OPTIONS
> >  	This option is only valid for the update command.
> >  	Don't fetch new objects from the remote site.
> >  
> > +--reference <repository>::
> > +	This option is only valid for add and update commands.  These
> 
> This option applies only to add...

The rest of the documentation has 'is only valid' language.
I guess we need to be consistent? Rewrite these as well?

-- 
MST
