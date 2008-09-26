From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [RFC PATCH (GIT-GUI)] git-gui: Add more integration options to citool.
Date: Fri, 26 Sep 2008 14:19:40 +0400
Organization: HOME
Message-ID: <200809261419.41392.angavrilov@gmail.com>
References: <200809122243.50007.angavrilov@gmail.com> <20080924165201.GV3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:22:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjASw-0005w4-6o
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 12:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbYIZKVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 06:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbYIZKVL
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 06:21:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:58255 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbYIZKVK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 06:21:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so601386fgg.17
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 03:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=CHdl7r2NsWv6s7oxpMuBUM/ft7BUlR17XxSQ0b0PW9o=;
        b=XrKAbdLa/n3Pps7+46Fxnp/DOgdt7X7lXiuOvtnZ2ycSTEBhj3tDgo1VLARKbv5Zx0
         8T7X9oWAKfZSaSlcEc+IeFcZjBNl9wM6a/OY/QJiB2SZYUlwh8WJ7NlsbEoMQHEdvXdi
         3ZFmG3e2He+hQ1YMHBFaRabHkhZT8JAWwfnb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MB5nvS+mR+G9n632cR000ZoYhrrXWSKzjkOoJRor+LC4tTS6lemrAUy72y0BNrtQ96
         jivxn8xbilyLTpUgY1vGOJ3HJVb/nY0NONnYysXIZUNX7VElI7WKhuUW55UBQiLzLwVV
         JUzV/cuCMQEePwQir5KvPPOnuMNytKRPlXl5U=
Received: by 10.180.248.13 with SMTP id v13mr543792bkh.92.1222424468735;
        Fri, 26 Sep 2008 03:21:08 -0700 (PDT)
Received: from keydesk.localnet ( [92.255.85.78])
        by mx.google.com with ESMTPS id p9sm2321583fkb.5.2008.09.26.03.21.07
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 26 Sep 2008 03:21:07 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.3-29.fc9.i686; KDE/4.1.0; i686; ; )
In-Reply-To: <20080924165201.GV3669@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96843>

On Wednesday 24 September 2008 20:52:01 Shawn O. Pearce wrote:
> Alexander Gavrilov <angavrilov@gmail.com> wrote:
> > - Make citool return nonzero exit code if it did not commit.
> > - Add a mode where it does not actually commit and simply
> >   exits with zero code. Commit message is either disabled,
> >   or simply dumped to GITGUI_EDITMSG before exiting.
> > - Add an option to immediately start it in amend mode.
> ...
> > 	I think this functionality might be useful, in particular for some of
> > 	my own scripts. But I'm not sure if this is the best way to do it.
> 
> This looks good to me, but I think we may want to add this as a
> follow-up patch.  Thoughts?
> 
> --8<--
> git-gui: Hide commit related UI during citool --nocommit
> 
> If the user started git-gui as "git citool --nocommit" then they
> don't need the new commit / amend commit radio buttons, or the sign
> off button in the UI.  Rather than use up space with options the
> user cannot activate they are simply not installed into the UI.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---

I believe that the 'Sign Off' button should better be controlled by the nocommitmsg
option; otherwise this looks good to me. But I'm not the best thinker at the
moment (had a cold).

Alexander
