From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Use a 16-tree instead of a 256-tree for storing notes
Date: Wed, 26 Aug 2009 14:56:55 +0200
Message-ID: <200908261456.55906.johan@herland.net>
References: <1248834326-31488-1-git-send-email-johan@herland.net> <200908261231.01616.johan@herland.net> <81b0412b0908260505m233d9a5cmefdd81e1ef51a299@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 15:04:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgIAY-00073s-QV
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 15:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945AbZHZND5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 09:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbZHZND4
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 09:03:56 -0400
Received: from sam.opera.com ([213.236.208.81]:33833 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932927AbZHZND4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 09:03:56 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n7QCuumX010245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Aug 2009 12:57:01 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <81b0412b0908260505m233d9a5cmefdd81e1ef51a299@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127093>

On Wednesday 26 August 2009, Alex Riesen wrote:
> On Wed, Aug 26, 2009 at 12:31, Johan Herland<johan@herland.net> wrote:
> > The 256-tree structure is considerably faster than storing all
> > entries in a
>
> This part is confusing. Was 256-tree better (as in "faster") then?

256-tree is faster than the everything-in-hash_map draft.
16-tree is slightly faster than 256-tree

256-tree uses more memory (in the worst case) that the 
everything-in-hash-map draft.
16-tree uses less memory than both.


Makes sense?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
