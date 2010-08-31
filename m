From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Tue, 31 Aug 2010 15:25:39 -0400
Message-ID: <20100831192539.GG16034@foucault.redhat.com>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
 <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
 <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
 <20100831143839.GC16034@foucault.redhat.com>
 <AANLkTinF1o0RZSKYEL9Qc=uwXx6fBBXh6wRx2CTULBSE@mail.gmail.com>
 <20100831155159.GD16034@foucault.redhat.com>
 <815C806E-E7DC-4B7D-9B45-4C9B289DFEEF@sb.org>
 <20100831191909.GF16034@foucault.redhat.com>
 <9CA6AC3D-5C51-4770-BF78-077DE5CD80C5@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:26:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWTF-00007l-G6
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280Ab0HaTZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 15:25:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64483 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755267Ab0HaTZp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 15:25:45 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7VJPgOP002669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 31 Aug 2010 15:25:42 -0400
Received: from foucault.redhat.com (vpn-11-196.rdu.redhat.com [10.11.11.196])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o7VJPdW5027960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 31 Aug 2010 15:25:41 -0400
Content-Disposition: inline
In-Reply-To: <9CA6AC3D-5C51-4770-BF78-077DE5CD80C5@sb.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154972>

> > 
> > Avahi is Linux's Bonjour implementation ;)
> > 
> > --CJD
> 
> Ah hah, now it makes sense. I guess I should have looked up Avahi before just assuming it was some other P2P doohickey. Now, if git-hive is running on OS X, will it still be using a bundled version of Avahi, or will it default to using the system-provided mDNSResponder daemon (e.g. OS X's Bonjour)?
> 

Not sure Avahi will be used at all at this point given present objections. Its
hard because although its the same protocol, I believe the api is different, so
we'd need additional code. I don't think bundling Avahi on OSX is the right
answer to anything regardless.

--CJD
