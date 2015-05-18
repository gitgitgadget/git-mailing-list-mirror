From: FusionX86 <fusionx86@gmail.com>
Subject: git p4 clone - exclude file types
Date: Mon, 18 May 2015 11:59:11 -0600
Message-ID: <CAFcBi88K-HEn4JCVkONq3h4O9XS1FFX0OXch2d-VJ2bLEsPM0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 18 19:59:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPJt-0007Qw-I8
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 19:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbbERR7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 13:59:13 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:32936 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbbERR7M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 13:59:12 -0400
Received: by qgde91 with SMTP id e91so26353435qgd.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=3h/f+xzP/zDZrCfFsaNjMMgoh4V/4EqN1M0quQ3RgVw=;
        b=BCYFlNsne5XIga7/JTiYPVIRHW57j/KkJKxDCFAlY1N9V9cbeFo0wssmdznw/EWZUS
         kAIyyWes9PRhD6jZz18AcO7cPvaaYncUmZZO1cdX8Ncx4KrQldmFhRFqmC7uwJAiqG8S
         OV9JLeyGitJk0WSNorzZm+D2svbJvoAdMvXGgQszzp9T+KGPQ8REIHyU+FjhNOeA76u8
         THD+YzXfesq7HVhKMsKrT3h5o38voprH/mRTAedHW94wDpZmv8dmDaE4EYruWMHdU8Lr
         /lak6hvHl6eJHiv6O+bosZ6jr0a6Cg/JA5m+sGZIGw7YNTsNM09o3kjMH1a8EDG4Ko+D
         URzQ==
X-Received: by 10.55.21.8 with SMTP id f8mr50808847qkh.2.1431971951567; Mon,
 18 May 2015 10:59:11 -0700 (PDT)
Received: by 10.140.93.44 with HTTP; Mon, 18 May 2015 10:59:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269287>

Hello,

Anyone know of a way to 'git p4 clone' and exclude files by type or
name? For example, I want to clone a depot, but not pull down any .exe
files. Haven't been able to find an answer in docs or other searches.
