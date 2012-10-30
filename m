From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 20:17:53 +0100
Message-ID: <CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
	<1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
	<20121030185914.GI15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 20:18:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTHKB-0000ZL-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 20:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab2J3TRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 15:17:54 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37133 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab2J3TRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 15:17:53 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so628539oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5n+s/Ne88ZeANH7lvxJ7F8QwZFEehhMDTh7RooERDHI=;
        b=hDfdrAQp97mpcsS2bmJZS8jpjw4X/jobTL48kOAjErrD5bRXPXbfZrYQ8oZ7PC436V
         fCQT7I7MgJoYzEp+MqMQbP2jIAI0Om2GQWHe7HkXhuG9cTnOJWgoynqS7dO9p7spxelV
         oyr2bw1TjdbQjbL2gDnAeLl6v8JrypYuBxZ8+p5ah0K34JfBn9E75ZdZBNckquMmkvfC
         VzVYOKfoJrmeVLaOqJd+jfBfVAdvS8r3tiw2en7hO5KQSH8uNg/g3U1q52waGYMjLg43
         r/ZclPDzXqS/aPm4ZgtJ8jA3JJ/wgSLEYllhBWDMZ2zCy/b4C+vRGk9nACNxT4/bE4zj
         yFOw==
Received: by 10.60.31.241 with SMTP id d17mr29535765oei.107.1351624673284;
 Tue, 30 Oct 2012 12:17:53 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 12:17:53 -0700 (PDT)
In-Reply-To: <20121030185914.GI15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208732>

(again to the mailing list)

On Tue, Oct 30, 2012 at 7:59 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> They have been marked as UNINTERESTING for a reason, lets respect that.

That doesn't say anything.

> and in the examples listed in the patch
> description the changed behavior does not look like an improvement.

I disagree.

% git log master ^master

What do you expect? Nothing.

% git fast-export master ^master

What do you expect? Nothing.

> Worse, the description lists a few examples but gives no convincing
> explanation to reassure about the lack of bad behavior for examples
> not listed.

What examples not listed?

-- 
Felipe Contreras
