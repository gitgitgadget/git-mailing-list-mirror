From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 4/6] Improve error message for git-filter-branch
Date: Thu, 19 Feb 2009 09:44:18 +0100
Message-ID: <bd6139dc0902190044x623a9159p473278374df31c8d@mail.gmail.com>
References: <200902190736.35364.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 09:45:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La4XV-0006yg-3T
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 09:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbZBSIoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 03:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753207AbZBSIoU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 03:44:20 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:2432 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbZBSIoT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 03:44:19 -0500
Received: by fk-out-0910.google.com with SMTP id f33so241245fkf.5
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 00:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=1Od69OqPh/xmWGir8D+ZR0D85rcDDN3P5lZ5HZ60Cdk=;
        b=NY4SJ2CogV5FKfdOO5wCuAoMqRZnHkkAYjP1lF4CigrtdrqcvCWcI5x3FJvCexYN5T
         c865ZlpSMu3ypxv+bl1QBClyo1zMaspOygNmwoghC+5o+WsInXEKUugr22MitdeYcyFB
         uo5SakHn4SU9VidjxzZ7x/Du776rPLYcNQPcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=VknPLqcFpe9N/e/xrTbbmKmP3ITSQ7EQD39gzfmc+lynHP1zNhcAmhuwlje/ln6CuH
         o2mONUP/lx/xiCSw2sESf2xWKPE1680Q4Fa5hDJPFsE5BEX0qcQuaczR24v8nM0TyByu
         JPzUq/RjxRBSzsw0momamrykfINJeVMkMcAXY=
Received: by 10.181.145.6 with SMTP id x6mr1058239bkn.94.1235033058095; Thu, 
	19 Feb 2009 00:44:18 -0800 (PST)
In-Reply-To: <200902190736.35364.johnflux@gmail.com>
X-Google-Sender-Auth: 0c98e0eaa4603f69
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110647>

Heya,

On Thu, Feb 19, 2009 at 08:36, John Tapsell <johnflux@gmail.com> wrote:
> Tell the user that a backup (original) already exists, and how to solve
> this problem (with -f option)

Very helpful, I like it :)! Although perhaps s/Cannot backup/Cannot
create a new backup/ ?

-- 
Cheers,

Sverre Rabbelier
