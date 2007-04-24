From: Michael Spang <mspang@uwaterloo.ca>
Subject: Re: [PATCH] Add clean.requireForce option, and add -f option to git-clean
 to override it
Date: Mon, 23 Apr 2007 21:24:29 -0400
Message-ID: <462D5C4D.3050004@uwaterloo.ca>
References: <462D4CC8.70006@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 03:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg9mQ-0005SV-6G
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 03:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbXDXBZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 21:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbXDXBZJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 21:25:09 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:52192 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754546AbXDXBZI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 21:25:08 -0400
Received: from [192.168.0.11] (CPE00045a842fd6-CM000a73a11526.cpe.net.cable.rogers.com [99.246.170.176])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id l3O1Ocxn010709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2007 21:24:54 -0400 (EDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <462D4CC8.70006@freedesktop.org>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Mon, 23 Apr 2007 21:25:03 -0400 (EDT)
X-Miltered: at mailchk-m03 with ID 462D5C56.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.90.2, clamav-milter version 0.90.2 on localhost
X-Virus-Status: Clean
X-UUID: 813c582d-14d8-411f-a380-35c4508d6ae7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45400>

Josh Triplett wrote:
> +if [ "$disabled" = true ]; then
> +	echo "clean.requireForce set and -n or -f not given; refusing to clean"
> +	exit 1
> +fi

How is it useful to abort completely? Wouldn't it be better to behave like -n unless -f is given?

Cheers,
Michael Spang
