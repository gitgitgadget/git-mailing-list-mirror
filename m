From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH 14/14] Add README and gitignore file for MSVC build
Date: Sun, 23 Aug 2009 19:22:57 +0100
Message-ID: <3f4fd2640908231122m34604196pc98c5871cf5925b5@mail.gmail.com>
References: <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
	 <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
	 <74ca14c3a691cc9844a0dd806f5db47977317bdb.1250860247.git.mstormo@gmail.com>
	 <4b8b550914cfc4e638ff905d9b9aa416e45913f4.1250860247.git.mstormo@gmail.com>
	 <ba4e68ae32784d8e0c706fa665fbdbbfe67ce673.1250860247.git.mstormo@gmail.com>
	 <6dd71f163e5410e401fc66088405736d1978ec55.1250860247.git.mstormo@gmail.com>
	 <cover.1250860247.git.mstormo@gmail.com>
	 <54673ddb6bef681194e141e5e05e930cdfaa07bc.1250860247.git.mstormo@gmail.com>
	 <e82f1930173966ebb6b2d2815e037a26e079f969.1250860247.git.mstormo@gmail.com>
	 <a4c8a6d00908230926of0ea10bhd8f66e7d37c3b39b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 20:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfHje-0000Gg-3P
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 20:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933646AbZHWSW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 14:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933441AbZHWSW5
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 14:22:57 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:49527 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933611AbZHWSW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 14:22:56 -0400
Received: by vws2 with SMTP id 2so1504609vws.4
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UWeLxV3EDZHN28FOW9rqQnWW4L2Gd5d4EEK23tcPj8E=;
        b=dLfgxEp5C+n6jQWQXJudXNOf5WHvwjKqdOp0A3Pt3kqo5rT/Mf8qxusrI9I6l8tfcH
         8AnGmpI2jN7FwJkdDfmos+bwnhjts3gXXlPruuepfxiD4pqdAwxRrQTJUpS+Af7ML9Pc
         uICyeIUHyVRBtM+hOJPiYYn/70coTxMFKDjm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FV5HjZQkwXFL9Kap7Whe5cxOt64TxoBdz+qtrrHUrG131lnzVcv3oJLLjQ9eqw/sgo
         bxqh88l/Hj9ICkZqXic87zKdbsqWxtWN8VRbxbtHtBhnKaUPE/JpRUAi4lbTtFT16IA3
         ctcLhaUnv+4IH4XYmexrSb6duNxVm4nZARZrc=
Received: by 10.220.113.211 with SMTP id b19mr4490010vcq.60.1251051777282; 
	Sun, 23 Aug 2009 11:22:57 -0700 (PDT)
In-Reply-To: <a4c8a6d00908230926of0ea10bhd8f66e7d37c3b39b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126863>

2009/8/23 Thiago Farina <tfransosi@gmail.com>:
> Hi,
>
> On Fri, Aug 21, 2009 at 10:30 AM, Marius Storm-Olsen<mstormo@gmail.com> wrote:
>> From: Frank Li <lznuaa@gmail.com>
>>
>> +3. Open gitbuild\gitbuild.sln with VS2008. Then press F7.
> F7 does nothing in VS2008, to build the solution you have to press
> Ctrl+Shift+B. To build and start debugging you have to press F5, and
> for start without debbuging support is Ctrl+F5.

IIRC, Visual Studio can be configured to use different keyboard shortcuts.

However, saying "press F7" says nothing of the intent. It would
probably be better to have this say something like "Then build the
solution." or "Open gitbuild\gitbuild.sln with Visual Studio 2008,
then build it." But then you don't need to open Visual Studio 2008 to
build it (you can build it from command line).

So, how about:
   3. You can now build git with Visual Studio 2008 using the
gitbuild\gitbuild.sln file.

- Reece
