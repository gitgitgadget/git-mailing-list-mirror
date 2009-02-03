From: Matt Graham <mdg149@gmail.com>
Subject: how to diff versions of a file
Date: Tue, 3 Feb 2009 00:00:51 -0500
Message-ID: <1c5969370902022100h7c03bbb6h2d9f443f877d89ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 06:02:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUDQT-0003OJ-TD
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 06:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbZBCFAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 00:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbZBCFAz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 00:00:55 -0500
Received: from mail-bw0-f12.google.com ([209.85.218.12]:44779 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbZBCFAy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 00:00:54 -0500
Received: by bwz5 with SMTP id 5so1682799bwz.13
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 21:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=I+WXfSqR9oeH+3K63aaEeogtprjPdPhQsM4Ow4afHsk=;
        b=crCxR9+dd37KlYdtkbxHOeRKNYN6DzIhw5ykQIR1yAOZgiFvNP6e07joCsrBgf6hMJ
         jHDileA047I8P96eTSQZT8QbzSBt+WE8Hk/7h7My80Xq3B2GiQ2/rq5NMSeHDsIPm2Ae
         RzHuva89PK0UwhC5UfkdmGcSWsnlq4d+3aAuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=jEbdcRPHu1kauD7tVxE4CkRW7/P1ZNvUHf+iiixs3ZN8EhBgBxIklr1ShIE3HSl7nd
         6p1EmIdjX8QgbUcB9wSbKU8j7S3+ovpW3LGXfEki3MXR2YpF27wg+6TPzUVZS+6d/c3I
         Cx+3VWjZkONfGgvKe57igDb9JRkwkmJK55F2k=
Received: by 10.223.106.200 with SMTP id y8mr1267197fao.24.1233637252280; Mon, 
	02 Feb 2009 21:00:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108146>

Hi,
I'm curious if there's a way to diff between 2 arbitrary versions of a file.

For example, how can I see the diff between tree.c on HEAD and from 3
edits (of tree.c) ago?

I can do git log and then manually use commit names to do the diff,
but I'm hoping there's a single command that will let me do that.

Thanks,
Matt
