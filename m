From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 01/11] svn-fe: add man target to Makefile
Date: Sun, 24 Jul 2011 14:52:00 +0200
Message-ID: <20110724125200.GA2934@elie.dc0b.debconf.org>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
 <1310559673-5026-2-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 14:52:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkyAa-0006gM-VN
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 14:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab1GXMwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 08:52:12 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:50222 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab1GXMwL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 08:52:11 -0400
Received: by fxd18 with SMTP id 18so7564217fxd.11
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UCt/XSQhUOendS/pZ9iWi4YpiwyKJO+fGAya6ktEpnI=;
        b=JElVh7/Dq4gxS9UfRYmmbjvY2BUOgoxq5uh2YDgs2OQroFgF2qpjDLyhvnnsRmtzpH
         rIuHY7SAIZ/dULaOyJkeAdXlqd5rHSRm9eQ0zr4W3CyQ2uVZul4tC3V7X+Tnhf6PcUV2
         U5LvQfCYnpaZLD0DLi9l78QdPraBEoH/IPHy0=
Received: by 10.223.144.66 with SMTP id y2mr909308fau.0.1311511930036;
        Sun, 24 Jul 2011 05:52:10 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id p17sm3186510fak.1.2011.07.24.05.52.06
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 05:52:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310559673-5026-2-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177742>

Hi Dmitry,

Dmitry Ivankov wrote:

> There already is a svn-fe.1 target. But 'man' being a standard
> target is easier to discover or type. It can also be reused if
> more manpages arise here.

This will make life a little easier when wanting to test-build
git-remote-svn.1 along with svn-fe.1 (once git-remote-svn exists).
Thanks, queued.
