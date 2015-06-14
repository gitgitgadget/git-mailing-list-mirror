From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Failed assertion in pathspec.c
Date: Sun, 14 Jun 2015 07:40:21 +0700
Message-ID: <CACsJy8DX9ZnUiFvyLwrhG=BDtXr333WpK5y0Axd0-6grOOf6aA@mail.gmail.com>
References: <20150613191839.3585effd@SaMobile>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sami Boukortt <samiboukortt@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 02:48:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3w6b-0004yp-Jz
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 02:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbbFNAkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 20:40:53 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36918 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbbFNAkw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 20:40:52 -0400
Received: by igbsb11 with SMTP id sb11so30739053igb.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 17:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DcJRzGuo0pRf1D7ZH2ojoPBaHOsoJLEL3tmXj/zaqzo=;
        b=rxmqPHSe7IBqZn4IGll4z3bhf/K57eI/yuM0Cij6rHKbF5ds+B+3iUpC1BBcLWRP2F
         x9d5x4RKv9IPHnFCB+48zsyYtgh+lwt+kqWsBxAcfBE/5JyOz10T0KrYxa1Zvdrk9408
         5kOCLNyuxX+k/X7e1DlgpeDYggmrtevJeeIpP+y2xS7MgLE97AHKZcDGT7B4ajZ0F56D
         DbpqXawR25krNkcFx+25RFWCgCo69nMUoEmuVbiZaCfePKaaRxA+gj7mS58+N2tGmz72
         d+0stJqN4DEg5+4ucY0ZnOleFKhF/qGPVRkSxHQ4FnN/SSqg8jThrMwyzyJ7BLIJx2TC
         EasQ==
X-Received: by 10.50.132.70 with SMTP id os6mr12824578igb.27.1434242451496;
 Sat, 13 Jun 2015 17:40:51 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Sat, 13 Jun 2015 17:40:21 -0700 (PDT)
In-Reply-To: <20150613191839.3585effd@SaMobile>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271602>

On Sun, Jun 14, 2015 at 12:18 AM, Sami Boukortt <samiboukortt@gmail.com> wrote:
> git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len
> <= item->len && item->prefix <= item->len' failed.

Known issue, but no one stepped up to fix it yet

http://thread.gmane.org/gmane.comp.version-control.git/267095
-- 
Duy
