From: Robin Rosenberg <robin.rosenberg@gmail.com>
Subject: Re: [PATCH (GIT-GUI BUG)] git-gui: Fix post-commit status with subject in non-locale encoding.
Date: Sat, 24 Jan 2009 07:37:30 +0100
Message-ID: <200901240737.31092.robin.rosenberg@gmail.com>
References: <200901240018.13457.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 07:39:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQcAa-0002F7-TX
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 07:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbZAXGhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 01:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbZAXGhj
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 01:37:39 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:41951 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbZAXGhj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 01:37:39 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5067535rvb.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 22:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YQZY/R37gXwALGieLiPpUKkcr1D5Hgq6GWGDNprHDfw=;
        b=CN3pwntKnUoEd8sw985ITdWNApJvgxf7QbEGgqElb3XAsJloukRkuc1a0LPafHSjIb
         6sRFpY5to44wp9HcDzYqSsNL5U6pFLs9ZWLTPtDg/8O5zvnP+OxZeJQq7FRjJpv34sO/
         KXujJb32uGhHuRYL1cWZ3wPdAtz+DMtYoMHl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SXcqIbhv+dNToYSMIXKfuIKArEayRARH9MLqLojsetEZnMcZlOjFfvGbxXWKdps7wK
         HRgAsKAUcgTyG65AfbYB0BDU4EnOQaHvbdtUvaGfW41+eD4Ve0zJBBxA5Fj6cb7ExySF
         RlQqvfcStxMqwuwv8CEXF52i4uPzHqrZJAPqM=
Received: by 10.141.180.5 with SMTP id h5mr3028467rvp.82.1232779058068;
        Fri, 23 Jan 2009 22:37:38 -0800 (PST)
Received: from sleipner.localnet (h59n1fls34o811.telia.com [213.67.102.59])
        by mx.google.com with ESMTPS id g31sm24000289rvb.4.2009.01.23.22.37.33
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jan 2009 22:37:35 -0800 (PST)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <200901240018.13457.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106957>

fredag 23 januari 2009 22:18:13 skrev Alexander Gavrilov:
> As pointed out in msysgit bug #181, when a non-locale encoding
> is used for commits, post-commit status messages display the
> subject incorrectly. It happens because the file handle is
> not properly configured before the subject is read back.
> 
> This patch fixes it by factoring out the code that is
> used to setup the output handle into a separate function,
> and calling it from the reading code.

Ack. Works fine now.

Thanks.

-- robin
