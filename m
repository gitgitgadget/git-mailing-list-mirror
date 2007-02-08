From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] qgit: Default the log window to wider than the file list and set monospaced font
Date: Thu, 8 Feb 2007 10:20:41 +0000
Message-ID: <200702081020.44202.andyparkins@gmail.com>
References: <200702072138.36787.andyparkins@gmail.com> <e5bfff550702080039l236b1f69o6765b8e2dff3e3c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 11:20:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF6Oc-0004ln-Lf
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 11:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423061AbXBHKUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 05:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423110AbXBHKUv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 05:20:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:4494 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423061AbXBHKUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 05:20:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so419603uga
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 02:20:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qTIjfchC+1vUZxHgbqedKeQW8LqhTLyjvGTuyZVS1qGit4FYgOZ/EKE0B662W/FClStQyUj/dwuYy6UkSfbw+u+giQ2jlNv7YdYRElAFgYZygXmji5zStqDQgkyvWZTkJNLV9RHzS+u6zDdanTYfjxXMRDeYUc09BuQ1R5cs51Q=
Received: by 10.78.193.5 with SMTP id q5mr3909037huf.1170930049234;
        Thu, 08 Feb 2007 02:20:49 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 55sm2858520ugq.2007.02.08.02.20.46;
        Thu, 08 Feb 2007 02:20:47 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <e5bfff550702080039l236b1f69o6765b8e2dff3e3c4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39053>

On Thursday 2007 February 08 08:39, Marco Costalba wrote:

> Regarding "Monospace" it should be changeable with Settings menu and
> should apply _only_ to fixed space font viewers, in our case only
> patch viewer and file content viewer.

The log message was the one I changed.  Having the log message in variable 
width breaks any ascii-art in the message.

I completely agree about pulling the setting from the config.  I'll see if I 
can find that and post a further patch.

> If you see Monospace applied to list view or any other widget apart
> from the above mentioned ones then it's a bug.

True.  I used "Monospaced" as the font as that defaults to the system-wide 
monospaced font; however it's pretty poor form.  I raise my hand - shoot 
me :-)  As I say, I'll try and do better and send a new patch.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
