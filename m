From: David Aguilar <davvid@gmail.com>
Subject: Re: More git status --porcelain lossage
Date: Sun, 11 Apr 2010 11:04:06 +0000 (UTC)
Message-ID: <20100413050247.GA31108@gmail.com>
References: <20100409190601.47B37475FEF@snark.thyrsus.com> <l2k5f14cf5e1004101148h5cf8dc4bm1836cf1c5fc8abfb@mail.gmail.com> <m3k4sfgmjc.fsf@localhost.localdomain> <20100410194154.GB28768@thyrsus.com> <s2i46a038f91004101331g1cdca78cya3e125275446a0a9@mail.gmail.com> <4BC0FB94.6050409@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 13:04:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0uxQ-00021s-It
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 13:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab0DKLD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 07:03:59 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:63490 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0DKLD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 07:03:58 -0400
Received: by ywh32 with SMTP id 32so1089856ywh.33
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 04:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DJ96HmxIu99LzmdD9xFSIMTs/GnK4CDSEVqmvWFXOIk=;
        b=MvV/vPWm/pDUdJTBbLdL8TnSW3Jlul5NhI++Vxl9wZO0/eaI2BBtSiDn1xEBXK3b30
         hxgXrxHxv4tYEhNUOhqJr0pdy3w1L2U9mAmn3XwhqSEJjOc6/x1DQRWWfNsCnttNjhC1
         60K7C1rvvrH8CcRJOWvA17s6XsKIBdNrgAG2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=waX3y6HMcipp4MF09beg9lI25gKdsquJ+vL7u7r0ADoR9e0rwi0Gm3qys0ZygyGVsu
         4+qyVCYEEG/GottVc7g/Jk/+lJSP2nrVLW98obMq4VvSnSji8piStxyUokFysMZRcaIh
         /K5svGeVl+B87mnuYSKXmtxT71cTg4O8J8rkk=
Received: by 10.101.141.9 with SMTP id t9mr4203999ann.55.1270983837037;
        Sun, 11 Apr 2010 04:03:57 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 23sm2843220iwn.10.2010.04.11.04.03.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 04:03:56 -0700 (PDT)
Date: Mon, 12 Apr 2010 22:02:49 -0700
Content-Disposition: inline
In-Reply-To: <4BC0FB94.6050409@gnu.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144639>

On Sun, Apr 11, 2010 at 12:28:36AM +0200, Paolo Bonzini wrote:
> On 04/10/2010 10:31 PM, Martin Langhoff wrote:
>> On Sat, Apr 10, 2010 at 3:41 PM, Eric Raymond<esr@thyrsus.com>  wrote:
>>>> I could understand providing JSON format, specified using --json
>>>> option.
>>>
>>> You know, that's actually an interesting idea.  I mentioned it
>>> previously as the not-XML if we want to build on a metaprotocol;
>>
>> One issue is that there's no stream-parser JSON implementations that
>> I'm aware of.
>
> Here is one.  It's ugly as hell, you're warned.  The only missing piece  
> is making the stack state resizable.
>
> Paolo

Here's a fairly popular stream parser:

http://lloyd.github.com/yajl/

Yet Another JSON Library. YAJL is a small event-driven
(SAX-style) JSON parser written in ANSI C, and a small
validating JSON generator. YAJL is released under the BSD
license.

The license is BSD-with-advertising-clause.
Perhaps the author did not know about modified BSD.

-- 
		David
