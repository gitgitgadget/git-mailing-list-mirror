From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Dealing with mac linefeeds in git repository
Date: Wed, 31 Mar 2010 17:16:08 +0300
Message-ID: <20100331141608.GA2542@LK-Perkele-V2.elisa-laajakaista.fi>
References: <OF7E748769.D4E7BC90-ONC22576F7.00483B3D-C22576F7.00484D0A@sks.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: jussi.sirpoma@sks.fi
X-From: git-owner@vger.kernel.org Wed Mar 31 16:16:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwyiY-0007pO-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 16:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436Ab0CaOQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 10:16:21 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:52668 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873Ab0CaOQU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 10:16:20 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 80C598C4D1;
	Wed, 31 Mar 2010 17:16:19 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0320B50B04; Wed, 31 Mar 2010 17:16:19 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 68E6C1C6384;
	Wed, 31 Mar 2010 17:16:17 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <OF7E748769.D4E7BC90-ONC22576F7.00483B3D-C22576F7.00484D0A@sks.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143676>

On Wed, Mar 31, 2010 at 04:07:40PM +0300, jussi.sirpoma@sks.fi wrote:
> I am running cygwin git version 1.6.4.2.
> 
> Some of the source code for our projects is encoded in mac linefeeds due 
> to proprietary
> software platform. My current solution is to flag those files tu use no 
> linefeed conversion and
> to use separate diff program by having this in .gitattributes:

> annotations or diffs. Now I am wondering if I could make git work with a 
> little different 
> configuration:
> 
> * The *.BA files with mac linefeeds would be stored with normal linux 
> linefeeds
> * The files would be converted on checkout to mac linefeeds the same way 
> as core.autcrlf works
> 
> Is this doable or even a good approach?
 
AFAIK, its doable. One can specify filter programs to be executed when
checking out / adding files. That program could do CR <-> LF translation.

See filter attribute in man gitattributes.

-Ilari
