From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild
 bug)
Date: Mon, 31 Oct 2005 11:36:07 -0800
Message-ID: <43667227.9090606@zytor.com>
References: <43652934.8000308@zytor.com>	<7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>	<20051031064105.GV8041@shell0.pdx.osdl.net>	<43663EEA.5050102@zytor.com> <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 20:38:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWfSZ-0005Pp-52
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 20:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVJaTgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 14:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVJaTgk
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 14:36:40 -0500
Received: from terminus.zytor.com ([192.83.249.54]:60803 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932374AbVJaTgj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 14:36:39 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9VJaCEh002421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 31 Oct 2005 11:36:12 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10875>

Junio C Hamano wrote:
> 
> I do not know much about how things are done in the RPM world,
> but is there a concept of "the upstream" vs "packaging
> maintainer" there?  IOW, are the majority of RPM binary packages
> done by the upstream maintainer?
> 

It does both ways.  I think Chris Wright has been doing the formal 
maintenance of RPM for Fedora.

Latency is an issue, though, especially for kernel.org.

	-hpa
