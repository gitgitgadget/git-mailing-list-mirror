From: "Dilip M" <dilipm79@gmail.com>
Subject: Re: gitk doesn't work w/o sudo.
Date: Mon, 19 Jan 2009 21:05:02 +0530
Message-ID: <c94f8e120901190735j572f4fc6la30c820257603a98@mail.gmail.com>
References: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>
	 <20090119144836.GD5625@jabba.hq.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Jing Xue" <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 16:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOwIK-0002M8-Kh
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 16:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbZASPmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 10:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbZASPmn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 10:42:43 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:25590 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbZASPmn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 10:42:43 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1258197yxm.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 07:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rhga3dXRbKS7dqtj0wZ31Lj0x+RgcvXIv5i0hY1cJeM=;
        b=trs73BAypdliuYmVCCb8H/YicAEYJE+aGQUWgp0dC0oGK2ohxUCdvg6tlE9aQM8NNa
         0n6jAuJeHuxVRimZbHpvGNmUyV9GD7F1CJVNrisDulg7UybjQ6IErJv/oiY2Ux//FZPF
         I4c7Gu23odaWy5RyAJn7mHQkWmi7RZkSrpIsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Fwy5rlqP4yRjUK4darZtbetvhlJ6bRZVwts7vjB6WieFddqc3/CSioHLp24d6/3w5X
         o11vN+awHm/XjcruI5rPbAEbDUKUg9kBIEF0KUY0FZggQ7ikslz5oMNfH239aIWP+0W6
         ByFvldCvPkoUDhJqGW9ZP0JmCEwyGz5oSzl8Q=
Received: by 10.100.32.6 with SMTP id f6mr3979072anf.90.1232379302662;
        Mon, 19 Jan 2009 07:35:02 -0800 (PST)
Received: by 10.100.128.10 with HTTP; Mon, 19 Jan 2009 07:35:02 -0800 (PST)
In-Reply-To: <20090119144836.GD5625@jabba.hq.digizenstudio.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106365>

On Mon, Jan 19, 2009 at 8:18 PM, Jing Xue <jingxue@digizenstudio.com> wrote:
> On Mon, Jan 19, 2009 at 03:46:41PM +0530, Dilip M wrote:
>> Hi,
>>
>> ..I recently install GIT on Ubuntu (hardy) box....I am able to use
>> 'gitk' only If I do 'sudo'. Without 'sudo' it complains 'repository
>> not found'
>
> Do you have a 0027 umask?
>
> http://www.digizenstudio.com/blog/2008/11/09/weird-git-gui-startup-problem/

Mine is dm-laptop:~> umask
22

So, that's not a issue.

-- DM
