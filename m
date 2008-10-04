From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: How to list versioned files with modification status
Date: Sat, 4 Oct 2008 23:40:03 +0200
Message-ID: <81b0412b0810041440w131647aeo9c14f55cd38da635@mail.gmail.com>
References: <20081004131256.586a5fbf@smartavionics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mark Burton" <markb@smartavionics.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 23:41:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmEsH-00027v-6v
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 23:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbYJDVkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 17:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753494AbYJDVkG
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 17:40:06 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:59347 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbYJDVkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 17:40:05 -0400
Received: by gxk9 with SMTP id 9so3828781gxk.13
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 14:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kVHiVMoFx/faWgreBNLt4YQwOrkaYSoQSpVZzymQTHQ=;
        b=AAQqohBMyfvUBvnsjZrUxqnMuhq5oOjGCvJbuZh5CeafOshQsN6HnDjx7SuPsdwpmO
         Dk0a+lieL7HVe67C3kRF5c1V4faFbgXrdNnoRyKWDnS5ovcBpGvxGPj0AEXPmbUUAn6q
         /dnM+gOA0OmDfGZz94F093uTi0i8jRv9hWyTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZQ68WIx+LDKehNTcHeruvoVJ1i+ttlR/GjQ+Qk6LgYv/ThyDG5aETUeruInq5DfQLF
         eBaHzaP183ojySI+wcWyJqH8XuNuAtffkm1OjuX6+Yqz3633dJ88inxtCdFZXqdW6/56
         Ve/zMcn4SJn+o0CyPG0kSdiawo+ia2vZKx4NU=
Received: by 10.100.154.19 with SMTP id b19mr3219594ane.98.1223156403853;
        Sat, 04 Oct 2008 14:40:03 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Sat, 4 Oct 2008 14:40:03 -0700 (PDT)
In-Reply-To: <20081004131256.586a5fbf@smartavionics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97478>

2008/10/4 Mark Burton <markb@smartavionics.com>:
> I would like to be able to easily find those files in a git tree that
> don't have pending modifications. Although ls-files can list the
> files that are modified, it can't list those that aren't or list all
> files with their modification status.

Maybe if you look at git diff and diff-index,  you will find something
what suits you better? Because "modification" is just a difference
between a known (recorded in a commit or index) state and your
working tree.
