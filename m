From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Tue, 31 Aug 2010 15:19:09 -0400
Message-ID: <20100831191909.GF16034@foucault.redhat.com>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
 <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
 <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
 <20100831143839.GC16034@foucault.redhat.com>
 <AANLkTinF1o0RZSKYEL9Qc=uwXx6fBBXh6wRx2CTULBSE@mail.gmail.com>
 <20100831155159.GD16034@foucault.redhat.com>
 <815C806E-E7DC-4B7D-9B45-4C9B289DFEEF@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:19:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWMb-000464-0j
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab0HaTTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 15:19:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41228 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969Ab0HaTTO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 15:19:14 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7VJJC8o004527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 31 Aug 2010 15:19:12 -0400
Received: from foucault.redhat.com (vpn-11-196.rdu.redhat.com [10.11.11.196])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o7VJJ965022127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 31 Aug 2010 15:19:11 -0400
Content-Disposition: inline
In-Reply-To: <815C806E-E7DC-4B7D-9B45-4C9B289DFEEF@sb.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154968>

On Tue, Aug 31, 2010 at 12:15:39PM -0700, Kevin Ballard wrote:
> What about using Bonjour (a.k.a. DNS-SD) on OSes that provide this functionality? A lot of us already have local networks that are designed to let Bonjour propagate across the entire network, but hasn't been tested on simple UDP multicast. And with Bonjour you can even get wide-area Bonjour domains, so for example I could set up git hive on my desktop at home, and then get at it via my MobileMe wide-area Bonjour domain from anywhere else in the world.
> 
> -Kevin Ballard
> 

Avahi is Linux's Bonjour implementation ;)

--CJD
