From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Which content is not indexed?
Date: Mon, 21 Apr 2008 13:23:57 +0200
Message-ID: <480C794D.9010006@gnu.org>
References: <11b141710804201636s7a35db7aydcbcafafabf7a4ee@mail.gmail.com>	 <18071eea0804201643w55cb2d8fjcc713df61f4442df@mail.gmail.com> <11b141710804201649g6211c13emb6111c1fdf998c4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Adam <thomas.adam22@gmail.com>, git@vger.kernel.org
To: "Paulo J. Matos" <pocm@soton.ac.uk>
X-From: git-owner@vger.kernel.org Mon Apr 21 13:24:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnu8h-0008G9-2a
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 13:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019AbYDULYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 07:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbYDULYE
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 07:24:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:6333 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbYDULYC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 07:24:02 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1726598fgb.17
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=Gfcct0cpMUqOP5tz8JOHQVGZ4c672WgQN2oZ7Hr+Xeo=;
        b=GKUZRAHpkMhc6VWBayLkRyjDWB5bDQvNiWuHCVUu4LO/G2PTMUgmuOFw1qTfoGd1YwGwE8aqrq4A7bwUrxMiuYDHpaqc7JWpS5/tVBIvdBw9o1Otk/KTLz6WPcA9DXHNAJtrUEcV0efCrTAXr5mHYEj7Cyk2Eu8ChHQT/UUjMIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=OLkYTrSwBsf4SkumdQxo4yCVkp4Aqy1O5mfyXcIhLC/INSfjXBvGDJiCnrT2BcbnUzoHspIZ6rjczeB8o37QnNiTf5JbXOYJg+/EeVvi2xIV3XRDjhmHHtI4s5XriDBsa/1nUz7lCffwp/QPaGlagh5K+9iC9/oQKc7heFnEnnA=
Received: by 10.86.94.11 with SMTP id r11mr12985862fgb.1.1208777038428;
        Mon, 21 Apr 2008 04:23:58 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id d6sm2958196fga.9.2008.04.21.04.23.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Apr 2008 04:23:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <11b141710804201649g6211c13emb6111c1fdf998c4b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80019>

Paulo J. Matos wrote:
> On Mon, Apr 21, 2008 at 12:43 AM, Thomas Adam <thomas.adam22@gmail.com> wrote:
>> On 21/04/2008, Paulo J. Matos <pocm@soton.ac.uk> wrote:
>>  > Hello all,
>>  >
>>  >  I just started using git on a new project. I have added some files to
>>  >  git, commit.
>>  >  Now I created some more files, added more content. How can I check
>>  >  which files [content] are not in git yet?
>>
>>  You must mean:  git status
>>
> 
> Geee, for someone also using svn, not trying the git status command
> was quite stupid of me.

Or: "git citool".  The "graphical commit" tool is actually pretty useful 
to review what's in the index and what's not.

Paolo
