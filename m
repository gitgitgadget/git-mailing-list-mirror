From: Mitch Tishmack <mitcht.git@gmail.com>
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Mon, 5 May 2008 14:32:30 -0500
Message-ID: <A9FCB174-C3CC-4DB4-91CA-9AFA32AAF11E@gmail.com>
References: <86wsm9dbhk.fsf@blue.stonehenge.com> <20080504215208.GG29038@spearce.org> <86skwxd97d.fsf@blue.stonehenge.com> <8663tsbqg0.fsf@blue.stonehenge.com> <alpine.LFD.1.10.0805051049440.32269@woody.linux-foundation.org> <905315640805051200g4c155d15xada4f17e5e2fc424@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 21:33:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt6RA-00081c-Gc
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 21:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbYEETcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 15:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbYEETcf
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 15:32:35 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:33699 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbYEETce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 15:32:34 -0400
Received: by py-out-1112.google.com with SMTP id u52so1583702pyb.10
        for <git@vger.kernel.org>; Mon, 05 May 2008 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=Z3Jvpcs02erhS5zCw+FdUU08pxdaj6ueJAgh7FAlY1I=;
        b=vdr+LggRP6cRCLiW8PfaPdXKDJG6mGrNNwk6JXfcnuvyH1FfBElOQm9TQfVHkI7wsk+SsGMqtCJ9TQ1pNYpPXlYbVtyfC/U19UDIaxBrKGpaKS8Y01w5MbJlRv6BE4MGe6mrMZMJHGvvgrTTwaNQTabU5cxZi0FJ8TirFH8PNOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=dW8c360A4bDiVvCsj6cvCZNBwFTTMja2mjvVUlXEX0zp7QK75JSecOL53GDtcTVkxZ7t8GNHz8NxuD6WAwO5uhcxbs4rGesLWkAYBx/BGVHhmfK3ASK2bkgQrgALHBLzul0fOkSONMZbowzxnNqDt7NGyba3Uw+Cdu6rEsnTVPw=
Received: by 10.35.61.17 with SMTP id o17mr1292638pyk.4.1210015953475;
        Mon, 05 May 2008 12:32:33 -0700 (PDT)
Received: from ?192.168.3.159? ( [71.216.112.176])
        by mx.google.com with ESMTPS id f24sm1401255pyh.26.2008.05.05.12.32.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 May 2008 12:32:32 -0700 (PDT)
In-Reply-To: <905315640805051200g4c155d15xada4f17e5e2fc424@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81306>


On May 5, 2008, at 02:00 PM, Tarmigan wrote:
>
> Not sure if that is always the case.  This thread suggests otherwise:
> http://opensolaris.org/jive/thread.jspa?threadID=53303&tstart=0
>
> Case sensitivity and mangling look like they are configurable.  See
> the "casesensitivity" and "normalization" options at
> http://docs.sun.com/app/docs/doc/819-2240/zfs-1m
>
> ZFS on OSX may just default to "insensitive" and some form of
> normalization especially if they were/are thinking about making it the
> default fs and wanted backwards compatibility for broken apps.
> Randal, can you make a new FS with casesensitivity=sensitive and
> normalization=none and see how it behaves?

Those are only valid in OpenSolaris at the moment, they do nothing on  
the Leopard zfs beta:
macbookprov2# zfs set casesensitivity=sensitive zfs
cannot set property for 'zfs': invalid property 'casesensitivity'
macbookprov2# zfs set normalization=none zfs
cannot set property for 'zfs': invalid property 'normalization'
macbookprov2# uname -a
Darwin macbookprov2.local 9.2.2 Darwin Kernel Version 9.2.2: Tue Mar   
4 21:17:34 PST 2008; root:xnu-1228.4.31~1/RELEASE_I386 i386
macbookprov2# zfs get all zfs
NAME  PROPERTY       VALUE                  SOURCE
zfs   type           filesystem             -
zfs   creation       Sun May  4 22:03 2008  -
zfs   used           38.3M                  -
zfs   available      922M                   -
zfs   referenced     38.2M                  -
zfs   compressratio  1.00x                  -
zfs   mounted        yes                    -
zfs   quota          none                   default
zfs   reservation    none                   default
zfs   recordsize     128K                   default
zfs   mountpoint     /Volumes/zfs           default
zfs   sharenfs       off                    default
zfs   checksum       on                     default
zfs   compression    off                    default
zfs   atime          on                     default
zfs   devices        on                     default
zfs   exec           on                     default
zfs   setuid         on                     default
zfs   readonly       off                    default
zfs   zoned          off                    default
zfs   snapdir        hidden                 default
zfs   aclmode        groupmask              default
zfs   aclinherit     secure                 default
zfs   canmount       on                     default
zfs   shareiscsi     off                    default
zfs   xattr          on                     default
zfs   copies         1                      default
zfs   version        1                      -

mitch
