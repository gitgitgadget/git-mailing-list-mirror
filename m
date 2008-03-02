From: "Ping Yin" <pkufranky@gmail.com>
Subject: Fwd: git diff-index --raw HEAD and git diff --raw HEAD output the same thing?
Date: Sun, 2 Mar 2008 13:22:52 +0800
Message-ID: <46dff0320803012122r7e97f486m9e4970c81455cdf6@mail.gmail.com>
References: <46dff0320803010510q67bc4101k9f85c71e5d20b4@mail.gmail.com>
	 <alpine.LSU.1.00.0803011320100.22527@racer.site>
	 <46dff0320803010545n775f1441x579a53a8c07d0892@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 06:23:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVgfa-0007At-TY
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 06:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbYCBFWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 00:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbYCBFWy
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 00:22:54 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:38921 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbYCBFWx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 00:22:53 -0500
Received: by an-out-0708.google.com with SMTP id d31so1088850and.103
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 21:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ONswNNYXqeSTa2CPuNuOM0epJb1bkDbPlAgP/UIbzdo=;
        b=H7qHP0Ok1uq+IS0VKT1F+u7KwnOb12eFelKZnl/LwgwoXncpMN+5VHwef+5P6DBi0p6rTqFv1m0IjVfSlPgVx8684hBJ4Kulut31+yJTYzJCRIz2aQ6WNGZHfaRcxNl6Pi41Kws2vy+rvSVZeZdS1/MDVP3n4mf/vmMAtwV08Co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QBF6uvttdDb1wYj0wE725XexAaMVExkdiapi8OaHBKStGscokclUqTOOdRVBlBHRJOAbbnI+bozSktkVGwiRUs2ubbN3hWT3hMr43nASbHErPTq4TAWkYdO2nD7VBeUyeDoVj13GNUJSPOeXFIO900B+wfgHNqdF2YAVRmmRJp4=
Received: by 10.100.254.18 with SMTP id b18mr25062316ani.21.1204435372573;
        Sat, 01 Mar 2008 21:22:52 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sat, 1 Mar 2008 21:22:52 -0800 (PST)
In-Reply-To: <46dff0320803010545n775f1441x579a53a8c07d0892@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75722>

Sorry i have forgotten to cc git list


---------- Forwarded message ----------
From: Ping Yin <pkufranky@gmail.com>
Date: Sat, Mar 1, 2008 at 9:45 PM
Subject: Re: git diff-index --raw HEAD and git diff --raw HEAD output
the same thing?
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>



On Sat, Mar 1, 2008 at 9:21 PM, Johannes Schindelin
 <Johannes.Schindelin@gmx.de> wrote:
 > Hi,
 >
 >
 >  On Sat, 1 Mar 2008, Ping Yin wrote:
 >
 >  > Strange things is this line
 >  > :160000 160000 34f279b1662a6bef6a8fdea1827bbdbd80f12444
 >  > 0000000000000000000000000000000000000000 M      commonmake
 >  >
 >  > why mod is 160000 while sha1 is 0000...
 >
 >  This indicates that a submodule (160000) was deleted (00000).  It is
 >  easier not to handle a deletion as mode change...
 >
 No, it isn't deleted, git diff --raw HEAD shows the right result
 And why do diff and diff-index show different result?
 $ git status
 # On branch master
 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
 #
 #       deleted:    WordBreak
 #       typechange: util
 #
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #
 #       modified:   commonmake
 >  Ciao,
 >  Dscho
 >
 >



 --
 Ping Yin
