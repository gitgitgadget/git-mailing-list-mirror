From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: add the equivalent of diff --color-words
Date: Sat, 16 Oct 2010 20:58:36 -0500
Message-ID: <20101017015836.GC26656@burratino>
References: <3c06517d478b3725054f4ca08fb8c38e681549c4.1287223650.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 17 04:03:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Ib4-000565-Kl
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 04:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197Ab0JQCCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 22:02:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36332 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602Ab0JQCCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 22:02:09 -0400
Received: by ywi6 with SMTP id 6so903639ywi.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 19:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XOUR/0YBLY/TVSboeR05HcfBijhOa+j60hp3dHZyRlg=;
        b=DnjPCmA4yR4Ke9gZnWFflCp7hwBbskMUiIllAOgdzr0zjoP67KZcdlNkOwsjhcL6os
         yYWF7X+tFuj+/xZUb8xO8MtJps/E+gzsXT97nOksDu7TxOujfe1V5fgNCxsNVYv6+50t
         1AeffMJGhWJVv/V8dU7DxENJ1fXrRNFJn6nuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DTlCmB5R2Glpmngx+5GZh2sRCtWO2f7vrE5Swp5EkgD4lrP5LRmkDnswP/WIvuyDac
         nh52t6afxgSuffH97fUoCbl4cU2x00K5zrAIH1FyJxecglLPDj+hFmpWJQeB81aaHKWW
         htSISvYbZQ2vJ8Ag5xggXgHzElHyj0d+YP/50=
Received: by 10.90.67.19 with SMTP id p19mr448040aga.164.1287280928829;
        Sat, 16 Oct 2010 19:02:08 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id b25sm19002258anb.3.2010.10.16.19.02.06
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 19:02:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3c06517d478b3725054f4ca08fb8c38e681549c4.1287223650.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159185>

Thomas Rast wrote:

> Use the newly added 'diff --word-diff=porcelain' to teach gitk a
> color-words mode, with two different modes analogous to the
> --word-diff=plain and --word-diff=color settings.  These are selected
> by a dropdown box.
>
> As an extra twist, automatically enable this word-diff support when
> the user mentions a word-diff related option on the command line.

I like this a lot.

After this patch, the diff pane looks like this:

( ) Diff ( ) Old version ( ) New version   Lines of context: [3 +/-] \
	[ ] Ignore space changes  [ Line diff      v]

all on one line.  In particular, it is easy not to notice the
new dropdown.

One might be tempted to change the Elide added lines/Elide removed
lines radio buttons into a dropdown box, but that would remove the
neat-o ability to switch between "before" and "after" views with a
single click.  Oh well --- screens are getting bigger, anyway.
