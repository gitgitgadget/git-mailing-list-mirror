From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: EasyGit Integration
Date: Thu, 11 Jun 2009 01:31:57 +0300
Message-ID: <94a0d4530906101531ja6f1deeob703f546d62e7599@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	 <51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com>
	 <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
	 <20090610033211.GA7411@mit.edu>
	 <alpine.LFD.2.01.0906092058430.6847@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 00:32:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEWL4-0007fm-6t
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 00:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758472AbZFJWb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 18:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758683AbZFJWb4
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 18:31:56 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42830 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758472AbZFJWb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 18:31:56 -0400
Received: by fxm9 with SMTP id 9so1164987fxm.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 15:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nPKfZCLTjfOdnSsBlmlVUAF7UsYSVZAA58p/Jq71p/I=;
        b=ATpIfz+Ze1uBPb2aOb+QritKWEj47u3/7VW7WFC24at71S5Nxit+cmzmm50g9wGi3w
         8AN60UtOaBy2avKYjycgLoWXNgphjMRRtUvz0DacpRrZxqaDu9Iezxw5GWU63pg1voPz
         rhYGGoMZYuLoh7cv0G+9TxcA5PViNl3iyswUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g9CTQRDBs3UIghNtd4XCPs/mfc4c3f1Wy/enZa8AocPW9QlZ4q0k8i2i230fm0u0FV
         ii9gMX50hNKeiVSY0hK3pKZI1O5F2TO7CjTrmHRkjYMTX35O/7Sy8bPm/HZxAhIme1Iy
         ucWtIALwONVLe58Msb4yTyWr1UV5L4BCgbRP8=
Received: by 10.86.68.10 with SMTP id q10mr1557509fga.78.1244673117293; Wed, 
	10 Jun 2009 15:31:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0906092058430.6847@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121313>

On Wed, Jun 10, 2009 at 7:03 AM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 9 Jun 2009, Theodore Tso wrote:
>>
>> My personal opinion is this kind of overloading is actually more
>> confusing than simply adding a new name, such as "git revert-file".
>
> I'd agree, except I think it actually worked pretty well in "git
> checkout".
>
> The alternative was to add yet another command for that, or to teach
> people about the internal commands we did have. Adding the capability for
> checkout to check out individual files - in addition to commits and
> branches - I think worked pretty well.

Why? What makes 'git checkout <commit>' and 'git checkout <commit> --
<path>' similar at all? I would expect 'git checkout <commit>' to be
the same as 'git checkout <commit> -- .'

In my mind these are 2 completely different commands.

-- 
Felipe Contreras
