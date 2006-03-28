From: "Tony Luck" <tony.luck@intel.com>
Subject: Re: Cherry-pick particular object
Date: Tue, 28 Mar 2006 13:38:13 -0800
Message-ID: <12c511ca0603281338q503638bfo66fa0a5da19942e2@mail.gmail.com>
References: <20060328113107.20ab4c21.sebastien@xprima.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 23:38:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOLtS-0004NX-9L
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 23:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWC1ViY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 16:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWC1ViX
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 16:38:23 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:17796 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932227AbWC1ViX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 16:38:23 -0500
Received: by zproxy.gmail.com with SMTP id m22so29667nzf
        for <git@vger.kernel.org>; Tue, 28 Mar 2006 13:38:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KGlIsgcGKiY1hR8P2Io/uerdem2xZW2yU7Umv8SWsFlZaSMQbnJx2dcpkiIA5Wr9TgkU5jwhdU5h9e2QsHXHK9jSqBBiyJmc+wom1LUpnzwAz3pgbznS6eMO2JM63qDYVbLZ0EEfsWJ1o3izsdJ7kv12EdZBinFuhzSa41Yz5PM=
Received: by 10.65.239.5 with SMTP id q5mr19584qbr;
        Tue, 28 Mar 2006 13:38:13 -0800 (PST)
Received: by 10.64.27.14 with HTTP; Tue, 28 Mar 2006 13:38:13 -0800 (PST)
To: "=?ISO-8859-1?Q?S=E9bastien_Pierre?=" <sebastien@xprima.com>
In-Reply-To: <20060328113107.20ab4c21.sebastien@xprima.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18131>

> "get the file corresponding to 78132af26431e649a0f85f22dc27e5787d80700f and save it as myfile.txt"
>
> How would one properly do that with core git ?

$ git cat-file blob 78132af2643 > myfile.txt

-Tony
