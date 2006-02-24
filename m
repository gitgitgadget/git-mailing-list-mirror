From: "Tony Luck" <tony.luck@intel.com>
Subject: git-mailinfo doesn't get installed any more
Date: Fri, 24 Feb 2006 12:06:55 -0800
Message-ID: <12c511ca0602241206jaea9f75pce4ca687f5b2fd3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Feb 24 21:07:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCjDR-0002LA-TF
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 21:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWBXUG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 15:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWBXUG6
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 15:06:58 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:39475 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932446AbWBXUG4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 15:06:56 -0500
Received: by zproxy.gmail.com with SMTP id r28so443545nza
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 12:06:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E/pa+WnM///lYc+Ku6HHN/k6A3Iud/ffgZQGzmVs42waAJECPUscgTwMnNbPwhyvYEopu70I+XfnaTE1Q+kIngJvXfnfKkkpL0gpeVLersk14WXJpir522tE/pSL4V1MOdtTVTbYAerGvI5QvEqS1HTykR/QiJHFLk0uWIsx9TY=
Received: by 10.65.155.4 with SMTP id h4mr3850027qbo;
        Fri, 24 Feb 2006 12:06:55 -0800 (PST)
Received: by 10.64.27.10 with HTTP; Fri, 24 Feb 2006 12:06:55 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16733>

Periodically after I upgrade git I do an "ls -lrt /usr/local/bin" to
find stray old binaries that aren't part of git anymore.  I was
a bit surprised to see that git-mailinfo had a mod-time a bit
older than the rest of git ... and looking at the Makefile it looks
like it got dropped in some rearrangement.

Two things:
1) Can someone put it back please, git-applymbox is very unhappy
without it.

2) What's the cute 1-line git way to see when this was broken. I'm
guessing that it involves using a --pickaxe.

Thanks

-Tony
