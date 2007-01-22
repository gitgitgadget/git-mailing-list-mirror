From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-push through git protocol
Date: Mon, 22 Jan 2007 15:26:18 +1300
Message-ID: <46a038f90701211826v54340352lf4376db41ad5be37@mail.gmail.com>
References: <17843.29798.866272.414435@lisa.zopyra.com>
	 <ep00nl$mop$1@sea.gmane.org>
	 <Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
	 <17843.55730.456139.247155@lisa.zopyra.com>
	 <Pine.LNX.4.64.0701211341300.14248@woody.osdl.org>
	 <17844.5120.316805.794579@lisa.zopyra.com>
	 <Pine.LNX.4.64.0701211749140.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Bill Lear" <rael@zopyra.com>, "Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 22 03:26:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8ot9-0002yj-Gz
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 03:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbXAVC0W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 21:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbXAVC0W
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 21:26:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:16627 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbXAVC0V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 21:26:21 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1177505nfa
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 18:26:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qozJX5r+lBMsFoo5n6v6Prj9dVp1kqCRa9lRsMtKzV1y/9dcrub+4fJIYeH1siDrRUj/igfp6w0LxezztUmZuWkDHVfkAeoLaHDqEAaFyBWYTOrWlHDmqhM5GnqcKhqn3WzIDDPynLFeia45pgE6jLax81CNNitRg8Y2IaR/Yms=
Received: by 10.48.48.1 with SMTP id v1mr5976169nfv.1169432778730;
        Sun, 21 Jan 2007 18:26:18 -0800 (PST)
Received: by 10.49.35.7 with HTTP; Sun, 21 Jan 2007 18:26:18 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701211749140.14248@woody.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37387>

On 1/22/07, Linus Torvalds <torvalds@osdl.org> wrote:
> Umm. Your git daemon is probably running as "nobody", and simply doesn't
> have write permissions to the archive, does it?
>
> > % cat /etc/xinet.d/git-daemon
> > service git
> > {
> >         user            = nobody
>
> iow, I think you simply need to make sure that git-daemon will have write
> permission to the thing. Either by making the whole repository writable by
> nobody, or by running git-daemon as the proper user.

Whereby I personaly run back quickly to cover under my git-over-ssh
safety blanket.

:-)


martin
