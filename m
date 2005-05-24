From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb wishlist
Date: Mon, 23 May 2005 22:04:35 -0700
Message-ID: <4292B5E3.2080505@zytor.com>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>  <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <4292A1F2.7020606@zytor.com> <4292AD5E.3000106@cobite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 07:04:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaRZv-0005ly-6d
	for gcvg-git@gmane.org; Tue, 24 May 2005 07:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVEXFFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 01:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVEXFFE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 01:05:04 -0400
Received: from terminus.zytor.com ([209.128.68.124]:64426 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261269AbVEXFE7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 01:04:59 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4O54Zlf015614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 May 2005 22:04:37 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: David Mansfield <david@cobite.com>
In-Reply-To: <4292AD5E.3000106@cobite.com>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=1.8 required=5.0 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Mansfield wrote:
>>
>> This is only pathological if the tag now represents a state that never 
>> actually existed in the history of the repository.  I don't believe 
>> there are any such cases in the syslinux repository; I could be wrong, 
>> but I am *highly* sceptical.
> 
> I didn't mean that YOUR repository had more pathological stuff in it, 
> just that SOME do.  'FUNKY' tags are not really that bad, it's just that 
> there is not a single commit to assign them to (i.e. at no point were 
> all of the objects in the repository at that state simultaneously), 
> which makes the import of such a tag difficult into a more commit 
> oriented system.
> 
> Another way to reach 'funky'ness is to modify a file, commit and tag, 
> without having done a 'cvs update' first (and a colleague has done a 
> commit since your last 'cvs update')
> 

Not sure, sounds more likely.

Either which way, I guess there are two ways to deal with them in 'git'; 
either as standalone trees (tags pointing to tree objects), or probably 
more sensical, as impromptu branches if one can find a sane origin object.

	-hpa
