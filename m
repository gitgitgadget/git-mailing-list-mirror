From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] api-allocation-growing.txt: encourage better variable
 naming
Date: Sun, 6 Jan 2013 20:52:08 +0000
Message-ID: <20130106205207.GA6552@pacific.linksys.moosehall>
References: <20130106152716.GB2396@pacific.linksys.moosehall>
 <1357486505-21357-1-git-send-email-git@adamspiers.org>
 <7v38yenjgy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 21:52:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrxCp-0005JN-Pe
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 21:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044Ab3AFUwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 15:52:12 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45959 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab3AFUwL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 15:52:11 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id D76AE2E5D3
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 20:52:08 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v38yenjgy.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212840>

On Sun, Jan 06, 2013 at 12:29:33PM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > The documentation for the ALLOC_GROW API implicitly encouraged
> > developers to use "ary" as the variable name for the array which is
> > dynamically grown.  However "ary" is an unusual abbreviation hardly
> > used anywhere else in the source tree, and it is also better to name
> > variables based on their contents not on their type.
> 
> Sounds good.  To follow "not type but contents", a further rewrite
> with s/array/item/ is even better, no?
> 
> I can obviously squash it in without resending, if you agree, or you
> can point out why item[] is not a good idea and array[] is better.

I agree.
