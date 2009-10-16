From: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
Subject: Re: Efficient cloning from svn (with multiple branches/tags subdirs)
Date: Fri, 16 Oct 2009 12:20:16 +0100
Message-ID: <4AD856F0.6030905@manchester.ac.uk>
References: <hb2fvu$8qi$1@ger.gmane.org> <20091014060307.GA17178@dcvr.yhbt.net>	 <32541b130910140928jdac0187x754423e8d5c64e53@mail.gmail.com>	 <20091014180013.GA24741@dcvr.yhbt.net>	 <32541b130910141126u4df7f439i3d2926c2e1db9497@mail.gmail.com>	 <4AD75A93.9050106@manchester.ac.uk> <28c656e20910151029s2e053f75q56e968f313d12b21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 13:27:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MykyR-0001Z4-LZ
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 13:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758143AbZJPL0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 07:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758006AbZJPL0O
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 07:26:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:38032 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757866AbZJPL0O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 07:26:14 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mykuy-0007c9-JY
	for git@vger.kernel.org; Fri, 16 Oct 2009 13:24:20 +0200
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 13:24:20 +0200
Received: from Bruno.Harbulot by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 13:24:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: rain.gmane.org
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <28c656e20910151029s2e053f75q56e968f313d12b21@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130476>



B Smith-Mannschott wrote:

>> I've had a quick look at the git-svn code to see how this ID was generated,
>> but couldn't find anything obvious.
>> I realise this isn't the cleanest approach possible, but any suggestion
>> would be appreciated.
> 
> When I 'git svn clone' from a svnsync mirror I pass
> --use-svnsync-props. Have you tried that?

Thank you, I hadn't noticed this option, but it was the right one indeed.

Best wishes,

Bruno.
