From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Local clone/fetch with cogito is glacial
Date: Mon, 22 May 2006 14:18:07 -0700
Message-ID: <44722A8F.9020609@zytor.com>
References: <4470FC21.6010104@zytor.com> <BAYC1-PASMTP11FDE05B530CFF43C043E5AE9A0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 23:19:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiHnp-0001ot-C1
	for gcvg-git@gmane.org; Mon, 22 May 2006 23:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWEVVSx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 17:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWEVVSw
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 17:18:52 -0400
Received: from terminus.zytor.com ([192.83.249.54]:61576 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750852AbWEVVSv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 17:18:51 -0400
Received: from [192.168.10.106] (63-207-7-10.ded.pacbell.net [63.207.7.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k4MLI70b003693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 May 2006 14:18:44 -0700
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP11FDE05B530CFF43C043E5AE9A0@CEZ.ICE>
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20534>

Sean wrote:
> On Sun, 21 May 2006 16:47:45 -0700
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> 
>> It appears that doing a *local* -- meaning using a file path or file URL 
>> -- clone or fetch with cogito is just glacial when the repository has an 
>> even moderate number of tags (and it's fetching the tags that takes all 
>> the time.)  That's a really serious problem for me.
>>
> 
> Peter, does git clone work acceptably for you?
> 

Well, it does, except it doesn't set up the cogito branches (which one can of course copy 
manually.)

cg-clone probably should be rewritten as a thin wrapper around git-clone.

	-hpa
