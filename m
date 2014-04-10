From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH] Add support for commit attributes
Date: Thu, 10 Apr 2014 12:28:13 -0500
Message-ID: <5346d4adf4f_69dfeb32f0b9@nysa.notmuch>
References: <1397072295-7670-1-git-send-email-diego.lago.gonzalez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Diego Lago <diego.lago.gonzalez@gmail.com>
To: Diego Lago <diego.lago.gonzalez@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 19:38:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYIvd-0003E0-C3
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 19:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbaDJRiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 13:38:14 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:41172 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbaDJRiM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 13:38:12 -0400
Received: by mail-ob0-f173.google.com with SMTP id gq1so4765045obb.18
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=6fxcWzKG9misZqvqG7r/YfzK6NAKgauAZCCJo4aAzbw=;
        b=fSo4v+Gf9j7DiqB1q6UZjD9jmgJK7wHlSLdQhXatW8MqAfPSaFBJoxpakG6GfMrcDs
         HcNpO4qU6DdVo1T8BvbBXtC7KsTD1nNakIBFSHM18n75bDKZMdoxlkSx9Gm0ZRLn4a9e
         41IlmEVZN9/SjEWvkb0Cfh7SDZVrLgXApOCmoxH9R+dZY1tBd9ccBJVRHKNLeEnd0wJb
         mIeuIfoun26RwP3nrsIPo96l3moEed3wl5wsRj3ShNgV+J3ESHdSdFkA5iAbK5RDfSJ5
         C20WZ9DJOhrt0WRmk9YiP5wJ93x6FQTFYXY/EeRSyWnXWbevJUAAhWoDW5EszT0EY5bD
         fCnA==
X-Received: by 10.182.29.225 with SMTP id n1mr3860198obh.2.1397151492215;
        Thu, 10 Apr 2014 10:38:12 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id tr10sm7973488obb.6.2014.04.10.10.38.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 10:38:11 -0700 (PDT)
In-Reply-To: <1397072295-7670-1-git-send-email-diego.lago.gonzalez@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246022>

Diego Lago wrote:
> Commit attributes are custom commit extra headers the user can
> add to the commit object.
> 
> The motivation for this patch is that in my company we have a custom
> continuous integration software that uses a custom formatted commit
> message (currently in YALM format) to show several information into
> our CI server front-end.

These attributes can be used for remote-helpers as well; to store extra
information that cannot be stored otherwise in Git's data structures.

-- 
Felipe Contreras
