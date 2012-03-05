From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-gui: typo in git translation files
Date: Mon, 5 Mar 2012 17:33:27 -0600
Message-ID: <20120305233327.GA1360@burratino>
References: <4F553CE5.4040708@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	Jiang Xin <worldhello.net@gmail.com>
To: Benjamin Kerensa <bkerensa@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4hPb-0004Rh-BO
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 00:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870Ab2CEXdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 18:33:46 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62683 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757767Ab2CEXdp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 18:33:45 -0500
Received: by iagz16 with SMTP id z16so6192751iag.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 15:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=G+xbSXnteIeIlmA+ayTJzvt0EzxAPSW3qPxEYyj1EF8=;
        b=ezJFLc19pCol1udEY5Y7YCj1oQ8yhzB7wKmNS02v+r7BZCLKy06DDYdkuFyrvsHZ2l
         gFLw56sbDj686NsDQtMTq4RNHIQyOJpuEkE3dAbOmUMCYxmQlAHs0RWG/BHpRovAUTtM
         OOTr0gtiDR1IzZKWpHFjTfLi92MhSTlbT9QYuMf1CJg4NwKAQ//qov5duyeBRvCmd89F
         mBMNyl2OZpUAWnT9YB1OVwr6FbQzOHdGtlff0kxhbdxVTQP/FkoV6QzE0vVdkXdgXH5y
         XZt968oniQDZDlwXVyFSCRhtoGBrx5oCiGMX5sFnoT/EkslhqpZqJsHrqeGAt8FNSxS2
         zwnA==
Received: by 10.50.76.163 with SMTP id l3mr7364162igw.10.1330990425283;
        Mon, 05 Mar 2012 15:33:45 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id hz3sm12840236igc.6.2012.03.05.15.33.44
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Mar 2012 15:33:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F553CE5.4040708@ubuntu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192289>

Hi,

Benjamin Kerensa wrote:

> "Generation succeded, but no keys found."
> should be "succeeded"

This typo in git-gui/lib/sshkey.tcl was fixed in v1.7.9-rc0~75^2~10
(git-gui: fix spelling error in sshkey.tcl, 2011-10-30), but the
translation template has not been updated since January of the year
before that.

Pat, would it be a good moment to update the translation template
and call for translations?

Benjamin, the git-gui code can be found at
<git://repo.or.cz/git-gui.git>, in case you want to tackle it.

Thanks and hope that helps,
Jonathan
