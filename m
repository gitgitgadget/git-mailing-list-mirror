X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Sat, 9 Dec 2006 09:27:46 +0100
Message-ID: <e7bda7770612090027x22a06ca5i6d9b768f0ad3c4ad@mail.gmail.com>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
	 <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
	 <20061207192632.GC12143@spearce.org>
	 <20061207193555.GD12143@spearce.org>
	 <46d6db660612071326m4817165l992e8d6e7bd673c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 08:28:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bLnxSGloKS/JddAffz36lIQ5AGZsBqsDFjTXoKhobqsLgDkdfj4bZtBbRGJpTVZDAbeUheMxiPDnIu3VoU4cbs2oXtjvOiDwfrpbU1YDg15Rw8YH2vmU6GmOmWVA4Xtk02ABThj0UjTxNKVFsfh5hn7Lje+CtD6o2X3Wneay+mg=
In-Reply-To: <46d6db660612071326m4817165l992e8d6e7bd673c5@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33806>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsxYs-0001F5-6L for gcvg-git@gmane.org; Sat, 09 Dec
 2006 09:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936116AbWLII1t (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 03:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936120AbWLII1s
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 03:27:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:62105 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S936116AbWLII1s (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 03:27:48 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1363285nfa for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 00:27:46 -0800 (PST)
Received: by 10.49.27.17 with SMTP id e17mr285935nfj.1165652866762; Sat, 09
 Dec 2006 00:27:46 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Sat, 9 Dec 2006 00:27:46 -0800 (PST)
To: "Christian MICHON" <christian.michon@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/7/06, Christian MICHON <christian.michon@gmail.com> wrote:
> On 12/7/06, Shawn Pearce <spearce@spearce.org> wrote:
> > Shawn Pearce <spearce@spearce.org> wrote:
> > > Its Cygwin/NTFS.  lstat() is slow.  readdir() is slow.  I have the
> > > same problem on my Cygwin systems.
> >
> > Just to be clear, I'm not trying to blame Cygwin here.
> >
> > Windows' dir command is slow.  Windows Explorer is slow while
> > browsing directories.

I think this is a very common scenario costing hideous amounts of
money around the globe.

If you have lot's of files in a folder, don't even think of
accidentally touching those folders in Windows Explorer, if you do -
keep Process Explorer or similar ready. I've ended up using (even w/o
Cygwin) scripts, automatic compressing and even a database functioning
as directory cache - basically creating accessibility layers for a
disabled file-system.


>
> before buying any new hardware, you could easily imagine the
> following scenario (I'm also "stuck" with windows, so it's an idea
> I've been toying around for a week or so).
>
> There're virtualizers around, on which networking capabilities can
> be activated. And we could easily create a vm with linux+git
> inside, using ext2/ext3/ext4 fs virtual disks (you'd benefit from
> windows cache actually...)
>
> example: YTech_Subversion_Appliance_v1.1 (ubuntu + subversion).
>
> I've no prototype yet, but I've 2 scenario possible:
> 1) use vmplayer and a minimal uclibc initramfs with git onboard
> 2) use qemu+kqemu and a similar mini-distro (but right now networking
> is an issue on windows hosts: I'm exploring tunneling)
>
> The 1st scenario is "easy". And I start to prefer this idea over
> even mingw porting of git (I tried and it's hard, really).
>
> But again, maybe jgit would be a better universal solution.
>
> --
> Christian
> -

Very interesting!  Have you a time-frame for this?  Maybe even
