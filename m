From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] index-pack: produce pack index version 3
Date: Tue, 14 Aug 2012 08:27:39 +0700
Message-ID: <CACsJy8CPmGLMoy6-AKuKGLtFQfQO3yKgXCmfb2=Qhmi676cXxA@mail.gmail.com>
References: <1344772889-8978-1-git-send-email-pclouds@gmail.com>
 <7vtxw8exii.fsf@alter.siamese.dyndns.org> <7vlihjgaaj.fsf@alter.siamese.dyndns.org>
 <CACsJy8CNp2w6PsMSrQ4aFBwHKbOGid4pVHUhE4xgmTatrnEepQ@mail.gmail.com>
 <7v8vdjfddk.fsf@alter.siamese.dyndns.org> <CAJo=hJtwS=fdjTCVsEQHdVn9p+_2k-wJ_W_zLtZkWGO+M4suNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 03:28:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T15vf-0000zj-Cu
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 03:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab2HNB2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 21:28:12 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53220 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab2HNB2L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 21:28:11 -0400
Received: by obbuo13 with SMTP id uo13so7722073obb.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3UeFmsHFegc0N7/JbVkyJX2/WFSCZFQjXh+++dBaiX8=;
        b=sCbk0NuDZe+f4sWIFeVmPjECovQrcwRSsmx2MouVdJQZ+fJOH+D3SOGI8xSGvSnkjR
         9UtYFfnXzM0U0XxYP2AwgrwMT3I2R9gDq48sxprgGi3yTUvxRRP3IzFJG2bqf6stXdv+
         oFpoaqq7O7J+yd9psz6AdWrP08poOOEJd1erx3IO5Y9BEpwCiWzU79QMOHFctjsnHyZs
         ATbXcxRVY5i8XDVtAt4yxHaBwgX0L8BNmk5JaWRp0dj4cAxIFONsGNYMnqIeChsi8b5J
         Wa+L48RC4ElkJhIx7Qi6f+W2hGsFf4eHXZN2PblSf8YzxSq4nfQ++zYwy8KQ7zis31ni
         6GXw==
Received: by 10.50.182.232 with SMTP id eh8mr8358428igc.48.1344907691154; Mon,
 13 Aug 2012 18:28:11 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Mon, 13 Aug 2012 18:27:39 -0700 (PDT)
In-Reply-To: <CAJo=hJtwS=fdjTCVsEQHdVn9p+_2k-wJ_W_zLtZkWGO+M4suNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203378>

On Tue, Aug 14, 2012 at 7:46 AM, Shawn Pearce <spearce@spearce.org> wrote:
> Colby is nearly done prototyping the bitmap reachability
> implementation in JGit and will release the code under the BSD license
> there soon. I can't promise when yet because Colby will soon be
> heading out for some (much deserved) vacation time, and doesn't want
> to publish something until he is ready to stand behind the code. So it
> might not show up until mid-September. But I think its worth giving
> him a few weeks to finish getting the code ready, vs. rushing
> something in that someone else thinks might help. We have waited more
> than 6 years or whatever to improve packing. Colby's experiments are
> showing massive improvements (40s enumeration cut to 100ms) with low
> disk usage increase (<10%) and no pack file format changes. Its OK to
> wait 4 more weeks.

Thanks. I did not know it's being worked on (your last email did not
indicate that, I think). I just wanted to try out and see how it might
work. And sure I can wait :)
--
Duy
