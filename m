From: Bond <jamesbond.2k.g@gmail.com>
Subject: using git with Google Code
Date: Thu, 25 Nov 2010 20:22:10 +0530
Message-ID: <AANLkTiksVbmUX9QE6B385UjboqcvgAo+mwKP_X--P+83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 25 15:52:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLdBL-00036N-Nh
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 15:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab0KYOwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 09:52:14 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50609 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab0KYOwN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 09:52:13 -0500
Received: by ywl5 with SMTP id 5so492683ywl.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 06:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=XF12aJC5L7ZaVLvYFkP9I0ytSvCfitAqXss6XjSz3yE=;
        b=OSPmIFosG74E+DeuaTOcdJXiNsB7iUeQ7k31zERcupjVkxrY9AaUysuYcN3HmfOPm5
         sl9pUIMKUqERuy95MpBG9BRV9KppQgJ+V3RdrCZF47L6bot7Bdhc/VgGDfn0f8MW7PRB
         totDhsJdHvzCgJhSHc+6PeChzygD+or6H/ChQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ApCLOReK6dYuoILk9K7v4VT1qAx1pWil5PF2OGkjhVbBetxGGVS/iWYcChlOJD1Vx2
         LyQhY0vrFkI7iTSZiXQFslmn9tHUq/pers4H26hwAcEZVW4ByIgxzadStX09dEPZqhVi
         68K7C+J9ueMC2lmhTiKWlc12hAauBOsiOds3I=
Received: by 10.42.176.133 with SMTP id be5mr256391icb.487.1290696731162; Thu,
 25 Nov 2010 06:52:11 -0800 (PST)
Received: by 10.42.167.69 with HTTP; Thu, 25 Nov 2010 06:52:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162132>

Ok by now I have wasted a couple of hours.Scratching my head and
searching for information reading blogs documents etc etc.Finally I
decided to create this thread.
I decided to put my programs on Google Code and since  I found git to
be a popular thing I decided to use it.
 I want to host my codes as
http://code.google.com/p/something/
On my local machine I have a folder named bond which I want to commit
to above url.
I have checked
http://flashsim.wordpress.com/category/google-code/
the guy seems to be quite frustrated with git.
Google gives a link to read a doc
http://hgbook.red-bean.com/read/file-names-and-pattern-matching.html
read it completely and this actually did not helped me a bit.
In the comments section of following link
http://google-opensource.blogspot.com/2008/05/develop-with-git-on-google-code-project.html
I get a URL
http://linuxsagas.wordpress.com/2009/06/05/adding-a-project-to-git-and-google-code/
this guy seems reasonably mature to write how to begin.

So now in my directory I go and here are the steps which till now I have done.
mkdir st/bond
cp -r $HOME/st/*.c $HOME/st/bond
cd bond
git init
git commit -m "Initial Release Candidate"[/code]

and then I do

git svn clone --username me  https://myproject.googlecode.com/svn/trunk
git: 'svn' is not a git command. See 'git --help'.

Did you mean one of these?
	fsck
	show


Now what do I do to get rid of above message.I have been searching all
across internet and I have not found correct thing with respect to my
question.
