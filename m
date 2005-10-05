From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What to expect after 0.99.8
Date: Tue, 04 Oct 2005 19:38:53 -0700
Message-ID: <43433CBD.2060603@zytor.com>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <200510032048.37363.alan@chandlerfamily.org.uk> <43419DD4.5040508@zytor.com> <20051004210706.GA16161@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 04:40:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMzBc-0004JH-EA
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 04:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVJECjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 22:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVJECjM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 22:39:12 -0400
Received: from terminus.zytor.com ([192.83.249.54]:54252 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965007AbVJECjL
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 22:39:11 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j952cvgb019826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Oct 2005 19:38:58 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Greg KH <greg@kroah.com>
In-Reply-To: <20051004210706.GA16161@kroah.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9695>

Greg KH wrote:
> On Mon, Oct 03, 2005 at 02:08:36PM -0700, H. Peter Anvin wrote:
> 
>>I believe in the medium-to-long term a plugin architecture for merging 
>>is imperative.  It's not even different media types, but some *files* 
>>have specific merging policies.  Think, for example, of pci.ids in the 
>>Linux kernel tree.
> 
> You mean the file that is now removed from the kernel tree?  Sure,
> that's a good merge policy :)
> 

*Plonk*... well, the point was that even text files can be structured so 
that application-specific merge rules can be made to apply.  ChangeLogs 
are another good example.

	-hpa
