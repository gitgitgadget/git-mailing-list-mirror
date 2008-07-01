From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Teach "git apply" to prepend a prefix with "--root=<root>"
Date: Tue, 01 Jul 2008 09:57:09 -0700
Message-ID: <486A61E5.1070208@zytor.com>
References: <alpine.DEB.1.00.0807010043440.9925@racer> <7vvdzqnemk.fsf@gitster.siamese.dyndns.org> <486A55B0.9050404@zytor.com> <alpine.LSU.1.00.0807011835090.32725@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 01 18:59:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDjCJ-0001Xe-VI
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 18:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbYGAQ6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 12:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbYGAQ6W
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 12:58:22 -0400
Received: from terminus.zytor.com ([198.137.202.10]:45223 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbYGAQ6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 12:58:21 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m61GvBR7003714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 1 Jul 2008 09:57:12 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m61GvBX5015336;
	Tue, 1 Jul 2008 09:57:11 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m61Gv9Lb014285;
	Tue, 1 Jul 2008 09:57:09 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <alpine.LSU.1.00.0807011835090.32725@wbgn129.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV 0.92.1/7604/Tue Jul  1 08:01:42 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87055>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 1 Jul 2008, H. Peter Anvin wrote:
> 
>> Junio C Hamano wrote:
>>> The -p<num> came from patch where it is also called --strip=num.  
>>> This new option --root is about the reverse operation and it is about 
>>> inserting at the beginning --- it is rerooting, in other words, but 
>>> then --root is good enough and shorter.  mkisofs uses the word "graft" 
>>> when it allows tree shifting (enabled with --graft-points), but the 
>>> word "graft" means a totally different thing to us, so we would not 
>>> want to use that word.
>>>
>>> I am not complaining (--root is fine by me), but just thinking aloud, 
>>> hoping somebody's brainwave is provoked while reading this babbling 
>>> and comes up with a better wording ;-).
>>>
>> There is an analogous concept in patch(1), it's just implemented by 
>> cd'ing to a subdirectory first.  ;)
> 
> Hey, "--cd=" is free!  And it would make explaining easier why -p is 
> applied first.
> 

Although that could imply cd'ing into another git repository to some people.

	-hpa
