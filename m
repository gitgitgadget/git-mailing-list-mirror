From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: who's on first? - following first parent and merge-management
Date: Thu, 8 Mar 2012 01:49:11 -0600
Message-ID: <20120308074911.GA23712@burratino>
References: <jj6s47$m98$1@dough.gmane.org>
 <7vwr6woo8p.fsf@alter.siamese.dyndns.org>
 <7vty1zfwmd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 08:49:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Y6R-0002Tc-1C
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 08:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab2CHHtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 02:49:22 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:39098 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753807Ab2CHHtS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 02:49:18 -0500
Received: by obbuo6 with SMTP id uo6so312339obb.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 23:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PiHCnJ+07CjDhvZs6v/UxQgk+D2WE9eq6/GwYT1GQew=;
        b=MhwIgcJwop0csa/6z0JgT8EpHGOfE8HoiSpzENikyY9O5ssypuGhNbKR7shP6ciHfa
         AblFo9Mn/RjBjVZnHutAGMIlot/FKfC/cdBobwKTwsNCEGLtBJ/xXQ9P5itAOuyC9er4
         ieVGgzn82WU7j9UiW7FUTFQwGIEOSHnTPW5n9jAyTkM8S2T27ret2/74hPbxki7jA6XE
         eVttTKNSsjmWgG+8G+DL03AfrnoctAlDWxNzsvLyHocrXNHZsET3A5Uqi30IO5Kgl65D
         ZpnNhYyYqz/IZIfbAiR0UQQJOQKFQS3w8ypzOKUTCEHo5Hh87dK6M6G+PAP2PLwdO2fY
         KE7g==
Received: by 10.60.4.162 with SMTP id l2mr2491351oel.3.1331192958249;
        Wed, 07 Mar 2012 23:49:18 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b6sm1503631obe.12.2012.03.07.23.49.17
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 23:49:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vty1zfwmd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192534>

Hi all,

Junio C Hamano wrote:

> Given the above definition, the first thing to realize is that "the
> first parent" is primarily a local concept.
[... and much nice explanation ...]

Would you mind including this explanation as a new file with some name
like <Documentation/howto/using-first-parent.txt>?  I think the quoted
explanation is very clear and I have not come up with any obvious
tweaks to make to it, which is why I am simply suggesting this instead
of sending a patch that would repeat the same text.

Strawman abstract:

| From: Junio C Hamano <gitster@pobox.com>
| Date: Wed, 07 Mar 2012 22:13:46 -0800
| Subject: who's on first? - following first parent and merge-management
| Abstract: In this article, JC describes the "log --first-parent" and
|  "merge --no-ff" options and what kind of history makes them useful.

Hm?
Jonathan
