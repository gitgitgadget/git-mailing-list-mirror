From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 16:08:47 -0500
Message-ID: <20120417210847.GA23492@burratino>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
 <20120415213718.GB5813@burratino>
 <20120416221531.GA2299@goldbirke>
 <CAMP44s2N9wFg5kx7jw2w6G6BQ1riX-W9cKt8kBPaofugm0OV1g@mail.gmail.com>
 <7vty0inys6.fsf@alter.siamese.dyndns.org>
 <CAMP44s1sj27U_s3Y3nLL6pkMrPMVvTo982c85x-hH5szvprK0g@mail.gmail.com>
 <7v4nsins1j.fsf@alter.siamese.dyndns.org>
 <CAMP44s0w40ViecQsF8AeQLLxAEShC54TTyvcPVMabpOZ+DYDqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 23:09:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKFe5-0008Kv-00
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 23:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab2DQVI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 17:08:59 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44874 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab2DQVI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 17:08:58 -0400
Received: by yhmm54 with SMTP id m54so3363556yhm.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eU59N31LDNrnjGvefROwdoS4NZd9H+QwTeFN2tbG3yg=;
        b=caJ39stuyfT9Zsn7VIpW8OQwt9FUwJ229w+Dagxx9/wQxzJyAHI+jWYRaI4PfgZPKE
         vDVX9seddUP7KzMOFhClYt8Z/NdtYFD8PHeflk1i+pRzxIGyDSUJwLsoQiltJ9NVF8Sr
         hcK2ji3BQja/V4Muxmwc/qJNDsf+dkkHYU6FesOYdpBJFV/bbOPaow0o8B6yvGCTzJqr
         S0RD+R7gyCr1WjPYMy7QZAY8JYW66xX0nhdM3ZVxWqAwbvXHbp/cxSFWT1tfJIIqQRk8
         yFrZZaKxH7LO+fNsxkxpURuDUWw+iRiYcTE77JMDNMj7RZP7L02p6c0aDnHfdNvvjYxh
         wSEw==
Received: by 10.50.46.198 with SMTP id x6mr10841918igm.44.1334696937994;
        Tue, 17 Apr 2012 14:08:57 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id en3sm37388901igc.2.2012.04.17.14.08.56
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 14:08:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s0w40ViecQsF8AeQLLxAEShC54TTyvcPVMabpOZ+DYDqQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195808>

Felipe Contreras wrote:

> How are people going to distinguish between public and private functions?

There are only two public functions.

They will be the ones provided without an __ (git_ps1 and
git_complete) when you source the git-prompt-and-completion-helpers
library in your .bashrc.  Neither will be exposed automatically from
the completion script, though synonyms with leading __ to avoid
namespace clashes will be.

Sensible?
Jonathan
