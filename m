From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: "Argument list too long" in git remote update (Was: Git and GCC)
Date: Tue, 18 Dec 2007 01:34:01 +0000
Message-ID: <20071218013401.A1716@edi-view2.cisco.com>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com> <2007-12-05-21-23-14+trackit+sam@rfc1149.net> <1196891451.10408.54.camel@brick> <jeeje0ogvk.fsf@sykes.suse.de> <1196897840.10408.57.camel@brick> <38a0d8450712130640p1b5d74d6nfa124ad0b0110d64@mail.gmail.com> <1197572755.898.15.camel@brick> <37BDCA73-4318-4BC8-9CCE-1DA30E4A09FC@adacore.com> <alpine.LFD.0.9999.0712171455220.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 02:45:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4RWe-00028J-7v
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 02:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936462AbXLRBoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 20:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936957AbXLRBoL
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 20:44:11 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:46934 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937216AbXLRBoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 20:44:09 -0500
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2007 20:44:08 EST
X-IronPort-AV: E=Sophos;i="4.24,178,1196636400"; 
   d="scan'208";a="1142697"
Received: from ams-dkim-1.cisco.com ([144.254.224.138])
  by ams-iport-1.cisco.com with ESMTP; 18 Dec 2007 02:34:03 +0100
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id lBI1Y2Nl021888;
	Tue, 18 Dec 2007 02:34:02 +0100
Received: from edi-view2.cisco.com (edi-view2.cisco.com [64.103.71.156])
	by ams-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id lBI1Y1AC012522;
	Tue, 18 Dec 2007 01:34:02 GMT
Received: (dfawcus@localhost) by edi-view2.cisco.com (8.11.2/CISCO.WS.1.2) id lBI1Y1703444; Tue, 18 Dec 2007 01:34:01 GMT
X-Mailer: Mutt 1.0.1i
In-Reply-To: <alpine.LFD.0.9999.0712171455220.21557@woody.linux-foundation.org>; from torvalds@linux-foundation.org on Mon, Dec 17, 2007 at 03:01:25PM -0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; l=594; t=1197941642; x=1198805642;
	c=relaxed/simple; s=amsdkim1002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dfawcus@cisco.com;
	z=From:=20Derek=20Fawcus=20<dfawcus@cisco.com>
	|Subject:=20Re=3A=20=22Argument=20list=20too=20long=22=20in
	=20git=20remote=20update=20(Was=3A=20Git=20and=20GCC)
	|Sender:=20;
	bh=XJICoSXbF/82qHmNnriwkudkLnehrg36Lt+8qgZsD98=;
	b=R/6VGywsYyp4rp6wuUSHFNZyHKJw4neQ82QjYnsQlfpNzsT9rd/vho7S5R
	yNghSv5SAMSfEaQy+FVh76cscGd4C9tgIu5/nAK2IroaIbNWD8+3ExqzZDaJ
	dAMMnpjexa;
Authentication-Results: ams-dkim-1; header.From=dfawcus@cisco.com; dkim=pass (
	sig from cisco.com/amsdkim1002 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68685>

On Mon, Dec 17, 2007 at 03:01:25PM -0800, Linus Torvalds wrote:
> 
> > With git version 1.5.3.6 on Mac OS X, this results in:
> > potomac%:~/gcc%git remote update
> > Updating gcc.gnu.org
> > /opt/git/bin/git-fetch: line 220: /opt/git/bin/git: Argument list too long

> But maybe there is some way to raise the argument size limit on OS X.

Well the certification for Leopard claims it can be up to 256k.

I don't know about Tiger or earlier,  but ARG_MAX on my 10.4
box is also (256 * 1024).

So - how much do people want?  Or maybe there is some sort limit in play here?

DF
