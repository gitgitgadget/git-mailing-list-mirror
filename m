From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCHv3 5/5] Add test showing git-fetch groks gitfiles
Date: Thu, 6 Oct 2011 14:13:42 +1100
Message-ID: <CACsJy8ANRyqpsuCu+Nir4ux18E-U9Evwa07Eosi1REROo1U_og@mail.gmail.com>
References: <4E8C5D31.2000406@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 05:14:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBePd-0006nV-Ky
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 05:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934506Ab1JFDON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 23:14:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49469 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1JFDON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 23:14:13 -0400
Received: by bkbzt4 with SMTP id zt4so2890465bkb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 20:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i0fckCVcmkSkL3/O7OmzBmRiLu1PnGGa448E/YGaL5o=;
        b=kKzAw3CzUDLxbwX9ieWsjjF2xudNSAeJDqU5GzoskBWWurgh7HzIPWteSIwPV1eZWk
         Qbt8NoWR/z9ixFqrEt+UXtaM1U1wNFHxk6j2mrzJFEL9FBIE1n8GLtA9KsfG1bB15QdE
         qo7q4y4+EhTgwJ/ALVib0FF4zYKl/U0KEZFQY=
Received: by 10.204.152.201 with SMTP id h9mr164178bkw.147.1317870852087; Wed,
 05 Oct 2011 20:14:12 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 5 Oct 2011 20:13:42 -0700 (PDT)
In-Reply-To: <4E8C5D31.2000406@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182922>

On Thu, Oct 6, 2011 at 12:35 AM, Phil Hord <hordp@cisco.com> wrote:
> Add a test for two subtly different cases: 'git fetch path/.git'
> and 'git fetch path' to confirm that transport recognizes both
> paths as git repositories when using the gitfile mechanism.

It'd be interesting to test failed cases too. I can think of two: .git
file is not a valid file and .git points to an invalid repo.
-- 
Duy
