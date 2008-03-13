From: Thomas Harning <harningt@gmail.com>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 15:15:32 -0400
Message-ID: <20080313151532.20d72b14@gmail.com>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com>
	<51ED164C-2269-48B7-B8C9-0E819BFD63EC@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 20:17:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZsvZ-0003DA-6o
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 20:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276AbYCMTQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 15:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757260AbYCMTQL
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 15:16:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:48087 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755716AbYCMTQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 15:16:09 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3867515wxd.4
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 12:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=uX1V8HOWEafMfZ0MngMWeFfYUsl51UAcytFgAe/z36o=;
        b=aWiaQ9JjZ9DEQM41MdrFnpxuQ6wOD+XMb5eBcbyem3YfkL6ljQxmvQd931aVzL1R0Hh4yxNl9lkIDH1rR7id+UUabF2yFE/evkuF9ABUNh//7hyjdk+iMSrsozc/ildbZdwtTf9esIYZkd57T6UzTE2IoCb2SVD0lbFfyRyek7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=jhBtjmOXQ/IjJkN60d6YHOjdcM2+GwtXGeDvEEz8cZqkVAtCVnbZIdd8pymKRAGZDOdqxhB81jyVKJGdYIpm9B1NQ1bxXG75Rn76CMFE2xgOxGkB1PCUMVguTFMBxLZpthhpf89HbPicQuskOV8oemU/I4YF8i8OPZw2PqGS3c4=
Received: by 10.64.10.2 with SMTP id 2mr20813626qbj.56.1205435768010;
        Thu, 13 Mar 2008 12:16:08 -0700 (PDT)
Received: from localhost ( [149.164.193.61])
        by mx.google.com with ESMTPS id e14sm13541662qbe.24.2008.03.13.12.16.06
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Mar 2008 12:16:07 -0700 (PDT)
In-Reply-To: <51ED164C-2269-48B7-B8C9-0E819BFD63EC@vicaya.com>
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.10.11; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77131>

On Thu, 13 Mar 2008 11:36:46 -0700
Luke Lu <git@vicaya.com> wrote:

> An obvious and easy solution: use an encrypted partition on the  
> remote server and ssh as transport. Last time I checked, git on  
> encrypted volumes is plenty fast.

If its an encrypted partition on the remote server... then its visible
@ that server.. which I don't think is desired in the situation.

An encrypted partition is fairly useless on a remote server unless the
remote server is expected to be physically removed/powered down...
otherwise anything can get into that data while its alive (pending
permissions, lack-of-holes, etc..)

The encfs solution makes sure that nothing is ever revealed
remote-side... all data is prevented from even going over ssh in its
unencrypted form.
