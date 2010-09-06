From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Sun, 5 Sep 2010 22:28:06 -0400
Message-ID: <20100906022805.GB15150@foucault.redhat.com>
References: <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
 <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
 <20100831143839.GC16034@foucault.redhat.com>
 <AANLkTinF1o0RZSKYEL9Qc=uwXx6fBBXh6wRx2CTULBSE@mail.gmail.com>
 <20100831155159.GD16034@foucault.redhat.com>
 <815C806E-E7DC-4B7D-9B45-4C9B289DFEEF@sb.org>
 <20100831191909.GF16034@foucault.redhat.com>
 <9CA6AC3D-5C51-4770-BF78-077DE5CD80C5@sb.org>
 <20100831192539.GG16034@foucault.redhat.com>
 <4C83F8CE.2060403@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 04:28:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsRRu-0002Av-6W
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 04:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124Ab0IFC2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 22:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15159 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753972Ab0IFC2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 22:28:41 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o862S9pT007067
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 5 Sep 2010 22:28:09 -0400
Received: from foucault.redhat.com (vpn-8-6.rdu.redhat.com [10.11.8.6])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o862S6AW018407
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 5 Sep 2010 22:28:08 -0400
Content-Disposition: inline
In-Reply-To: <4C83F8CE.2060403@dbservice.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155514>

On Sun, Sep 05, 2010 at 10:08:46PM +0200, Tomas Carnecky wrote:
> On 8/31/10 9:25 PM, Casey Dahlin wrote:
> > Not sure Avahi will be used at all at this point given present objections. Its
> 
> Which objections?
> 

I believe Luke outlined some issues earlier, particularly the difficulty of
getting avahi on Windows. If others would like to continue that flame without
me I'll step in and decide the winner when everyone's tired out :)

> > hard because although its the same protocol, I believe the api is different, so
> > we'd need additional code. I don't think bundling Avahi on OSX is the right
> > answer to anything regardless.
> 
> You can code against the mDNSResponder API and on Linux use the Avahi
> mDNSResponder compatibility layer.
> 

Good to know :)

--CJD
