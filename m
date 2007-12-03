From: "Ollie Wild" <aaw@google.com>
Subject: Re: git-svn: .git/svn disk usage
Date: Mon, 3 Dec 2007 09:35:22 -0800
Message-ID: <65dd6fd50712030935p242895fvc2e4576448868403@mail.gmail.com>
References: <65dd6fd50712022217l5f807f31pf3f00d82c3dccf5c@mail.gmail.com>
	 <4753A43F.9060303@obry.net> <20071203064603.GA18583@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Pascal Obry" <pascal@obry.net>, "Ollie Wild" <aaw@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 18:35:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFCs-0007o4-SY
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 18:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbXLCRf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 12:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbXLCRf1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 12:35:27 -0500
Received: from smtp-out.google.com ([216.239.45.13]:36695 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbXLCRf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 12:35:26 -0500
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id lB3HZOO9014729
	for <git@vger.kernel.org>; Mon, 3 Dec 2007 09:35:24 -0800
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=noGvuUaW8bPZ/csdlmwb/ctLbMYqGFviHi0Z8svkstTvo9VT/6fayP0goUKSD4G3k
	2WayD7e4L0biY6cOLXtZg==
Received: from py-out-1112.google.com (pyia25.prod.google.com [10.34.253.25])
	by zps37.corp.google.com with ESMTP id lB3HY7Sa019192
	for <git@vger.kernel.org>; Mon, 3 Dec 2007 09:35:24 -0800
Received: by py-out-1112.google.com with SMTP id a25so7260008pyi
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 09:35:23 -0800 (PST)
Received: by 10.35.128.1 with SMTP id f1mr785259pyn.1196703323661;
        Mon, 03 Dec 2007 09:35:23 -0800 (PST)
Received: by 10.35.106.4 with HTTP; Mon, 3 Dec 2007 09:35:22 -0800 (PST)
In-Reply-To: <20071203064603.GA18583@old.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66931>

On Dec 2, 2007 10:46 PM, David Brown <git@davidb.org> wrote:
>
> Ollie, if you look in these svn branch directories, is most of the space
> taken up with files called 'index'?

I'm seeing the following breakdown:

4.3G index
77M  unhandled.log
5.5G .rev_db.138bc75d-0d04-0410-961f-82ee72b054a4

What exactly are the index and .rev_db files used for?

Ollie
