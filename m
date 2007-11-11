From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: git packs
Date: Sun, 11 Nov 2007 11:09:42 +0000
Message-ID: <20071111110942.A4013@edi-view2.cisco.com>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com> <00593593-E943-4DA0-AA9B-FDBB866E7EFB@mac.com> <20071110174559.GA2200@old.davidb.org> <134659C4-BA10-4B9E-9C64-2754A90D93F8@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bob <kranki@mac.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 12:20:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrAr7-0005fY-TW
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 12:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbXKKLTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 06:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbXKKLTc
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 06:19:32 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:63987 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbXKKLTb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 06:19:31 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2007 06:19:30 EST
X-IronPort-AV: E=Sophos;i="4.21,401,1188770400"; 
   d="scan'208";a="157372645"
Received: from ams-dkim-1.cisco.com ([144.254.224.138])
  by ams-iport-1.cisco.com with ESMTP; 11 Nov 2007 12:09:43 +0100
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id lABB9giv009620;
	Sun, 11 Nov 2007 12:09:42 +0100
Received: from edi-view2.cisco.com (edi-view2.cisco.com [64.103.71.156])
	by ams-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id lABB9g8i028886;
	Sun, 11 Nov 2007 11:09:42 GMT
Received: (dfawcus@localhost) by edi-view2.cisco.com (8.11.2/CISCO.WS.1.2) id lABB9gM15755; Sun, 11 Nov 2007 11:09:42 GMT
X-Mailer: Mutt 1.0.1i
In-Reply-To: <134659C4-BA10-4B9E-9C64-2754A90D93F8@mac.com>; from kranki@mac.com on Sat, Nov 10, 2007 at 01:01:46PM -0500
DKIM-Signature: v=0.5; a=rsa-sha256; q=dns/txt; l=426; t=1194779382; x=1195643382;
	c=relaxed/simple; s=amsdkim1002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dfawcus@cisco.com;
	z=From:=20Derek=20Fawcus=20<dfawcus@cisco.com>
	|Subject:=20Re=3A=20git=20packs
	|Sender:=20;
	bh=aUGWeWCYAl05kGPn4VxlMlvoJUTaXkWlKm+7ZSsde4g=;
	b=Ycb8GecXzzUt8q9oHuc6l3SRrghJUycPQOyRZ3TU8LziBZb+cEBswnkzyVWDqtl6rpLoOdMy
	+CtFZ2SfxCG/V2kHxqcAVju5ID/4ZJZyzX620e4F+CT/bd7ktymvbBda;
Authentication-Results: ams-dkim-1; header.From=dfawcus@cisco.com; dkim=pass (
	sig from cisco.com/amsdkim1002 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64446>

On Sat, Nov 10, 2007 at 01:01:46PM -0500, bob wrote:
> It is fairly disappointing as far as indicating the problem.  Here is  
> the entire report since it was so short.

> Error Formulating Crash Report:
> *** -[NSCFDictionary setObject:forKey:]: attempt to insert nil value  
> (key: VMUSignaturePath)

huh?  The above looks like an ObjC invocation.  Last I checked,  git was C.
So why is that in the frame?

DF
