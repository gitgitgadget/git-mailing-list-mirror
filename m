X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Sun, 10 Dec 2006 23:09:55 +0100
Message-ID: <e5bfff550612101409sf2b8b0dl37567b6c7e875b14@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org>
	 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
	 <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org>
	 <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org>
	 <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 22:10:11 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cR2aDRuHKN7sp4UDIReUqg+fUtQncXWMIcsZqLyoWtLhjDDSo5oJW58r9v3KTEbfHS71gIhYmQ+BJZ2f9LtBxg1C6v86XkjkQSR0fn+ZtUBMVbcAkkj8LkqZHWqrHjsXXqfZ45pibCfKl2UA+RJUgI3y8dlePKS1EFCj25y7z2g=
In-Reply-To: <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33939>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtWrw-0008PB-FA for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758292AbWLJWJ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758430AbWLJWJ5
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:09:57 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:26831 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758281AbWLJWJ4 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 17:09:56 -0500
Received: by py-out-1112.google.com with SMTP id a29so795229pyi for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 14:09:56 -0800 (PST)
Received: by 10.35.134.19 with SMTP id l19mr11053791pyn.1165788596185; Sun,
 10 Dec 2006 14:09:56 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sun, 10 Dec 2006 14:09:55 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/10/06, Marco Costalba <mcostalba@gmail.com> wrote:
> On 12/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> void DataLoader::on_timeout() {
>
>         if (canceling)
>                 deleteLater();
>

Of course is

	if (canceling) {
		deleteLater();
		return;
	}

