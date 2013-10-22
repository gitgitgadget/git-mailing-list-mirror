From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug: git-push crash due to double-close of file descriptor
Date: Tue, 22 Oct 2013 18:08:10 +0700
Message-ID: <CACsJy8CTo8WJTewToBM_y65fg5bOPS-Mm1nunQEU5Mw_mNZU2w@mail.gmail.com>
References: <CAEef6Wx59OBQPG38Ww59vse7n1Xb=tpJANcM8iT66zpL9-dS1w@mail.gmail.com>
 <CACsJy8AxfFzL+2LGmqqyAm9dt7BZDpOYyrj4rgkXxgtozF7qiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Jens_Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 13:08:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYZpP-00008M-P8
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 13:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab3JVLIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 07:08:43 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:50816 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab3JVLIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 07:08:42 -0400
Received: by mail-qc0-f181.google.com with SMTP id w4so4568889qcr.12
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IVCvOP2tz7KMAZz5l/AN9m1yiJuCtA9eSaHdMWUXoI4=;
        b=J5Ku3r4HAXhJjTtxOcixndIM5XWPQcvYi0bEIiD+6hxxoicwqUXstkVATh8aowvVqF
         Tb01GkX+84g02511ziu1/NmvC3dffN+mSIaE0hsNYLvyOLlwXu2F2rck8gXtdxF+mJgB
         e3owtu94N468GDAMQH9z+E0vl0/rNgaGn2P8/nnZIw2/kmmiJrmmasw7p0Y3xrJ+l6xU
         36AlaRRigD52MnYiahTtIEj3YVw93pK3/3n2HIgp47U+jh3P2NiKs4T/zg/N2VkQp/7D
         mVyqRIQmNYdzhcK3MWCyidF4NPZkc5deZf2Tfp2mAlik5rwbkM80uSStwV5aavhh8UD5
         D5Pw==
X-Received: by 10.49.39.39 with SMTP id m7mr28744783qek.60.1382440120759; Tue,
 22 Oct 2013 04:08:40 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Tue, 22 Oct 2013 04:08:10 -0700 (PDT)
In-Reply-To: <CACsJy8AxfFzL+2LGmqqyAm9dt7BZDpOYyrj4rgkXxgtozF7qiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236463>

On Tue, Oct 22, 2013 at 5:49 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> set fd[1] = 0

I thought fd[1] = -1, I wrote fd[1] = 0 :(
-- 
Duy
