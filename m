From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: Watchman support for git
Date: Fri, 02 May 2014 22:40:48 -0500
Message-ID: <5364654088dc4_4d2010fb2ec7d@nysa.notmuch>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
 <536428224adfb_200c12912f010@nysa.notmuch>
 <1399083897.5310.0.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 05:51:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgQz8-0000Bf-8X
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 05:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbaECDva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 23:51:30 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42105 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbaECDv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 23:51:29 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so6205722obc.3
        for <git@vger.kernel.org>; Fri, 02 May 2014 20:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Iu8C/ZXO8Qj0VRv8FN0mrao+ul/fwMD+wi8CoqmdJ8w=;
        b=Slpec4V1v0/2RqkdmqNtJdJdWrESKckvK//MLdhdpEn14fJUeJSqwj4G3BJYel6OIi
         zQavmYNR803RngfWO71sPcfPDSOUBuoEUM9BuAYnwYDBlOOktN/fqXyXgAOCNZCJ+r3z
         6IhvIpJRtr7VQ9lvm7dMbAHfWxQIpxnyuci9tLdNBF16JiBeDI6Cn8B7TKzPtHy9WW5Q
         6C938CIBe+LXvZTqzdtqC/cokBGcx5k2DPx+M0YR8kTr/bGEXttqh3yVYKPatvkWQ/0l
         Un9Q72HnT+f0zqd+PYon/XurHLFgUuYdoj7uq0zktcRtXr5imTfy2lNopis1CNYmeV79
         VOLQ==
X-Received: by 10.60.77.35 with SMTP id p3mr20380385oew.46.1399089088914;
        Fri, 02 May 2014 20:51:28 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qh7sm2303072obc.13.2014.05.02.20.51.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 20:51:27 -0700 (PDT)
In-Reply-To: <1399083897.5310.0.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248016>

David Turner wrote:
> On Fri, 2014-05-02 at 18:20 -0500, Felipe Contreras wrote:
> > dturner@ wrote:
> > > Test repository 1: Linux
> > > 
> > > Linux is about 45k files in 3k directories.  The average length of a
> > > filename is about 32 bytes.
> > > 
> > > Git status timing:
> > > no watchman: 125ms
> > > watchman: 90ms
> > 
> > That's very interesting. Do you get similar improvements when doing
> > something similar in Merurial (watchman vs . no watchman).
> 
> I have not tried it.  My understanding is that this is why Facebook
> wrote Watchman and added support for it to Mercurial, so I would assume
> that the improvements are at least this good.

Yeah, my bet is that they are actually much better (because Mercurial
can't be so optimized as Git).

I'm interested in this number because if watchman in Git is improving it
by 30%, but in Mercurial it's improving it by 100% (made up number),
therefore it makes sens that you might want it more if you are using hg,
but not so much if you are using git.

Also, if similar repositories with Mercurial+watchman are actually
faster than Git+watchman, that means that there's room for improvement
in your implementation. This is not a big issue at this point of the
process, just something nice to know.

-- 
Felipe Contreras
