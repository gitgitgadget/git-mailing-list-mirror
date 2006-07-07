From: David Lang <dlang@digitalinsight.com>
Subject: Re: [PATCH] Use configurable zlib compression level everywhere.
Date: Fri, 7 Jul 2006 14:53:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0607071451430.1836@qynat.qvtvafvgr.pbz>
References: <loom.20060703T124601-969@post.gmane.org><81b0412b0607030503p63b
 4ee31v7776bd155d3dab29@mail.gmail.com><44A91C7A.6090902@fys.uio.no><Pine.LN
 X.4.64.0607031030150.1213@localhost.localdomain><Pine.LNX.4.64.060703092949
 0.12404@g5.osdl.org><8564ie8qbe.fsf_-_@lupus.ig3.net>
 <7v4pxyscdt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Joachim B Haga <cjhaga@fys.uio.no>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 02:06:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz0LY-0002qz-Um
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 02:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWGHAGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 20:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWGHAGB
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 20:06:01 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:15786 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750773AbWGHAGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 20:06:00 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Fri, 7 Jul 2006 17:06:00 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Fri, 07 Jul 2006 17:05:49 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pxyscdt.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23469>

On Mon, 3 Jul 2006, Junio C Hamano wrote:

> * sha1write_compressed() in csum-file.c is for producing packs
>   and most of the things we compress there are deltas and less
>   compressible, so even when core.compression is set to high we
>   might be better off using faster compression.

why would deltas have poor compression? I'd expect them to have about the same 
as the files they are deltas of (or slightly better due to the fact that the 
deta metainfo is highly repetitive)

David Lang
