X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Sun, 17 Dec 2006 23:21:04 +1300
Message-ID: <46a038f90612170221u4c3b5c2asef378d3d4e159ba7@mail.gmail.com>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
	 <46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com>
	 <0ML25U-1GvWC81sjR-0001UB@mrelayeu.kundenserver.de>
	 <Pine.LNX.4.63.0612161227510.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 10:21:17 +0000 (UTC)
Cc: "Florian v. Savigny" <lorian@fsavigny.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NY9Y4s6oi2wAoerNmvVrTw0Q9IvmeT0262EfMriw/Ba/6VAhnacJxO+gsSShEepAS0rHeiMRCQ9WXP5hxk5FCl/7PgHbzk2fs9oxjz535P1ZwVPkNLCU+PW3uOIRRwuXKV6bcNVfUHMQpKJ+4JeLGqyIHRWDaL/rpAynjBfYleg=
In-Reply-To: <Pine.LNX.4.63.0612161227510.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34683>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvt8p-0003ry-Ql for gcvg-git@gmane.org; Sun, 17 Dec
 2006 11:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752362AbWLQKVH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 05:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbWLQKVH
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 05:21:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:28752 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752363AbWLQKVG (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec
 2006 05:21:06 -0500
Received: by nf-out-0910.google.com with SMTP id k26so1639750nfc for
 <git@vger.kernel.org>; Sun, 17 Dec 2006 02:21:04 -0800 (PST)
Received: by 10.49.90.18 with SMTP id s18mr3031242nfl.1166350864604; Sun, 17
 Dec 2006 02:21:04 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Sun, 17 Dec 2006 02:21:04 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 3. ad Johannes: This does sound quite simple and straightforward. If I
> >    got it right, it would involve having one repository on a, say,
> >    ext2 partition to work with under Linux, and one on a FAT32
> >    partition to work with under Windows, and syncing the two after
> >    booting (fetching from FAT32) and before shutting down (pushing to
> >    FAT32) Linux.
>
> This is how I'd do it.

And I concur - I had only introduced Samba to the conversation because
I thought you were talking about several computers. If you are
dual-booting on one machine, I'd do as above.

Note that under windows you can use ext2 -- haven't used it, and don't
know how cygwin behaves with it, but it may be *just* what you need to
avoid case sensitivity problems and have symlink support.

    http://sourceforge.net/projects/ext2fsd

    http://www.fs-driver.org/

cheers,



