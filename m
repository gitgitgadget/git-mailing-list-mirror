From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] t7610 (mergetool): more nitpicks
Date: Thu, 26 Aug 2010 01:38:21 -0700
Message-ID: <A5048FBD-FF49-4635-812F-9FF36C6BA01D@gmail.com>
References: <1282617444-641-1-git-send-email-brian@gernhardtsoftware.com> <20100824030524.GF17406@burratino> <20100825002552.GI2376@burratino> <20100825074034.GA4058@gmail.com> <20100825075650.GB18308@hashpling.org>
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Aug 26 10:38:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoXyq-0002Px-Rl
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 10:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441Ab0HZIig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 04:38:36 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:40443 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab0HZIic (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 04:38:32 -0400
Received: by pxi10 with SMTP id 10so532053pxi.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=burqxgeDxMOJKhXiL6wJigiA6QtcqOgp7qgoI0sFSmM=;
        b=f4ZtON8xdr/r+RWVoHQ8G2iWw1sWbk/5o7oqgkqURy2Di4Rk8373EFSB3Ted8setAT
         AmdseXCIz1r5II/HRWqRlJYouzyvTOUHxswUSTC1e2t0qMKeePPvtfo7/hQgcro5ufpY
         wNnNA/U3DNbHBMd+251poDFPF4k9vHjDf2N0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=PmI6O3WnPQwT3ZCr+tnggvFtwhWLrzcdwVKR7SsZTH+78zzumlkhJIxF7pu/EHjoPg
         nuWHTuHn/pHbQJ4ydNnW43lC/HB/ORpt9ZBBgj7L2rBIiwjyeosfz+xk5Cnxh04r5oH1
         zm2XOg5xsAczxtfsA1WzI3hL8EZPS8+3RWZPw=
Received: by 10.142.127.12 with SMTP id z12mr1229498wfc.78.1282811911924;
        Thu, 26 Aug 2010 01:38:31 -0700 (PDT)
Received: from [10.89.218.73] ([166.205.139.222])
        by mx.google.com with ESMTPS id v38sm2649804wfh.12.2010.08.26.01.38.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 01:38:30 -0700 (PDT)
In-Reply-To: <20100825075650.GB18308@hashpling.org>
X-Mailer: iPhone Mail (7D11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154533>

On Aug 25, 2010, at 12:56 AM, Charles Bailey <charles@hashpling.org>  
wrote:

> On Wed, Aug 25, 2010 at 12:40:38AM -0700, David Aguilar wrote:
>> On Tue, Aug 24, 2010 at 07:25:52PM -0500, Jonathan Nieder wrote:
>>> - use tabs to indent
>>> [...]
>>
>> Cool.  I'd like to do the same to git-mergetool.sh too.
>> Until now I've stuck to the existing style.
>> My editor is setup to display tabs visually which makes it easy
>> for me to emulate existing code but not everyone does that.
>>
>> Any objections to a patch that replaces the mixed 4-space+tab
>> indents with pure tabs?
>
> Just the same objection as the last time:
>
> http://thread.gmane.org/gmane.comp.version-control.git/115069/focus=115192
>
> We've already tidyied up mergetool to be consistent, I don't see what
> touching 90% of the lines achieves other than getting yourself
> 'blamed' for everything in mergetool.
>
> Charles.

Too true.

Instead of that I should probably get around to factoring out the tool- 
specific parts like we discussed in the past.

Thanks Charles,
-- 
         David
