From: Alexander Vladimirov <alexander.idkfa.vladimirov@gmail.com>
Subject: git mergetool ignores configured command line
Date: Sun, 23 Oct 2011 12:43:26 +0800
Message-ID: <CAARCrw6D7CKy2Jn43zUZ3EefyqdY6Tk4A39ZQ74H6hySA5eCBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 23 06:43:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHpuG-0000Og-Jo
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 06:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab1JWEn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 00:43:27 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34554 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab1JWEn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 00:43:27 -0400
Received: by gyb13 with SMTP id 13so4881217gyb.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 21:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=VtWQr4kIwX87+kVCExkvbjh0Kwv0JAyqhZZ+uKCQaHI=;
        b=lEBBsuJVka6xu4FYVF3t00VM0b4JOmoOiHpRrH7Y/bQlH+lqNMDvvEVNVWQdJwBH1z
         7UpkFBnt/5WFPLe6FjpgdDu/q3/hCbpv7mclCxeR/yxFxt8zbvlQRTZbs4cgHcS0ctHn
         Uoa8Zo89sa7SIOEDXeYNQlBXNWzA1efdoS5CQ=
Received: by 10.146.230.42 with SMTP id c42mr4370098yah.12.1319345006638; Sat,
 22 Oct 2011 21:43:26 -0700 (PDT)
Received: by 10.146.84.9 with HTTP; Sat, 22 Oct 2011 21:43:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184125>

To configure diffuse as merge tool I set mergetool configuration using
following commands:

git config --global merge.tool diffuse
git config --global mergetool.diffuse.cmd '/usr/bin/diffuse "$LOCAL"
"$MERGED" "$REMOTE"'

Then, when I invoke mergetool during merge, I get diffuse with four
panes open as by default, instead of three specified in command line
setting.
Is this an expected behavior, and how can I force mergetool to use
provided command line?
