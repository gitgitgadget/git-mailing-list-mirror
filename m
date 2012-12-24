From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Find the starting point of a local branch
Date: Mon, 24 Dec 2012 12:45:21 +0700
Message-ID: <CACsJy8DkA-J+ds1eHBqrRyiZrOigORTtxVeEQpZjGHrBR+QjCQ@mail.gmail.com>
References: <20121224035825.GA17203@zuhnb712> <201212240409.qBO49wkV020768@no.baka.org>
 <CACsJy8CNd3W_WUMbZ1QZ4ReZ5ziX90QejK9mh1TMs0ig33kGMw@mail.gmail.com> <1356327291-ner-6552@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Seth Robertson <in-gitvger@baka.org>,
	Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 06:46:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn0rf-00087Y-3U
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 06:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab2LXFpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 00:45:53 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:57578 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2LXFpv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 00:45:51 -0500
Received: by mail-ob0-f177.google.com with SMTP id uo13so6304328obb.22
        for <git@vger.kernel.org>; Sun, 23 Dec 2012 21:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1E9UWa1Ml8eUCl9UOqq9PVG9Ju4QCZc3uTNtSm01uCc=;
        b=FA92/y6b2MLNxULY7WpgC3e6epDgw21K/GAJSlqpcBpqNFh9E/jyN8rpMiPcR44/9O
         VHsPqBGfRGdLRDrd7WfiRHa189mNZ3YcEysI3sAwUpCgCXf1Rdx/9hHBoWjoNW+DcRsM
         Xi0eEh2AVZBGxrBFoSoe8OF5Mczdtlyr3ymgk52a7vVi+SMvIRSDlgJcCNoajiHivmAI
         NoK/axPqcdUURpRgiFr5kDpuHEHnbUAxHeKnppazIYBRWTGNRA/XJZH9kRPJ3zTUzuTY
         AOjOE9Hc+DPJXrTRAbCfapsa51wcwPoEZPMDZ+HeEbyKNNH3A20h56tVHwe6K90gHt8Y
         v44Q==
Received: by 10.182.212.2 with SMTP id ng2mr16727245obc.81.1356327951153; Sun,
 23 Dec 2012 21:45:51 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Sun, 23 Dec 2012 21:45:21 -0800 (PST)
In-Reply-To: <1356327291-ner-6552@calvin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212099>

On Mon, Dec 24, 2012 at 12:34 PM, Tomas Carnecky
<tomas.carnecky@gmail.com> wrote:
>> Maybe we should store this information. reflog is a perfect place for
>> this, I think. If this information is reliably available, git rebase
>> can be told to "rebase my whole branch" instead of my choosing the
>> base commit for it.
>
> What's the starting point of the branch if I type: git branch foo <commit-ish>?

You start working off <commit-ish> so I think the starting point would
be <commit-ish>.
-- 
Duy
