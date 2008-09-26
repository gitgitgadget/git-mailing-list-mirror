From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit] Some suggestion
Date: Fri, 26 Sep 2008 12:37:39 +0200
Message-ID: <e5bfff550809260337o1523995ele3333c0de9295393@mail.gmail.com>
References: <gbak2u$v9b$1@ger.gmane.org>
	 <7FD1F85C96D70C4A89DA1DF7667EAE96079EDF@zch01exm23.fsl.freescale.net>
	 <e5bfff550809250451q578b8e10r75c043d307a63f28@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE96079FBB@zch01exm23.fsl.freescale.net>
	 <e5bfff550809250934l47c48440m332764491ff5391@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9607A00A@zch01exm23.fsl.freescale.net>
	 <e5bfff550809252215v72bb4633s17b5c1a8c39f55ff@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9607A0D9@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Li Frank-B20596" <Frank.Li@freescale.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:39:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjAit-0002ZP-Pl
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 12:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbYIZKhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 06:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbYIZKhm
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 06:37:42 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:8360 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbYIZKhl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 06:37:41 -0400
Received: by fk-out-0910.google.com with SMTP id 18so852928fkq.5
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2fC5fJYjMGRqbzgYs4mngDpaa8+9buTW9/suAmnOP0o=;
        b=u6Jca+G98BlFrJzscbxKlGEYX3ZLYp6CNLCzbcTNHxMRRAVtS5LUlcMA0Iahj2PlJF
         vPtqP0B0rwnYEixeuEpYh9iQ6x6fHEaorgHMQ4u2ez3852TW+DjKlnaisQbrRfz8hCAe
         t7eDZAX5y8+HMCaenLK03qHXkr7OzL/c5/DJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=O7LB3OMXH9BO+EipJeHsCduuXjVXbapvydlQyQtQ8G8NG2CWwSt20aOCOQG8Z2AWhv
         vhPXPe9ZzTZAcxPAiysaoFjv/aCwP3Gi3e8hIcGCtt8FwkCIOGG0tR8SWKxiz/8X4HYg
         JqlFF8uRU3+7YNUbBft+rOqQRPkkmMJNxlX8w=
Received: by 10.180.250.5 with SMTP id x5mr569898bkh.71.1222425459607;
        Fri, 26 Sep 2008 03:37:39 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Fri, 26 Sep 2008 03:37:39 -0700 (PDT)
In-Reply-To: <7FD1F85C96D70C4A89DA1DF7667EAE9607A0D9@zch01exm23.fsl.freescale.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96844>

On Fri, Sep 26, 2008 at 7:43 AM, Li Frank-B20596 <Frank.Li@freescale.com> wrote:
>
> I have some suggestions.
>        Option 1: Change "Rev List" to "Rev List Filtered"

This is the more correct but we don't have the space to write on what
files it is filtering


>        Option 2: Change "Short Log"  to "Short Log Filter On
> <Lib/blame.tcl>"

This is less correct because short log has nothing to do with
filtering, but here there is more space...


>        Option 3: Add bar between tab and list, show current filter
> information
>

Too complicated and space wasteful IMO.

Marco
