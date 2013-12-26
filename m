From: George Bateman <georgebateman16@gmail.com>
Subject: Crash on context menu
Date: Thu, 26 Dec 2013 13:16:15 +0000
Message-ID: <CAMPNTL3vrSUSbMP4-NsA=38KBM6iS9o9_Ywrzh1V_i42JmYFrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 26 14:29:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwB0G-0008Kb-MP
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 14:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab3LZN3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 08:29:08 -0500
Received: from mail-ie0-f196.google.com ([209.85.223.196]:38039 "EHLO
	mail-ie0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab3LZN3D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 08:29:03 -0500
Received: by mail-ie0-f196.google.com with SMTP id e14so3665298iej.11
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 05:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=xnBkr0cR6IZ0CKULBhSk/1GxClf3ysISAhwAZw3M8aM=;
        b=fykIkRyGiIUJDqtegJsuO11cD4xjpkPsNrPuch4+R+9FfWudUUQCZtgCFlluuk8vvj
         EJGsOSH9p7KC0N5xsOZp+km3g7yxuaFAaC3PbvFYl7M9ReOpeVMo10p3ldFVHUOkt6fM
         bh+bfS2yzYGo0/4cEd8oVCxnC5KeFHJT7C578BJY7hIpi1ox4jYSL9bTceWqAUwk2eJx
         jfuqjMAcchhdSwP5cnSPxYEgr8u8zpGMwXt+gs5f1h9nn99NUTkC5sN/7HskTdfM9TDp
         I+xk9KykgWviRYTYmpbTYjwzmeL/iEEBu93r5keVTyp29VhrphkfmBnaZ4AIlAkvC3Z8
         NJHw==
X-Received: by 10.50.14.202 with SMTP id r10mr18036042igc.18.1388063775911;
 Thu, 26 Dec 2013 05:16:15 -0800 (PST)
Received: by 10.64.96.230 with HTTP; Thu, 26 Dec 2013 05:16:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239693>

Win7 SP1; Git identifies itself as version 1.8.4-preview20130916.
I copied the Git Bash shortcut from the start menu to the root of a
Git repository (no remote part). I use the advanced context menu. For
other files in the directory, it works fine, but hovering over the Git
GUI option of the Bash shortcut's menu causes a hang and this error:
Problem signature:
  Problem Event Name:    APPCRASH
  Application Name:    explorer.exe
  Application Version:    6.1.7601.17567
  Application Timestamp:    4d672ee4
  Fault Module Name:    git_shell_ext64.dll
  Fault Module Version:    0.1.0.0
  Fault Module Timestamp:    5236e807
  Exception Code:    c0000005
  Exception Offset:    0000000000005952
  OS Version:    6.1.7601.2.1.0.768.3
  Locale ID:    2057
  Additional Information 1:    e0e1
  Additional Information 2:    e0e1a815a0aa94764feb60e78ef36122
  Additional Information 3:    adad
  Additional Information 4:    adad544d8612f37837c12844e48b8ca2

It seems odd that  it occurs on hover, but nothing else - time or
other menu items - trigger it.
