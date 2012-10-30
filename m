From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 23:01:47 +0100
Message-ID: <CAMP44s1b+E8a0kdSgREbGzRTFy+nCw4VcjHadd3soQAXRkNzZw@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
	<1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
	<20121030185914.GI15167@elie.Belkin>
	<CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
	<CAMP44s1tFhh3Xqe9tqoDAdtwnGc=kFT6OmAreeP1nbTstweaQQ@mail.gmail.com>
	<20121030214531.GN15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:02:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJsn-0006yw-5B
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab2J3WBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:01:49 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:49609 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab2J3WBs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:01:48 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so793556oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 15:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vyt467GWI/pqV2PvzpaZkTf4oKAei8inChxZs5UPisU=;
        b=Sjtzr/R/+6mmop1jzFsRVXEpbqXVttD0n51nuDHnxHxWZBQTiIWtUXUuedhJRYVkt9
         q7LMZmr1kFvvSODq1Olp6bm1GkzxpNsy4A2rFlyd4XelxmhWH30o71zWo2sNX1jIo7AA
         r7ITwMr8y8Ela/T6gDyIGEBxYxmYbrebkaaIm87pQpcWjfIDzqlLy2p3Gd3bvzVakbz+
         XCTqtTaF3lNxJF52W+1jUir65RXvoJOQQ21+SC7ZY7zye18qipI0lzNMBl86TGZFd4DC
         zXgrJjbKQyyXcByG83lts+OxZaMRQHG/ODL8e9dN8huq0AxkC4w7BBC7beZjAeGFQ+3G
         E8MA==
Received: by 10.182.52.105 with SMTP id s9mr28969266obo.25.1351634507704; Tue,
 30 Oct 2012 15:01:47 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 15:01:47 -0700 (PDT)
In-Reply-To: <20121030214531.GN15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208754>

On Tue, Oct 30, 2012 at 10:45 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> So you think what we have now is the correct behavior:
>>
>> % git fast-export master ^master
>> reset refs/heads/master
>> from :0
>
> No, I don't think that, either.

Well, that's what we have now, and you want to preserve this "feature"
(aka bug), right?

And I still haven't why this is "unsafe", and what are those "examples
not listed".

-- 
Felipe Contreras
