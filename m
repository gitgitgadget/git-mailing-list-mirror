From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFH] RPM gurus? (Re: rpmbuild fails)
Date: Wed, 11 Oct 2006 14:20:25 +0200
Message-ID: <200610111420.25666.Josef.Weidendorfer@gmx.de>
References: <pan.2006.10.10.20.31.48.692444@alarsen.net> <7v64erznyj.fsf_-_@assigned-by-dhcp.cox.net> <7vpscztg1c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 14:21:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXd4d-00031r-3W
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 14:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWJKMU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 08:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWJKMU1
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 08:20:27 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:58589 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751218AbWJKMU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 08:20:27 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id EA9692803;
	Wed, 11 Oct 2006 14:20:25 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vpscztg1c.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28710>

On Wednesday 11 October 2006 10:25, Junio C Hamano wrote:
> Does this look reasonable?
> 
> -(find $RPM_BUILD_ROOT%{perl_vendorarch} -type f | sed -e s@^$RPM_BUILD_ROOT@@) >> perl-files
> +(find $RPM_BUILD_ROOT%{perl_vendorlib} -type f | sed -e s@^$RPM_BUILD_ROOT@@) >> perl-files

That was exactly the modification I did, yes.
However, I can only say: It works for me (tm).
BTW, this is only Suse 10.1, x86.

Josef
