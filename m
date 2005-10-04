From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What to expect after 0.99.8
Date: Tue, 04 Oct 2005 09:35:23 -0700
Message-ID: <4342AF4B.7020806@zytor.com>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031709360.23242@iabervon.org> <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510031606550.31407@g5.osdl.org> <20051004071210.GA18716@localdomain> <Pine.LNX.4.63.0510040321170.23242@iabervon.org> <pan.2005.10.04.14.18.59.102722@smurf.noris.de> <434296F1.5030006@zytor.com> <20051004154640.GC4682@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 18:40:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMpls-00067o-7X
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 18:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVJDQf7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 12:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVJDQf7
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 12:35:59 -0400
Received: from terminus.zytor.com ([192.83.249.54]:12769 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964820AbVJDQf6
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 12:35:58 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j94GZRgr031441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Oct 2005 09:35:27 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20051004154640.GC4682@kiste.smurf.noris.de>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9684>

Matthias Urlichs wrote:
> 
> Actually, it isn't -- if you have a ssh connection, you don't have
> access to the raw TCP socket.
> 

If you have an ssh connection, you're writing over a pipe to the ssh 
process, and your local buffer is that pipe, which is PIPE_BUF size.

	-hpa
