From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 12:10:41 +0000
Message-ID: <AANLkTin-TAZXzTCisSQqxOQrJ0MqJ6XN75LJXiEDqegs@mail.gmail.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com>
	<AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com>
	<4C4BFAA3.3050700@digium.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com>
	<AANLkTilHrEImfhl0YTqj0MgXFTzYmJMJrUTKkflGFwpp@mail.gmail.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F99A@CORPUSMX100A.corp.emc.com>
	<AANLkTilhoF670uZ1WbosZP9TNbXect2A3gELRJL0ZZIn@mail.gmail.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F99B@CORPUSMX100A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kpfleming@digium.com, git@vger.kernel.org
To: lynn.lin@emc.com
X-From: git-owner@vger.kernel.org Sun Jul 25 14:10:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od02a-0007kZ-18
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 14:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab0GYMKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 08:10:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49002 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab0GYMKm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 08:10:42 -0400
Received: by iwn7 with SMTP id 7so1863431iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Qvz29TJLxThnMRnByHe86UwCCM6hqZFaPBGEIG1q878=;
        b=UByeT61F9LCS0snooaZUKnF3i1yxDWDzKC6PVvBqDL65TtUz2kbwIdPAWuQElOVTpm
         dsM97RGaVT9Me7KYnsiLU4pPYhZh1bxGKjUudur1h8YyYesC+sDGyuofohFolshZ9i5C
         NFfa5RVb1rrLejt6EjNIGax9xfZA28DfhE0e8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dWx/ZRS8UNnmc/aUh4tqlwak1KIaLFBOULhsxunhmlnAOrWF8qQX1eVrR6S+8nXOYT
         KexG6f0VbONBR48Pcbgbzy18lLdiroq/AXGIlDwErR1BTkcHOwHgdWQ+d4xypeH8Ow6I
         oJLvVJ7GxhDi6WmSJMW6Q4F9nPQ6Rz+7vs8Yk=
Received: by 10.231.170.79 with SMTP id c15mr7003974ibz.82.1280059841978; Sun, 
	25 Jul 2010 05:10:41 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 25 Jul 2010 05:10:41 -0700 (PDT)
In-Reply-To: <7F48A44C0E1FBF48B00D4DA49C85432E54F99B@CORPUSMX100A.corp.emc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151731>

On Sun, Jul 25, 2010 at 12:02,  <lynn.lin@emc.com> wrote:

> Sorry. It doesn't break something. The motivation is that it's redundant code

Ah, good to know. That was what I mainly wanted to know. Thanks.
