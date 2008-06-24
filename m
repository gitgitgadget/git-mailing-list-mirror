From: "Ben Bennett" <benbennett@gmail.com>
Subject: Re: git status bug problem.
Date: Mon, 23 Jun 2008 21:09:44 -0500
Message-ID: <970bc7c80806231909q1286ddb2h1c97ef3825c7fd5f@mail.gmail.com>
References: <970bc7c80806230619i6c060c4eld329729ec7eef1da@mail.gmail.com>
	 <970bc7c80806230622x326c5cd3mbce57949255a067b@mail.gmail.com>
	 <m3r6aol0u8.fsf@localhost.localdomain>
	 <970bc7c80806231837j19458b80x81063745a2ef40c4@mail.gmail.com>
	 <237967ef0806231849k2aa0c1ebt9f4dee45e2b40896@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 04:10:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAxzV-0005V3-FU
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbYFXCJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYFXCJq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:09:46 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:30176 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbYFXCJp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:09:45 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2018398wri.5
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 19:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kUpojBzh9rQfuXN5LZS9Qc3THrfAnJJ2h1wbfKkqSG8=;
        b=w+RohoG7XCBFgMuyJ+tzaPIZaxtkWiv8GGX1M7j7XubIEP6UZCDD32HV3XKHIE7+53
         T/bHotugxfrZPhmXXgZVUpUgs4W4tC5BlFkHKkVCzv7WkJLfD85EgDppLfc5wmlJcdiJ
         uvdBMsUuh1RT9ZE28PfkIr5sFlS1flE6NJ7lY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PzDncek8Rn1zbWzr1g9CExwV3fodKCNyLPoY51xmI6WnZyLTbUZ7dNAPjRkN4zEhXO
         DHxIP3ICMiXie4kARaASF40WCJFYBX55TxlLFf9oWxjAu80QV9NbYnPvKwzAbXkoa7WQ
         qN3SGA6Tlc5I+l0wF6Rgc1Vh7SkAm3CihhX3w=
Received: by 10.90.87.7 with SMTP id k7mr10997617agb.27.1214273384588;
        Mon, 23 Jun 2008 19:09:44 -0700 (PDT)
Received: by 10.90.32.7 with HTTP; Mon, 23 Jun 2008 19:09:44 -0700 (PDT)
In-Reply-To: <237967ef0806231849k2aa0c1ebt9f4dee45e2b40896@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85967>

Nope, it was an blank test repo .
Did git init
git add *
(which added a few text files)
did git commit -m "just a test"
Modified the file , did git status and I get nothing . git-gui
displays nothing . I think I hosed up something , either some dynamic
lib or something.
doing git status * gives me the files.


On Mon, Jun 23, 2008 at 8:49 PM, Mikael Magnusson <mikachu@gmail.com> wrote:
> 2008/6/24 Ben Bennett <benbennett@gmail.com>:
>> I made the initial commit.  git-gui doesn't return anything either.
>> Something tells me it isn't getting the cwd. Add git status *  it will
>> work correctly , but git-gui doesn't give anything.
>>
>> somewhere@something:~/git_test$ git status
>> # On branch master
>> nothing to commit (working directory clean)
>>
>> somewhere@something:~/git_test$ git status *
>> # On branch master
>> # Changes to be committed:
>> #   (use "git reset HEAD <file>..." to unstage)
>> #
>> #       modified:   test/test2.txt
>> #
>> Thanks,
>> Ben
>
> The file isn't by chance matched by a git ignore rule somewhere? An easy
> way to check is to try and git add the file, it will say you have to use
> -f if it does.
>
> --
> Mikael Magnusson
>
