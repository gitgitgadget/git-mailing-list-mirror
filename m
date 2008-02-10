From: "Derek Mahar" <derek.mahar@gmail.com>
Subject: Re: git-cvsexportcommit and commit date
Date: Sun, 10 Feb 2008 01:13:42 -0500
Message-ID: <5f4b18bf0802092213r4bd1df2ap7d2649dd9251fbb7@mail.gmail.com>
References: <OFFF18703C.5539A99A-ON852573E7.00699FE4-852573E7.006A0F3E@db.com>
	 <47AA0FD8.1050801@catalyst.net.nz>
	 <loom.20080210T033717-237@post.gmane.org>
	 <200802100645.32743.robin.rosenberg.lists@dewire.com>
	 <5f4b18bf0802092201i24f7de39o3fea28823621fdd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 07:14:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO5SF-0001OI-Bu
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 07:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbYBJGNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 01:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbYBJGNp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 01:13:45 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:41135 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbYBJGNo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 01:13:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1410545wah.23
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 22:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ix95eVuLBvtNmHvwBf79MgnRXn0cW/U9ZaPwtMeVVlw=;
        b=vZqBtZXFmPIWd87NtYbOZ60Z4JkQnZTXP7Xv7nlEqKY6g0DM6CC/a/AjEzKRP3TLh6lhrqFnt6nLzzHrldrV0Oooppt5kyoIJ8woKGVk0B8wrzflqDncoJwSDXt0z+EOLePeYblLVVfrexXm4iW/QDSywrF/i0Tr4KZ8lP9qPNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q1xFIJDHvEvl/lAPL7CI0RYJC4NyM1HdY8TfO8LQPMI2wyp8U7M8uHKZwZ9HWb5NnVm8PUSMtGDlC4ygKd6b2BGoeqpvT9siulDgJD2ukIoZ9JwF+o+GVhvosURWeoIhhhmCISMceGB5mx5QhKTzFS4d9RkQmJHImNQePtU758w=
Received: by 10.142.157.15 with SMTP id f15mr7672172wfe.22.1202624022527;
        Sat, 09 Feb 2008 22:13:42 -0800 (PST)
Received: by 10.142.177.13 with HTTP; Sat, 9 Feb 2008 22:13:42 -0800 (PST)
In-Reply-To: <5f4b18bf0802092201i24f7de39o3fea28823621fdd1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73319>

On Feb 10, 2008 1:01 AM, Derek Mahar <derek.mahar@gmail.com> wrote:
> On Feb 10, 2008 12:45 AM, Robin Rosenberg
> <robin.rosenberg.lists@dewire.com> wrote:
> > git rebase will drop those "empty" commits by default and you'll end up with the
> > cvs-imported version.
>
> How do I perform this rebase if the empty commit is on the same
> branch, say the master branch, as the original CVS landed commit?  I
> attempted such a git-rebase using 1.5.4, but, iirc, git-rebase
> responded that the branch was already up-to-date.

On second thought, I don't recall with what message git-rebase
responded, but I do recall that the commit was still on the master
branch.

Derek
