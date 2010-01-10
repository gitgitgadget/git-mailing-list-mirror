From: Leo Razoumov <slonik.az@gmail.com>
Subject: How to check new commit availability without full fetch?
Date: Sun, 10 Jan 2010 06:12:09 -0500
Message-ID: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 12:12:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTviU-0006Hk-U1
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 12:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab0AJLMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 06:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500Ab0AJLMM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 06:12:12 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:24727 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab0AJLML (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 06:12:11 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1601306eye.19
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 03:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type;
        bh=HCZpX0DYGsh7WnI/f4+Z2wC8fNd88tTLdjTZOo2TBRQ=;
        b=HKyq+c1KIxNkR18934B6a+7K/4/DlEsnddB9RVGfrLeHmNnEj6taP261OAjKCR5eGo
         e/dIUD6MRTuAvwIb6aC06vyb7FsoF2n3MN8aR31URf1HUS5Ad1Cu39JJKgqLw7Tr4nKj
         JRmxBrmjFytChbh4+dVlhSTqRx95F9CN0Lj+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=NlH0f1nu1spXpQHZn3A0ybdE7XpXUsRYOIuzdE/LBwIEaEdXR2W8bkkPRJwei07iWx
         AamjYZSS+6DlDMxbpULs8BIXpG9YQyUVg3VyNA2onUEbu9b7DYBogQunVNY8p0T3goCj
         kivGHHKLuOGAKNzQ4t6f5udoqtCNq5/qE4SyM=
Received: by 10.216.85.130 with SMTP id u2mr208794wee.135.1263121929442; Sun, 
	10 Jan 2010 03:12:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136566>

Hi List,
I am trying to find a way to check availability of new commits
*before* doing fetch or pull. Unfortunately, neither fetch nor pull
take "--dry-run" option (unlike push)
I am sure I am not the only one with such an itch.

Any help and advice are greatly appreciated.

--Leo--
