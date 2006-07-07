From: sf <sf@b-i-t.de>
Subject: Re: [PATCH] Do not drop data from '\0' until eol in patch output
Date: Fri, 07 Jul 2006 13:18:52 +0200
Message-ID: <44AE431C.4090509@b-i-t.de>
References: <1152268424350-git-send-email-sf@b-i-t.de> <7vslld1ycq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 07 13:19:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyoMi-0006Dw-HT
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 13:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWGGLTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 07:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWGGLTR
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 07:19:17 -0400
Received: from main.gmane.org ([80.91.229.2]:37771 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751049AbWGGLTR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 07:19:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FyoMT-000693-T9
	for git@vger.kernel.org; Fri, 07 Jul 2006 13:19:05 +0200
Received: from ip-213157015184.dialin.heagmedianet.de ([213.157.15.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 13:19:05 +0200
Received: from sf by ip-213157015184.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 13:19:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157015184.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <7vslld1ycq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23429>

Junio C Hamano wrote:
> Stephan Feder <sf@b-i-t.de> writes:
> 
>> The binary file detection is just a heuristic which can well fail.
>> Do not produce garbage patches in these cases.
>>
>> Signed-off-by: Stephan Feder <sf@b-i-t.de>
> 
> Thanks.
> 
> I do not think this patch is _wrong_ per se, but I wonder what
> you would use a patch like that for.  Specifically, do you apply
> such a patch with NUL and other binary data in it, and if so
> what tool do you use?
> 

GNU patch can apply patches with binary content which are typically
produced with GNU diff with --text option.
