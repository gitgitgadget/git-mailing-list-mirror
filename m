X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: updating only changed files source directory?
Date: Wed, 25 Oct 2006 15:35:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610251525060.9789@iabervon.org>
References: <ehjqgf$ggb$1@sea.gmane.org> <Pine.LNX.4.64.0610241435420.9789@iabervon.org>
 <453F517A.7060000@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 25 Oct 2006 19:35:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <453F517A.7060000@xs4all.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30095>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcoXB-0007hN-6F for gcvg-git@gmane.org; Wed, 25 Oct
 2006 21:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964813AbWJYTfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 15:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWJYTfZ
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 15:35:25 -0400
Received: from iabervon.org ([66.92.72.58]:49415 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S964817AbWJYTfZ (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 15:35:25 -0400
Received: (qmail 31496 invoked by uid 1000); 25 Oct 2006 15:35:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 25
 Oct 2006 15:35:24 -0400
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

On Wed, 25 Oct 2006, Han-Wen Nienhuys wrote:

> How can I set the object database?  I found GIT_OBJECT_DIRECTORY, but can I
> write a config file entry for that?

If you clone with --shared, it'll do the right thing automatically, which 
is to have the clone's .git/objects/info/alternates be the objects 
directory of the bare repository.

(Note that any new objects you create in the clone go into the clone's own 
objects database. This shouldn't matter for you, unless your build system 
is tagging things or something, but if you end up doing development in a 
similarly structured system, it's worth knowing that this doesn't affect 
the bare repository at all.)

> yes, this works. Thanks!

No problem. :)

	-Daniel
