From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git checkout under 1.7.6 does not properly list untracked files
 and aborts
Date: Wed, 21 Sep 2011 20:31:53 +1000
Message-ID: <CACsJy8A76Cd6Yjr9PnYn9-iVHaJa9vnnjViF_SDFeiZZWONjow@mail.gmail.com>
References: <4E6A7167.6070408@workspacewhiz.com> <4E779BA4.8070109@workspacewhiz.com>
 <4E78ACE2.60306@drmicha.warpmail.net> <4E78DACF.3030200@workspacewhiz.com>
 <4E7996AA.4040909@drmicha.warpmail.net> <4E79A04B.7080607@drmicha.warpmail.net>
 <20110921085842.GA29768@duynguyen-vnpc> <4E79AB5F.5020809@drmicha.warpmail.net>
 <20110921102834.GA21353@duynguyen-vnpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 21 12:32:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6K6P-0005nO-GK
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 12:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab1IUKcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 06:32:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50167 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395Ab1IUKcY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 06:32:24 -0400
Received: by bkbzt4 with SMTP id zt4so1314231bkb.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4pHj0XC2htvE8Aiv4HCUwKZuwFErF4YEBf4lrFK+6Sw=;
        b=Yqe2w04MBkqi8FWWd298QQeIYLAgbCsfpY0mjynXgbeqm5HlJmMI0kq7D2dIqnu+Xl
         IGiDV2hJd33BXuvYIFFR/X0pu/0AR9X56t6e5IJozP0No6cIQd56mmVrkEijEoPVo8jQ
         +bNOpRLlnhIESAeQ+Ct08QhE+lw8/YZjD6fCM=
Received: by 10.204.139.6 with SMTP id c6mr398535bku.391.1316601143193; Wed,
 21 Sep 2011 03:32:23 -0700 (PDT)
Received: by 10.205.114.134 with HTTP; Wed, 21 Sep 2011 03:31:53 -0700 (PDT)
In-Reply-To: <20110921102834.GA21353@duynguyen-vnpc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181836>

On Wed, Sep 21, 2011 at 8:28 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I was afraid some logic had gone horribly wrong. Turns out I did not
> catch up with unpack_trees() coding style and drop the error messages
> so "git checkout" in this case becomes "git checkout -q".

Gaah.. if I did read Joshua's problem description, it would not need
to worry about the logic. He said it returned error code correctly.
Silly me.
-- 
Duy
