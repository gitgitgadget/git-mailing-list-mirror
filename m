From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Fri, 12 Jan 2007 09:40:41 -0500
Message-ID: <118833cc0701120640o3cae8c14t5b5ba6ee6f022b53@mail.gmail.com>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 15:40:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5NaI-0006Nq-IA
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 15:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbXALOkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 09:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXALOkn
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 09:40:43 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:2579 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbXALOkm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 09:40:42 -0500
Received: by wx-out-0506.google.com with SMTP id h31so854364wxd
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 06:40:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dw0X/KvBKhYkIsyPs7E2TV6Rb5ytzYm0UIuSlvfVAXqA76b0pVpqDsLwPzUcD6pW8Cm1GoyQ/ex+HkZqPf+ctHOmC/wqBuQYcdc6JrbalfjI806zQS3fq1fdm5fyKOxYxjbRdl9I9LPxmlMTRTY2b/GGaabl1mq6396Rhfs59c4=
Received: by 10.90.72.10 with SMTP id u10mr554845aga.1168612841800;
        Fri, 12 Jan 2007 06:40:41 -0800 (PST)
Received: by 10.70.95.5 with HTTP; Fri, 12 Jan 2007 06:40:41 -0800 (PST)
To: "Chris Riddoch" <riddochc@gmail.com>
In-Reply-To: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36676>

I did this with a large pile of tarballs, see

    http://blogs.gnome.org/view/mortenw/2007/01/07/0

for the script.

Bottom line: git is very, very good at compressing a pile of related tarballs.
In fact, about 10x better than gzip.

(Not really surprising, of course.)
