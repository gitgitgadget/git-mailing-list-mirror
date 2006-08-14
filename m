From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's in git.git
Date: Mon, 14 Aug 2006 10:11:12 +0200
Message-ID: <81b0412b0608140111w20eedd07wbbede77a9970d5ac@mail.gmail.com>
References: <7vbqqogibr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 10:11:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCXXa-00051J-D4
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 10:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbWHNILO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 04:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWHNILO
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 04:11:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:26468 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751928AbWHNILN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 04:11:13 -0400
Received: by nf-out-0910.google.com with SMTP id a4so1644624nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 01:11:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K8X8tK3xv8PIawsFRPEqTLSEIrcjjjxTG3kqYRC6sGk/wOZjRZ3PcmKL3bUjHmP9Y/YAHOylkDxxblOEh5ull2pE1Qy6bnm3npXmYtKVT7WG7DTfID1sqtY55f/6+9GxZbQbHN12riCAh15slHf0VDUe9ONdfuKhT4WrYxXd4fg=
Received: by 10.78.127.6 with SMTP id z6mr3155721huc;
        Mon, 14 Aug 2006 01:11:12 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Mon, 14 Aug 2006 01:11:12 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vbqqogibr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25332>

On 8/14/06, Junio C Hamano <junkio@cox.net> wrote:
>       sha1_file.c: expose map_sha1_file() interface.

Could we have corresponding unmap_sha1_file too?
So that I can implement more effective mmap/munmap
for windows (or any other mmap challenged platform,
like QNX).
