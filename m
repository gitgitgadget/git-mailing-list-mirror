From: "Todd A. Jacobs" <nospam@codegnome.org>
Subject: Re: Integrating with hooks
Date: Wed, 14 Nov 2007 17:18:37 -0800
Message-ID: <20071115011837.GD32746@penguin.codegnome.org>
References: <20071113173721.GI25282@penguin.codegnome.org>
	<fhdane$kfs$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 02:19:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsTNk-0007Pc-8m
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 02:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424AbXKOBSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 20:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754274AbXKOBSo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 20:18:44 -0500
Received: from mtai04.charter.net ([209.225.8.184]:44228 "EHLO
	mtai04.charter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbXKOBSn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 20:18:43 -0500
X-Greylist: delayed 114075 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Nov 2007 20:18:43 EST
Received: from aarprv02.charter.net ([10.20.200.72]) by mtai04.charter.net
          (InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
          id <20071115011840.BKJH12338.mtai04.charter.net@aarprv02.charter.net>
          for <git@vger.kernel.org>; Wed, 14 Nov 2007 20:18:40 -0500
Received: from penguin.codegnome.org ([71.83.124.90])
          by aarprv02.charter.net with ESMTP
          id <20071115011840.CBPZ495.aarprv02.charter.net@penguin.codegnome.org>
          for <git@vger.kernel.org>; Wed, 14 Nov 2007 20:18:40 -0500
Received: by penguin.codegnome.org (Postfix, from userid 1000)
	id D23E037CA8; Wed, 14 Nov 2007 17:18:37 -0800 (PST)
Received: by penguin.codegnome.org (tmda-sendmail, from uid 1000);
	Wed, 14 Nov 2007 17:18:37 -0800
Content-Disposition: inline
In-Reply-To: <fhdane$kfs$1@ger.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
Mail-Followup-To: git@vger.kernel.org
X-Chzlrs: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65038>

On Wed, Nov 14, 2007 at 12:07:29AM +0100, Jakub Narebski wrote:

> Take a look at gitattributes(5), namely 'filter' attribute.

Thanks, I took a look at the man page you suggested. The "ident" feature
almost does what I want, but doesn't seem to take any sort of format
string. So, I thought I'd explore "filter," but can't really find any
examples of how to implement the smudge and clean commands, which seem
to be what I'm really trying to do here.

Is there an example somewhere that you can point me to? The man page
doesn't really show any examples of how to implement the filter
attribute, so I'm a little unsure how to proceed.

-- 
"Oh, look: rocks!"
	-- Doctor Who, "Destiny of the Daleks"
