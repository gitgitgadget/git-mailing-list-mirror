From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Wed, 1 Sep 2010 00:07:03 -0400
Message-ID: <20100901040702.GH16034@foucault.redhat.com>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
 <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
 <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
 <20100831143839.GC16034@foucault.redhat.com>
 <20100901035623.GA8775@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Sep 01 06:07:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqebX-0007hZ-N0
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 06:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132Ab0IAEHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 00:07:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41710 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937Ab0IAEHL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 00:07:11 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o81476dE017429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 1 Sep 2010 00:07:06 -0400
Received: from foucault.redhat.com (vpn-10-249.rdu.redhat.com [10.11.10.249])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o81473eZ031858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 1 Sep 2010 00:07:05 -0400
Content-Disposition: inline
In-Reply-To: <20100901035623.GA8775@LK-Perkele-V2.elisa-laajakaista.fi>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155014>

On Wed, Sep 01, 2010 at 06:56:24AM +0300, Ilari Liusvaara wrote:
> On Tue, Aug 31, 2010 at 10:38:39AM -0400, Casey Dahlin wrote:
> > 
> > And we can exchange them
> > 
> > 	casey@host_a$ git hive fetch nguyen for_casey
> > 	casey@host_a$ git branch
> > 	* master
> > 	  stable
> > 	  for_casey
> > 
> > Note that the two arguments in fetch are a regex which searches through user
> > IDs and a branch name, which is why I can abbreviate to just "nguyen" in all
> > lower case.
> 
> Any possibilty for adding remote helper for fetching/pulling directly using
> fetch? You have full-duplex connectivity and Git running on both ends,
> right[1]?
> 
> [1] remote-helper connect command is designed for just these sort of cases.
> 
> -Ilari

Yep. This will be patch v2 :)
