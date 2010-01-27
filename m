From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH not-for-mainline] Implement git-vcs-p4
Date: Wed, 27 Jan 2010 19:49:59 +0200
Message-ID: <20100127174959.GA20929@Knoppix>
References: <alpine.LNX.2.00.1001251628431.14365@iabervon.org>
 <1a6be5fa1001270318h4ac8ac3bnaba48787a5b3efa6@mail.gmail.com>
 <20100127155636.GA18210@Knoppix>
 <alpine.LNX.2.00.1001271145500.14365@iabervon.org>
 <20100127171426.GA20820@Knoppix>
 <alpine.LNX.2.00.1001271218360.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tor Arvid Lund <torarvid@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 18:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaC1s-0007Gp-H5
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 18:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524Ab0A0RuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 12:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754352Ab0A0RuE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 12:50:04 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:58716 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab0A0RuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 12:50:04 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id E11A018D2B3;
	Wed, 27 Jan 2010 19:50:02 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A03A2CA77FB; Wed, 27 Jan 2010 19:50:02 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id C55C02BD4D;
	Wed, 27 Jan 2010 19:49:59 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1001271218360.14365@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138177>

On Wed, Jan 27, 2010 at 12:28:07PM -0500, Daniel Barkalow wrote:
> On Wed, 27 Jan 2010, Ilari Liusvaara wrote:
> 
> Yes, but the first URL should be directed to the 'gits' helper 
> without setting remote->foreign_vcs. 

Updated patch done that way coming shortly...

> That is, instead of setting 
> remote->foreign_vcs, you should just call transport_helper_init(ret, 
> xstrndup(url, p - url));

That doesn't quite work...

-Ilari
