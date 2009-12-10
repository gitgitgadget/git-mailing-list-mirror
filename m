From: Jay Soffian <jaysoffian@gmail.com>
Subject: How to selectively recreate merge state?
Date: Thu, 10 Dec 2009 15:56:05 -0800
Message-ID: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:56:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIsrj-0000Hf-Sj
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 00:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758370AbZLJXz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 18:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758016AbZLJXz7
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 18:55:59 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:61775 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758005AbZLJXz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 18:55:58 -0500
Received: by iwn1 with SMTP id 1so76684iwn.33
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 15:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=ByE4lmlXj6n84W9cT0qklXnK29OtqiN9pjVsfb7kJAU=;
        b=m5V31L5xy87bHxsq4tid+fC6xAQ9aAleR0hhtzxAab2ln0zoB1eG25G7Vp5DHLNQCt
         VTEfMib86h867rTTPBaCqL6jfGQJs8ww0fGQCYR6/tNE3J7CcM5yTkPPesQinH5HSWPM
         vNxoEKyihof9lsduufRCAiV9Prv1L45M+ZUSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=haNRG0/3rxB/KVQQMAgkS8ZASRfvIzlYBdTjlGAG4QEz1aZzE7wU1ea4ncrd3Li38s
         RxR+umFDGx7+WWsibZZmy3o1qwuvRJWc55EJ97fY5MaWvILQKpzLq4uv0cfIdzXTX3yT
         UfJjzNDbz5HwlIdEtb1bYZ+Cl5SSzs6bX4eEQ=
Received: by 10.231.121.93 with SMTP id g29mr511550ibr.13.1260489365245; Thu, 
	10 Dec 2009 15:56:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135059>

Let's say you initiate a merge:

$ git merge topic

And this merge results in conflicts in two files, foo and bar. You
resolve the conflicts in both files, but then decide you don't like
how you resolved bar.

How do you set the index and working-copy back to the state it was
immediately after doing the merge for bar, while leaving the merge
resolution alone for foo?

j.
