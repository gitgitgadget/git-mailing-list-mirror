From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git diff with add/modified codes
Date: Fri, 27 Jul 2007 20:54:57 -0400
Message-ID: <9e4733910707271754u3f18f2fdrf508068879acb778@mail.gmail.com>
References: <9e4733910707271505x4eac928axe639308afed20cb3@mail.gmail.com>
	 <7vir85whxy.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0707280148340.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 02:55:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEaaE-0000dL-Os
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 02:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbXG1AzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 20:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938464AbXG1Ay7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 20:54:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:31163 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938425AbXG1Ay6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 20:54:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1098519wah
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 17:54:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VcN3Bw5I7Vz6gEc7lSPwZH2U+w/nY6fTgxxaaY+PYnHyy0QCC+e04d16ghvovS9PusmQbnw6IluD5VlW7h97QM3vWK6mxo3Zhl9FXYpMiXUTIg+VMU1SbKNq2gvvz4JpLic5+54zsmNZ7DhCSHb/hFmyMZUDRdTtr+bOLN6+5Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ELQJpc/8OTqFijzvNGEsIpllBCGvsnINrUhmCpFW7N/VaNa2hEXEj2rTAv9qhwAR9Rxr6Ieyx+lBBbv8WD+8UzdFGYAnsKRS+EyzhQyLphJe+8/DXmS5d9RJhiDr93ZbELi6Qoo/b7U6RAXXXSEt1jJMpBNfhtwIo1WoyKvRh/E=
Received: by 10.114.94.1 with SMTP id r1mr3464797wab.1185584097993;
        Fri, 27 Jul 2007 17:54:57 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Fri, 27 Jul 2007 17:54:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707280148340.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53983>

On 7/27/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 27 Jul 2007, Junio C Hamano wrote:
>
> > Would --stat --summary be satisfactory?
>
> Or does "--raw" do the job?

Raw is much closer. Combine the file stats from --raw with --stat and
it would be perfect.

>
> Ciao,
> Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
