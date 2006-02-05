From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit-1.1rc3
Date: Sun, 5 Feb 2006 07:55:30 +0100
Message-ID: <e5bfff550602042255o4b8a987did4f709663b72239e@mail.gmail.com>
References: <e5bfff550602041534k4ffa1fcarfd12b347bdbc0902@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Feb 05 07:55:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5doC-0003QY-Vq
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 07:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWBEGzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 01:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWBEGzc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 01:55:32 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:6631 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964899AbWBEGzb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 01:55:31 -0500
Received: by wproxy.gmail.com with SMTP id i23so879474wra
        for <git@vger.kernel.org>; Sat, 04 Feb 2006 22:55:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QBd3oPBlvgDcIbnvgU4Dkiq4Ahz19NF46swz6Ucee1m7ZNawuSj8P5hOQe5Dlkpe/IfgHST0qQmzFwfw4lioZv7n9aKLfWuPZJSwwejv2LRGaPICjKnwAfvfkCw6u8V4mmespigjeY858HK6jdiLLrGUhrYcVtJku6uGtHdD1VM=
Received: by 10.64.209.15 with SMTP id h15mr77518qbg;
        Sat, 04 Feb 2006 22:55:30 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Sat, 4 Feb 2006 22:55:30 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <e5bfff550602041534k4ffa1fcarfd12b347bdbc0902@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15625>

On 2/5/06, Marco Costalba <mcostalba@gmail.com> wrote:
> This release is mainly about the new build system, based on auto tools
> instead of scons (courtesy of Pavel Roskin).
>
> To install now use ./configure + make + make install-strip
> Or check the README for detailed information.
>

When downloading from git repository you may need to run _before_

                        autoreconf -i

to crete the configure file.


Marco
