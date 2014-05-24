From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: Do not include diff in spec file when just
 preparing p4
Date: Sat, 24 May 2014 09:52:15 -0400
Message-ID: <20140524135215.GA9386@padd.com>
References: <20140110181807.GA29164@nekage>
 <20140112222946.GA13519@padd.com>
 <20140113121011.GA9711@nekage>
 <20140114000613.GA11594@padd.com>
 <20140524013942.GA29751@nekage>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maxime Coste <frrrwww@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 15:52:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoCN4-000538-SF
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 15:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbaEXNwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2014 09:52:19 -0400
Received: from honk.padd.com ([71.19.245.7]:50510 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbaEXNwS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2014 09:52:18 -0400
Received: from arf.padd.com (unknown [50.105.4.164])
	by honk.padd.com (Postfix) with ESMTPSA id C7BF4628A;
	Sat, 24 May 2014 06:52:17 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 2F32320D49; Sat, 24 May 2014 09:52:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140524013942.GA29751@nekage>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250060>

frrrwww@gmail.com wrote on Sat, 24 May 2014 02:39 +0100:
> The diff information render the spec file unusable as is by p4,
> do not include it when run with --prepare-p4-only so that the
> given file can be directly passed to p4.
> 
> With --prepare-p4-only, git-p4 already tells the user it can use
> p4 submit with the generated spec file. This fails because of the
> diff being present in the file. Not including the diff fixes that.
> 
> Without --prepare-p4-only, keeping the diff makes sense for a
> quick review of the patch before submitting it. And does not cause
> problems with p4 as we remove it programmatically.
> 
> Signed-off-by: Maxime Coste <frrrwww@gmail.com>

Hi Maxime.  This looks really good.  Even the Windows section
is fine; thanks for paying attention there too.

I'm not particularly worried about having a new test for this.
Your tweak to the existing 9807 is fine.  Unless of course you
have one ready to go.

Acked-by: Pete Wyckoff <pw@padd.com>

You might add my ack and send it directly to Junio + CC the list.
It'll be a nice improvement for the next available release.

		-- Pete
