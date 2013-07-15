From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: repo consistency under crashes and power failures?
Date: Mon, 15 Jul 2013 10:51:42 -0700
Message-ID: <20130715175142.GC14690@google.com>
References: <rmiy597iujc.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 19:51:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UymwA-0002N5-Le
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab3GORvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:51:47 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:60968 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab3GORvq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:51:46 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so11556092pbc.12
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=meKHFH74ibBAMry/sLBy2CYY33eOaWoHy7Rdar8O6Ao=;
        b=E601NMRDz9BZ+HLX5PLzf7ETIeagTU5jK++BuOvvTfua62kNbEPvnuTF1TVozux1r3
         VOoCNJfhSd+dcvilxz/ADEGnCDd8bTHoLERG8mIor4ouKI7c78fp9eGarBZeY5vkdMEN
         m2E2u5sWiT5zsxBBx9A+CktyR0J4wN0Zrgyre8WH96WWj+Us4SFMvXy44FyJCZP0FIj1
         Tp3yKx7cX/XdFpULL0o8hgVbXNgn19ELxr3bHfHD5bVLVZf5JmYmk/zYSyYIWEuovb+/
         21zgsxPBfXTO/mWCDYOMZZwthqRCRnLa6Ru26+I4ArR5H6QodfIaeww9wQGKbKyUXl2G
         cmpQ==
X-Received: by 10.68.198.65 with SMTP id ja1mr54870132pbc.175.1373910705777;
        Mon, 15 Jul 2013 10:51:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id om2sm62059385pbb.34.2013.07.15.10.51.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 10:51:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <rmiy597iujc.fsf@fnord.ir.bbn.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230499>

Greg Troxel wrote:

> Alternatively, is there somewhere a first-principles analysis vs POSIX
> specs (such as fsyncing object files before updating refs to point to
> them, which I realize has performance negatives)?

You might be interested in the 'core.fsyncobjectfiles' setting.
git-config(1) has details.

Thanks and hope that helps,
Jonathan
