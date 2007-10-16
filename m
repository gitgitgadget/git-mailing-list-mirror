From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: How to Import a bitkeeper repo into git
Date: Tue, 16 Oct 2007 06:56:16 +0200
Message-ID: <e5bfff550710152156t33ba10dam6171e3210c18d3ac@mail.gmail.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>
	 <20070709173720.GS29994@genesis.frugalware.org>
	 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>
	 <4713FA4A.5090501@bluelane.com>
	 <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
	 <471433F3.40606@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	"free cycle" <freecycler23@yahoo.com>, git@vger.kernel.org
To: pete@bluelane.com
X-From: git-owner@vger.kernel.org Tue Oct 16 06:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IheTl-0008GK-FY
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 06:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765548AbXJPE4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 00:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbXJPE4T
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 00:56:19 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:58898 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbXJPE4S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 00:56:18 -0400
Received: by py-out-1112.google.com with SMTP id u77so3459420pyb
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 21:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sqwKt38eV15YhK8qW/cU/PzvxiBY/kmNyd1NcE4Qghs=;
        b=k2I0RtR5bJIBZbDg8W3c6Oz/u9Bssoc2eN68HM7cUDtV/eXlmDTS38NBLHyKxIBqphbXumwRy1ITiwdjiZF8Ef1sOd2Ds+UrqL34bHG57iYNbndkWk2Iw6tL62K7emTjy89FiPM0rBg1jzpUChyLiheNniEz5U3uuEeu+jTZ15Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ctq4AOGqkj2kvfpUzRGSCyziIV5ZD45qnQ5Y9hlUUjJFCKb+/VUtFKbqZjafQ1vvNA4fmHWqDxOqRz1Vm9di/bVW+8GaxiJkNH/Z7TwIL2qlgiKzexwd+/WCJjAchvGOZM6qJgdt+YfqlDZHotPSVQSwnHkIWe22KvyNbOQLDxQ=
Received: by 10.140.207.2 with SMTP id e2mr3186555rvg.1192510576967;
        Mon, 15 Oct 2007 21:56:16 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Mon, 15 Oct 2007 21:56:16 -0700 (PDT)
In-Reply-To: <471433F3.40606@bluelane.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61076>

On 10/16/07, Pete/Piet Delaney <pete@bluelane.com> wrote:
>
> I just download 'meld', looks interesting, I didn't know about it or
> 'kompare'. Linking either one into gitk would be a pleasant graphical
> 'bling'.
>

In case you are interested a git GUI viewer called qgit can spawn
'Kompare' , 'Meld' or any other diff tool that support 'two files'
command line interface:

$my_preferred_diff_tool  file1.txt file2.txt

And they will show what you are looking for. The input files are
prepared by qgit that also handles the housekeeping at the end.

Another feature you asked, i.e. CTRL + right click to select a
revision (different from the parent) to diff against the current one
is also already implemented.

And of course the two above features can be integrated: you select two
random revisions and then call the external diff viewer to check at
the differences in the way you prefer.

It is possible to download qgit from

http://sourceforge.net/project/showfiles.php?group_id=139897


Two versions:

qgit-1.5.7 is Qt3 based

qgit-2.0 is Qt4 based (works also under Windows)



regards
Marco
