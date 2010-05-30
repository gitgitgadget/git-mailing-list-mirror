From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] Add handler for SVN dump
Date: Sun, 30 May 2010 03:59:37 -0500
Message-ID: <20100530085937.GA5513@progeny.tock>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
 <1274650832-7411-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 11:02:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIePw-0008Pp-4v
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 11:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab0E3I7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 04:59:08 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:35113 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab0E3I7G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 04:59:06 -0400
Received: by ywh9 with SMTP id 9so1785012ywh.17
        for <git@vger.kernel.org>; Sun, 30 May 2010 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2SlPR/O6EwgFeswmJ22TP8kF5vL1TQattMD6DeJYmdw=;
        b=cvsYUy80itj5QTR4GPo1KUuHJzhJmNNNHIKOb1E98o0Nyus/Mlm3ulXqSu9wr+jbiq
         EBk9rd1Lhf3BFEoRSyKW3FhOKBJdmZ+64SK0wxh3KEhZUUv9Vzn9880fz/F7LJvEVpWQ
         4Dc2NMkbwKrrExL+0oaFVFXTnzYX5hjGpd8kM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I5ItSzRmCYNKjVJOLdSWiP4aG1rOIVxl5S1TMbJQPrdVVEHe0S1T6OiCNTSdVpHHGE
         6LX9J5Fhm5fTM8AhFHg4d0M34NHU3dxrbpCcxKcj6NPAO27iQcidFxS4PZEl6POKwnYC
         6LXtDA18sqduB0pn+a+rRyXRvGE3pAJdWmp00=
Received: by 10.231.158.131 with SMTP id f3mr3674184ibx.54.1275209944244;
        Sun, 30 May 2010 01:59:04 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm20228285ibg.3.2010.05.30.01.59.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 01:59:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1274650832-7411-8-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147990>

Ramkumar Ramachandra wrote:

> Expose an API to parse an SVN dump created with `svnadmin dump` and
> emit a fast-import stream using fast_export and repo_tree. This is a
> temporary workaround: it will be replaced with a client that
> communicates live with a remote SVN server in future.

Hmm.  I suspect the svndump-to-fastimport converter might be useful as
a sort of swiss army knife even after remote-svn moves on to use
the ra lib.  What would you think about putting a main() function to
build the standalone program under contrib/fast-import?

I can write a patch for it for next round if you like the idea.

Jonathan
