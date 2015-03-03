From: Paul Tan <pyokagan@gmail.com>
Subject: [GSoC15] Interested in contributing to git
Date: Tue, 3 Mar 2015 23:56:11 +0800
Message-ID: <CACRoPnSrjysUhC77LXVjy5VJxFFPoiRuhD7pMab_8T2Pua_T+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 16:56:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSpBC-0005nl-0V
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 16:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612AbbCCP4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 10:56:14 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:46568 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413AbbCCP4N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 10:56:13 -0500
Received: by lbiz11 with SMTP id z11so12088345lbi.13
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 07:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=wggLoSTb6C/nxbS126H6cLNvM/mmejuMuKyh0Fr8Pdk=;
        b=dh//AlNfLAmc5fZif2zf5uYqUu2EVP2TLoXB9jCdZdjMrKxuaC9qK/cti9jGpdU9Jq
         cmO4fqQB44s0QRdMpaqfVlFc/d9IEtSZRfGt++vzHfmrUsVLt9R5u7MqBYiRLMML7LlU
         9hFSV92YexxThvfQYhtjQkhcpUQzxuZ9jL9AkV3OEzpKv0V3QqgwXCGV8SAvbBLvnKD3
         XUmTnOvpYNhy0M7efnCV9AoDbQZzoiDi+toWDKDXTT9Ls1wnwha2AXnoDSOEp1S5Pk58
         BuXSScNdmo3qOxs3OE4l2h4S0ppvvxNlzxD8c53tidGEIYjMdvV6ysFLNeVklFyq58hy
         5pFg==
X-Received: by 10.112.130.39 with SMTP id ob7mr20421367lbb.32.1425398171191;
 Tue, 03 Mar 2015 07:56:11 -0800 (PST)
Received: by 10.112.130.228 with HTTP; Tue, 3 Mar 2015 07:56:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264666>

Hi all,

git is one of the projects that I wish to contribute to for Google
Summer of Code 2015 as it's an integral part of my workflow. I'm from
Singapore, and have been accepted to the National University of
Singapore for Computer Engineering, and will only matriculate on 3 Aug
2015. I have experience in programming with Python, C and C++, and
have successfully submitted patches to projects such as libuv[1] and
node-contextify[2].

[1]: https://github.com/joyent/libuv/commit/347000929de775ae6b975a2959f5fabe81d6f1f0
[2]: https://github.com/brianmcd/contextify/commit/7e3e0a89779cd892b3d8604795b6675d6aecff17

I understand that I have to complete a microproject. I would like
complete "Move ~/.git-credentials and ~/.git-credential-cache to
~/.config/git". I'm thinking that the XDG locations should take
precedence over the non-XDG locations?

For the project, I am interested in implementing "git fetch --deepen"
because I use the shallow clone feature quite often. I'm looking over
the source code to see how difficult it would be to implement it :)

Thanks,
Paul
