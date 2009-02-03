From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2git migration - cloning CVS repository
Date: Tue, 03 Feb 2009 15:18:48 +0100
Message-ID: <49885248.6020805@alum.mit.edu>
References: <286817520902020624y7f4c2942l34fafc0fe0fa0b48@mail.gmail.com> <49883C52.3060102@alum.mit.edu> <alpine.DEB.1.00.0902031348570.6573@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Rostislav Svoboda <rostislav.svoboda@gmail.com>,
	git@vger.kernel.org, cvs2svn users <users@cvs2svn.tigris.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 15:20:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUM8W-0003Wa-Ec
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 15:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbZBCOS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 09:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbZBCOS5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 09:18:57 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:52995 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbZBCOS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 09:18:57 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n13EIoKI008513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Feb 2009 15:18:51 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20090105 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <alpine.DEB.1.00.0902031348570.6573@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108191>

Johannes Schindelin wrote:
> On Tue, 3 Feb 2009, Michael Haggerty wrote:
>> If you do not have filesystem access to your CVS repository, you might 
>> be able to clone it using CVSSuck [2,3].
> 
> A substantially faster option would be to go with cvsclone:
> 
> 	http://samba.org/ftp/tridge/rtc/cvsclone.l
> 
> (in my case, cvsclone was not only faster, but it actually worked, too, 
> which is more than I could say of CVSSuck).
> 
> Note: it only works for anonymous access so far.
> 
> Note also: for my use case, it was necessary to edit the rlog, as those 
> brilliant geniuses included verbatim cvs logs for files they moved. *sigh*
> If you need something like that, I can give you my patched version.

Thanks for the pointer.  I just added it to the cvs2svn/cvs2git FAQ [1].

Michael

[1] http://cvs2svn.tigris.org/faq.html
