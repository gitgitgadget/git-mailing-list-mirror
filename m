From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 16:58:43 +0200
Organization: At home
Message-ID: <e6emmm$idv$1@sea.gmane.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>	<46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>	<46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>	<Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>	<Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>	<9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>	<Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>	<9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com>	<87y7w5lowc.wl%cworth@cworth.org>	<Pine.LNX.4.64.0606092001590.5498@g5.osdl.org>	<448A847C.20105@dawes.za.net> <7vzmglgyz0.fsf@assigned-by-dhcp.cox.net> <448ADB8A.3070506@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jun 10 16:59:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp4vN-00050F-GT
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 16:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWFJO6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 10:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWFJO6u
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 10:58:50 -0400
Received: from main.gmane.org ([80.91.229.2]:21962 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751163AbWFJO6t (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 10:58:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fp4v8-0004xI-6M
	for git@vger.kernel.org; Sat, 10 Jun 2006 16:58:38 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 16:58:38 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 16:58:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21608>

Rogan Dawes wrote:

> Junio C Hamano wrote:
>> Rogan Dawes <lists@dawes.za.net> writes:
>> 
>>> Here's an idea. How about separating trees and commits from the actual
>>> blobs (e.g. in separate packs)?
>> 
>> If I remember my numbers correctly, trees for any project with a
>> size that matters contribute nonnegligible amount of the total
>> pack weight.  Perhaps 10-25%.
> 
> Out of curiosity, do you think that it may be possible for tree objects 
> to compress more/better if they are packed together? Or does the 
> existing pack compression logic already do the diff against similar tree 
> objects?

The problem with compressing and deltafying trees is with sha1 objects
identifiers, I guess.

-- 
Jakub Narebski
Warsaw, Poland
