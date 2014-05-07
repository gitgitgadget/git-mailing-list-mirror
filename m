From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Wed, 07 May 2014 14:54:20 -0500
Message-ID: <536a8f6cd81e9_76ff7a52ec60@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
 <rmiha51dd99.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:05:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi85c-0003Tp-03
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbaEGUFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:05:12 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:61264 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaEGUFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:05:10 -0400
Received: by mail-ob0-f181.google.com with SMTP id wm4so1872281obc.12
        for <git@vger.kernel.org>; Wed, 07 May 2014 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=WnQo99prXMXa7IZvsuDXtV8dfz1oLdvfhrcxVlOjiP0=;
        b=KLZaV6EEP/jjntYN1PjRmRCcsMNMlluwrkayRTrO0b9T19A9k6z4x9d1Ev/NNVLqeH
         C5RBsF4NgzI8h6fWPQD/bMpa9QbcKzt6lIHTBmGmf3e7b8dZwKtDG+5HiKQczCP9bfXN
         Hz0xp8e7vMki+3lDUtxFJeiXcvL6DqvBCyIeZO+BlnYo9Hv/R46cEojVN78cCDl5EHzG
         nQmuBBpJ0mOk1Pgy9p5BAOLs+Z8a8mrWohVslTQRGy2+kxwvc3/VVs/YqKxEyatnPcWM
         lAt0bTCYzzqnIuhO11YtZUFJ7/CdjijLwZvH1r9khDXQGWjvfyvDhFgBOYXBlTUrdPEd
         /6Dg==
X-Received: by 10.182.117.195 with SMTP id kg3mr47022370obb.17.1399493110198;
        Wed, 07 May 2014 13:05:10 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm70042458oeb.3.2014.05.07.13.05.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 13:05:06 -0700 (PDT)
In-Reply-To: <rmiha51dd99.fsf@fnord.ir.bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248354>

Greg Troxel wrote:
> In a packaging system, dependencies are much more troublesome.
> Dependencies have to be declared, and the build limited to use only
> those declared dependencies, in order to get repeatable builds and
> binary packages that can be used on other systems.  Dependencies that
> really are required are fine.  But optional dependencies are a
> problem, because e.g. one doesn't want to require the presence of qt
> to build something (that isn't already enormous).   So if git needs
> mercurial and subversion installed, plus perhaps 5 other things for
> less popular remote helpers, that starts to be a real burden.

It doesn't *need* them to build. The Mercurial/Bazaar dependencies are
optional, both at build-time and at run-time. Most distributions would
want to test the functionality they are distributing, and for testing
they do need these dependencies.

-- 
Felipe Contreras
