From: Mircea Bardac <dev@mircea.bardac.net>
Subject: Re: BUG (v1.5.6.1): ./configure missing check for zlib.h
Date: Fri, 27 Jun 2008 16:15:31 +0100
Message-ID: <48650413.2080001@mircea.bardac.net>
References: <4864DD65.1080402@mircea.bardac.net> <m3prq3hr6n.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 17:22:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCFmF-0001O2-My
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 17:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758296AbYF0PU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 11:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759815AbYF0PU4
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 11:20:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:16340 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbYF0PUz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 11:20:55 -0400
Received: by nf-out-0910.google.com with SMTP id d3so141664nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 08:20:54 -0700 (PDT)
Received: by 10.210.110.5 with SMTP id i5mr1258285ebc.18.1214580053692;
        Fri, 27 Jun 2008 08:20:53 -0700 (PDT)
Received: from ?192.168.126.97? ( [212.13.49.167])
        by mx.google.com with ESMTPS id q9sm3402070gve.5.2008.06.27.08.20.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 08:20:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <m3prq3hr6n.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86573>

Jakub Narebski wrote:
> Mircea Bardac <dev@mircea.bardac.net> writes:
> 
>> $ ./configure
> [...]
>> configure: CHECKS for header files
> 
> Here ./configure check for existence of heder files, but only those
> that can be skipped by defining some macro...

> [...]
>>
>> (installing zlib1g-dev on Ubuntu 7.10 fixed the problem)
> 
> What should ./configure do (what ./configure for other programs
> or packages do)?
> 
> You cannot compile git without zlib!

Well, as far as I know, if a program depends on any external headers, 
they should *all* be checked, not only "those that can be skipped by 
defining some macro" (I personally do not know which are these).

Mircea

--
http://mircea.bardac.net
