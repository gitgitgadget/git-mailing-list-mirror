From: Anarky <ghostanarky@gmail.com>
Subject: Bug? git status --porcelain --branch is translated
Date: Thu, 20 Mar 2014 11:31:59 +0100
Message-ID: <CAPP0M7Rw50hPHm49FetNXPGESXOoAND4NXU9F=rajv+NA=G32Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:32:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQaGf-0004Mu-1s
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 11:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbaCTKcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 06:32:00 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:52024 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbaCTKb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 06:31:59 -0400
Received: by mail-qg0-f46.google.com with SMTP id e89so1979392qgf.5
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 03:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=saRnHepE6XaAEpEoHraqvAXABmdtvPOTDrkNFVZRtqg=;
        b=FRB5K6m5Qqmfo6Rlld9Dbtys3Q9lO7mNQVGxlybGInhkjFvZrA8MRXQEUZdJct/ssK
         jVktrV0vLGnlWRn+iux8FlNh7eDxGz3qZG2RjTzfEryZcTc+FvfBX7/EKSIUMBLirQ35
         dBveUdPfgyFnDOGkMW8L5gZaWTXa+0ix8uFLifUHL4GcptMqk6bapp8jFLDvlZWHXszt
         bZDVN4KfzonsdFKNQZ1a65DRt6Q4JzupJ0WskE98XPzAbZb/tFgP5xplPFKbeeAo1M8j
         G2UcV8bPxHBNUof4TNFlSjV94XRgCtzJRVIZMQF8kyywAAJxO3F46DR2qoPYrUoI//S7
         BB2A==
X-Received: by 10.140.96.230 with SMTP id k93mr46482932qge.60.1395311519339;
 Thu, 20 Mar 2014 03:31:59 -0700 (PDT)
Received: by 10.140.101.232 with HTTP; Thu, 20 Mar 2014 03:31:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244539>

Hello,

The porcelain format of git status is described as not based on user
configuration.
But with --branch, behind/ahead are translated following the user's locale.
Is it normal that scripts need to take care of that?

Thanks.
