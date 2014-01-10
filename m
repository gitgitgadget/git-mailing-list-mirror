From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work
Date: Fri, 10 Jan 2014 12:19:57 -0800
Message-ID: <20140110201957.GJ4776@google.com>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jan 10 21:20:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1iYq-0005Qt-1X
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 21:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987AbaAJUUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 15:20:01 -0500
Received: from mail-gg0-f179.google.com ([209.85.161.179]:34958 "EHLO
	mail-gg0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbaAJUUA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 15:20:00 -0500
Received: by mail-gg0-f179.google.com with SMTP id e5so344775ggh.10
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9znke24mCpdDJEvaJS2TaJk6+Pa/durY+/2bHDosxZA=;
        b=BpeYBAaicw3KgIYSyvNgax75ZLM/Yx5IHOIbUeAVmafG9Ww9nLyaasf1GqRoRyN2t1
         zhJ0J22oFeys+pjlgcPlu8gMLt/zkmJuzqVpEKWEGrt5TSDQVuPc3VMhCPc4tKbxxARX
         ZN8M8/A5TZbS8QqMqya4qKHAMojytEdF1dxc8r7jKfBVkaSyOq+YifnG3puCTPpeDu2p
         dp35lePCtXk1NqKF+fc5WzQNdDmMtIWf5fvrSIoaYuUTjPPVw9PhByqr1s7EHzm2cBBd
         tyFplSA9ad+HuuVtIY8E2Ieg6brfu9gkc0tfMGi1Nxd+Lk1n6T4AZpDZzl+xrwU+IXju
         cEqQ==
X-Received: by 10.236.60.70 with SMTP id t46mr2670672yhc.117.1389385200052;
        Fri, 10 Jan 2014 12:20:00 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id z7sm13214270yha.14.2014.01.10.12.19.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jan 2014 12:19:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240316>

Hi,

Philip Oakley wrote:

> The "Everyday GIT With 20 Commands Or So" guide is not accessible
> via the git help system. Fix that.

Neat. :)

Junio covered everything I'd want to say about patch 1/6.

After fixing that, I'd suggest squashing all 6 patches into a single
patch.  They all are part of accomplishing the same task, they are not
too hard to read together, and the intermediate state after applying a
few but not the rest doesn't make much sense.  The details of patches
2-6/6 look good to me.

Alternatively, this could be two patches:

 1 - modify everyday.txt in place to be a suitable manpage
 2 - rename it, add a placeholder for the old name, and modify the
     build rules to treat it as an actual manpage

Hope that helps,
Jonathan
